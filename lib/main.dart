import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Screens/favorites_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/login_Screen.dart';
import 'Screens/product_page.dart';
import 'Screens/profilepage.dart';
import 'Screens/signup_Screen.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       routes: {
         SignUpScreen.id:(context) => SignUpScreen(),
         HomePage.id:(context) => HomePage(),
         ProductPage.id:(context) => ProductPage(),
         '/Login':(context) => LoginScreen(),
        // '/Favorites':(context) => FavoritesScreen(),


         '/profile': (context) => ProfilePage(),
       },

       initialRoute:SignUpScreen.id,
     )
      );

  }
}
