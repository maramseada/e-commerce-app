
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task1/Screens/signup_Screen.dart';
import 'package:task1/helper/api.dart';

import '../utilities/navigator.dart';
import '../utilities/shared_pref.dart';
import '../utilities/userprofile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});
  static String id = 'ProfilePage';
  UserProfile? currentUserProfile;
  final _api = Api();
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF195D81),
        title: Text('Account info'),
centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
       child:       ElevatedButton(

                onPressed: () { logout(); },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color(0xFF195D81),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            50)))),
                child: Text('Logout', style: TextStyle(fontSize: 16.sp),),
              )
          )
      ),
    );
  }
  void logout() async {
    await Api().logout();
    await removeString('type');
    await removeString('token');
    navigateWithoutHistory(context, SignUpScreen());
  }
}


