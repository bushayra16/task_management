import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/ui/Screens/password_set_screen.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class ForgotOtpScreen extends StatefulWidget {
  const ForgotOtpScreen({super.key});

  @override
  State<ForgotOtpScreen> createState() => _ForgotOtpScreenState();
}

class _ForgotOtpScreenState extends State<ForgotOtpScreen> {
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
                  Text('Pin Verification', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                  const SizedBox(height: 8,),
                  Text('A 6 Digit Verification PIN has been sent to your email address', style: textTheme.bodyMedium?.copyWith(fontSize: 15,color: Colors.grey),),
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
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      // activeColor: Colors.grey,
                      inactiveFillColor: Colors.white,
                      // inactiveColor: Colors.grey,
                      selectedFillColor: Colors.white
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    appContext: context,
                  ),
                  const SizedBox(height: 15,),
                  ElevatedButton(onPressed: _onTapNextPage,
                    child: const Text('Verify'),
                  ),

                ],
              );

  }
  void _onTapNextPage () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PasswordSetScreen()));
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
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (_)=> false);
  }

}


