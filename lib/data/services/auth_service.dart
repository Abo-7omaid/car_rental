import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';

class AuthServices {
  final SupabaseClient _client = Supabase.instance.client;
  // Get current user
  User? get currentUser => _client.auth.currentUser;

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;

  // Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'phone': phone},
      );

      // Create user profile in 'users' table
      if (response.user != null) {
        await _client.from('users').insert({
          'id': response.user!.id,
          'name': name,
          'email': email,
          'phone': phone,
        });
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // Get user profile from 'users' table
  Future<UserModel?> getUserProfile() async {
    try {
      if (currentUser == null) return null;

      final response = await _client
          .from('users')
          .select()
          .eq('id', currentUser!.id)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Update user profile
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    if (currentUser == null) return;

    await _client
        .from('users')
        .update({'name': name, 'phone': phone})
        .eq('id', currentUser!.id);
  }
}

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  bool get isLoggedIn => currentUser != null;




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

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {


    final response = await _client.auth.signInWithPassword(
        email: email,
        password: password
    );

    return response;

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
      print('Error fetching the user $e');
      return null;
    }


  }














}
