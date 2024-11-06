import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/model/login_model.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/Screens/forgot_password_email.dart';
import 'package:task_management/ui/Screens/main_bottom_nav_bar.dart';
import 'package:task_management/ui/Screens/sign_up_screen.dart';
import 'package:task_management/ui/controllers/auth_controllers.dart';
import 'package:task_management/ui/utils/app_colors.dart';
import 'package:task_management/ui/widgets/circular_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_msg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _inProgress = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                Text('Get Started With', style: textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
                _buildSignInForm(),
                const SizedBox(height: 24,),
                Center(
                  child: Column(
                    children: [
                      TextButton( onPressed: _onTapForgotPassword,
                          child: const Text('Forgot Password?', style: TextStyle(
                            color: Colors.grey
                          ),)),
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

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _emailController,
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return ('Enter your valid email address');
              }else{
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                hintText: 'Email',
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _passwordController,
            validator: (String? value){
              if (value?.isEmpty ?? true){
                return ('Enter your valid password');
              }
              if (value!.length <=6){
                return('Enter a password more than 6 letters');
              }
              return null;
            },
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Password'
            ),
          ),
          const SizedBox(height: 24,),
          Visibility(
            visible: !_inProgress,
            replacement: const CenterCircularIndicator(),
            child: ElevatedButton(onPressed: _onTapLoginButton,
              child: const  Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );

  }
  void _onTapLoginButton () {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _signIn();
  }

  Future <void> _signIn () async{
   _inProgress = true;
   setState(() {});

   Map<String, dynamic> loginData = {
     'email': _emailController.text.trim(),
     'password': _passwordController.text,
   };

   final NetworkResponse response = await NetworkCaller.postRequest(
       url: Urls.login, body: loginData);
   _inProgress = false;
   setState(() {});
   if (response.isSuccess){
     LoginModel loginModel = LoginModel.fromJson(response.statusData);
     await AuthControllers.saveAccessToken(loginModel.token!);
     await AuthControllers.saveUserData(loginModel.data!);

     Navigator.pushAndRemoveUntil(context,
         MaterialPageRoute(builder: (context) => const BottomNavBar()), (
             value) => false);

   } else {
     showSnackBarMessage(context, response.errorMessage, true);
   }
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
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            color: AppColors.themeColor
                          ),
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()..onTap = _onTapSignUpButton

                        )
                      ]
                    )
                    );
  }
  void _onTapSignUpButton () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }
  void _clearTextFields () {
    _emailController.clear();
    _passwordController.clear();

  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}


