import 'package:flutter/material.dart';
import 'package:task_management/ui/Screens/profile_screen.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';

import '../controllers/auth_controllers.dart';
import '../utils/app_colors.dart';

class TMAppbar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppbar({
    super.key, this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (isProfileScreenOpen){
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen()));
      },
      child: AppBar(
        backgroundColor: AppColors.themeColor,
        title: (
            Row(
              children: [
                const CircleAvatar(backgroundColor: Colors.white,),
                const SizedBox(width: 15,),
                 const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text('Fatima Tuj Jahra', style: TextStyle(color: Colors.white, fontSize: 16),),
                      Text('Mobile App Developer', style:TextStyle(color: Colors.white, fontSize: 12),)
                    ],
                  ),
                ),
                IconButton(onPressed: () async {
                  await AuthControllers.clearUserData();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (value) => false
                  );
                }, icon: const Icon(Icons.logout))
              ],
            )
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}