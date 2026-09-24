import 'dart:async';

import 'package:car_rental/my_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_logo.dart';
import '../../../data/services/biometric_service.dart';
import '../../../my_widgets/app_text_field.dart';
import 'package:car_rental/data/services/auth_service.dart';





class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isLoadingGoogle = false;
  int failedAttempt = 0;
  int blockedSeconds = 0;
  Timer? _loginTimer;


  @override
  void dispose() {
    _loginTimer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();

  }


  void _togglePasswordVisibility(){
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _startCountdown() {
    setState(() => blockedSeconds = 30);
    _loginTimer = Timer.periodic( Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (blockedSeconds > 0) {
            blockedSeconds--;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }




  void _login() async {

    if (blockedSeconds > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please wait $blockedSeconds seconds before trying again.')),
      );
      return;
    }


    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);


    final result = await AuthService().signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (result.isSuccess) {
      failedAttempt = 0;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      failedAttempt++;

      if (failedAttempt >= 3) {
        _startCountdown();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Too many failed attempts. Locked for 30 seconds.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _googleSignIn() async {

    setState(() => _isLoadingGoogle = true);


    final authService = AuthService();

    try{


      await authService.signInWithGoogle();

      if(mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }




    } catch (e){
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Google Sign-In failed'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoadingGoogle = false);
      }
    }





  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryDark,
      body: SafeArea(

        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,

              children: [

                SizedBox(height: 60),
                AppLogo(fontSize: 32,),
                SizedBox(height: 60),
                Text(
                  'Welcome back!',
                  style: Theme.of(context).textTheme.headlineMedium
                ),

                SizedBox(height: 8),

            Text(
                  'Sign in to continue',
                style: Theme.of(context).textTheme.titleMedium
                ),

                SizedBox(height: 40,),

                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter your email';

                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }

                    return null;

                  },
                ),

                SizedBox(height: 16),

                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility ,
                    ),
                    onPressed: _togglePasswordVisibility,

                  ),

                  validator: (value){
                    if (value == null || value.isEmpty) return 'Please enter your password';

                    if(value.length < 6) return 'Password must be at least 6 characters';

                    return null;

                  },


                ),

                SizedBox(height: 5),


               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   if (failedAttempt >= 3) timer(context),

                   const SizedBox(width: 1,),



                   Align(
                     alignment: Alignment.centerRight,
                     child: TextButton(
                       child: const Text('Forget password?'), // تم تصحيح الإملاء هنا
                       onPressed: () {
                         Navigator.pushNamed(context, '/forgetPassword'); // الانتقال للشاشة الجديدة
                       },
                     ),
                   ),

                 ],

               ),


                 SizedBox(height: 5),

                PrimaryButton(
                  text: 'Sign In',

                  onPressed: _login,
                  isLoading: _isLoading,



                ),

                SizedBox(height: 24),


                PrimaryButton(
                  text: 'Sign In with Google',

                  onPressed: _googleSignIn,
                  isLoading: _isLoadingGoogle,
                  icon: Icons.mail_lock_outlined,
                  isOutlined: true,


                ),



                SizedBox(height: 24),



                IconButton(
                  icon: Icon(Icons.fingerprint, size: 40,),
                  onPressed: (){
                    BiometricService().authenticateWithBiometrics(context);
                  },

                ),


                SizedBox(height: 24),

                Row(

                  mainAxisAlignment: .center,

                  children: [

                    Text(
                      'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),

                    TextButton(
                      child: Text(
                        'Sign up',
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, '/register');

                        // Navigator.pushReplacementNamed(context, '/register');


                      },
                    ),

                  ],
                ),























              ],

            ),
          ),
        ),
      ),

    );
  }



  Widget timer( BuildContext context){

    return Row(

      children: [
        Text('remaining $blockedSeconds'),
      ],

    );

  }

}


