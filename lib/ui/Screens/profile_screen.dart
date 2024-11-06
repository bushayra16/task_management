import 'package:flutter/material.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/widgets/app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const  TMAppbar(
        isProfileScreenOpen: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48,),
              Text('Update Profile', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              _buildProfileUpdateForm()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildProfileUpdateForm() {

    return Column(
      children: [
        _buildPhotoPicker(),
        const SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Email',
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: 'First Name',
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: 'Last Name',
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              hintText: 'Password'
          ),
        ),
        const SizedBox(height: 8,),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Mobile',
          ),
        ),
        const SizedBox(height: 24,),
        ElevatedButton(onPressed: _onTapUpdateButton,
          child: const  Icon(Icons.arrow_circle_right_outlined),
        ),
      ],
    );}
  void _onTapUpdateButton () {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (value)=> false);
  }
  Widget _buildPhotoPicker(){
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 100,
            decoration: const  BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))
            ),
            alignment: Alignment.center,
            child: const Text('Photo', style: TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.bold),),
          ),
          const SizedBox(width: 20,),
          const Text('Selected Photo', style: TextStyle(color: Colors.grey),),
        ],
      ),
    );
  }
}
