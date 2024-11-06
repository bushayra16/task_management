import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/Screens/forgot_password_email.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/Screens/sign_up_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class PasswordSetScreen extends StatefulWidget {
  const PasswordSetScreen({super.key});

  @override
  State<PasswordSetScreen> createState() => _PasswordSetScreenState();
}

class _PasswordSetScreenState extends State<PasswordSetScreen> {
  @override
  Widget build(BuildContext context) {

  TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 85,),
                Text('Set Password', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                Text('Minimum length password 8 character with Letter and number combination', style: textTheme.bodyMedium?.copyWith(fontSize: 15,color: Colors.grey),),
                const SizedBox(height: 20,),
                _buildResetPasswordForm(),
                const SizedBox(height: 24,),
                Center(
                  child: Column(
                    children: [

                      _buildSignUpSection(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
              hintText: 'Password',
          ),
        ),
        const SizedBox(height: 10,),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: 'Confirm Password'
          ),
        ),
        const SizedBox(height: 24,),
        ElevatedButton(onPressed: _onTapLoginButton,
          child: const  Text('Confirm'),
        ),
      ],
    );

  }
  void _onTapLoginButton () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (_)=> false);
  }
  void _onTapForgotPassword () {
   Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationScreen()));
  }
  Widget _buildSignUpSection() {
    return RichText(text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.5
                      ),
                      text: "Have account? ",
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            color: AppColors.themeColor
                          ),
                          text: 'Sign In',
                          recognizer: TapGestureRecognizer()..onTap = _onTapSignIn

                        )
                      ]
                    )
                    );
  }
  void _onTapSignIn () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }
}


