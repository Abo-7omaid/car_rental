import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../../core/constants/app_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';


class AuthResult {
  final bool isSuccess;
  final String message;

  AuthResult({required this.isSuccess, required this.message});
}


class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  bool get isLoggedIn => currentUser != null;

  static UserModel? UserInfo;


  // دالة تحميل البيانات من ذاكرة الهاتف (Hive)
  static void loadCachedUser() {
    var box = Hive.box('userBox');
    if (box.containsKey('name')) {
      UserInfo = UserModel(
        id: box.get('id', defaultValue: ''),
        name: box.get('name', defaultValue: 'Guest'),
        email: box.get('email', defaultValue: ''),
        phone: box.get('phone', defaultValue: ''),
      );
    }
  }




  Future<AuthResponse> signUp({
    required String name,
    required String password,
    required String phone,
    required String email,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'phone': phone},
      );

      if (response.user != null) {
        await _client.from('profiles').insert({
          'id': response.user!.id,
          'email': email,
          'name': name,
          'phone': phone,
        });
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }



  Future<AuthResponse> signInWithGoogle() async {

   try{

     final scopes = ['email', 'profile'];

     final GoogleSignIn googleSignIn =  GoogleSignIn.instance;

     await googleSignIn.initialize(
       serverClientId: AppConfig.webGoogleClientId,
       clientId: AppConfig.iosGoogleClientId,
     );

     final googleUser = await googleSignIn.authenticate();

     debugPrint(googleUser.toString());



     final authorization =
         await googleUser.authorizationClient.authorizationForScopes(scopes) ??
             await googleUser.authorizationClient.authorizeScopes(scopes);



     final idToken = googleUser.authentication.idToken;

     debugPrint(idToken);

     if (idToken == null) {
       return AuthResponse();

       throw AuthException('No ID Token found.');
     }



    final response= await _client.auth.signInWithIdToken(
       provider: OAuthProvider.google,
       idToken: idToken,
       accessToken: authorization.accessToken,
     );

     return response;



   } catch(e){
     rethrow;

   }





  }





  Future<AuthResult> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(email: email, password: password);
      return AuthResult(isSuccess: true, message: 'Welcome back!');
    } on AuthException catch (e) {

      String customMessage = 'An unexpected error occurred';

      if (e.message.contains('Invalid login credentials')) {
        customMessage = 'Incorrect email or password.';
      } else if (e.message.contains('Email not confirmed')) {
        customMessage = 'Please verify your email before logging in.';
      }

      UserInfo = await getUserProfile();


      return AuthResult(isSuccess: false, message: customMessage);
    } catch (e) {
      return AuthResult(isSuccess: false, message: 'Check your internet connection.');
    }
  }





  Future<void> signOut() async {
    await _client.auth.signOut();
  }



  Future<UserModel?> getUserProfile() async {

    if (currentUser == null) return null;

    try{
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', currentUser!.id)
          .single();
      return UserModel.fromJson(response);

    } catch(e){
      return null;
    }


  }




  // ميزة إرسال رابط إعادة تعيين كلمة المرور للبريد الإلكتروني
  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        // هذا السطر هو الذي يجعل الميزة احترافية، حيث يوجه المستخدم
        // للعودة لتطبيقك فور الضغط على الرابط في بريده.
        redirectTo: 'io.supabase.flutter://reset-callback/',
      );
    } catch (e) {
      rethrow; // نترك الخطأ يظهر لكي نقوم بعرضه في الـ SnackBar لاحقاً
    }
  }


  // دالة تحديث بيانات المستخدم (الاسم والهاتف)
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (currentUser == null) return;

    try {
      // 1. تحديث البيانات في قاعدة بيانات سوبابيس
      await _client
          .from('profiles')
          .update({'name': name, 'phone': phone})
          .eq('id', currentUser!.id);

      // 2. تحديث البيانات محلياً في التطبيق لكي تظهر التغييرات فوراً
      UserInfo = await getUserProfile();

    } catch (e) {
      rethrow;
    }
  }








}

