import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/Screens/forgot_password_otp_screen.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {

  TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 85,),
                  Text('Your Email Address', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 8,),
                  Text('A 6 Digit Verification PIN will send to your email address', style: textTheme.bodyMedium?.copyWith(fontSize: 15,color: Colors.grey),),
                  const SizedBox(height: 12,),
                  _buildVerifyEmailForm(),
                  const SizedBox(height: 45,),
                  Center(
                    child: Column(
                      children: [
                        _buildSignInSection(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildVerifyEmailForm() {
    return Column(
                children: [
                  const SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email'
                    ),
                  ),
                  const SizedBox(height: 15,),
                  ElevatedButton(onPressed: _onTapNextButton,
                    child: const  Icon(Icons.arrow_circle_right_outlined),
                  ),

                ],
              );

  }
  void _onTapNextButton () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotOtpScreen()));
  }
  Widget _buildSignInSection() {
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
    Navigator.pop(context);
  }

}


