import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:task1/Screens/home_screen.dart';
import 'package:task1/helper/api.dart';

import '../utilities/navigator.dart';
import '../utilities/shared_pref.dart';
import '../widgets/login_widgets/continuewith.dart';
import '../widgets/login_widgets/logi_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = false;
  final _api = Api();
  String error = '';
  bool passwordVisible = true;
  List<String> errors = [];
  final _formKey = GlobalKey<FormState>();


  TextEditingController euController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Center(
          child:SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome back! ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF195D81),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: euController,
                          decoration: InputDecoration(
                            hintText: 'email',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          validator: EmailValidator(
                              errorText: "Enter valid email id"),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: passwordController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              hintText: 'password',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(width: 2, color: Colors.grey),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(6,
                                  errorText: "Password should be atleast 6 characters"),

                            ])
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ElevatedButton(
                          onPressed: isLogin ? null : () => login(),

                          child: isLogin
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Color(0xFF195D81),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      50)))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Divider(
                          color: Colors.grey,
                          height: 10,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or continue with'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Divider(
                          color: Colors.grey,
                          height: 10,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ContinueScreen(),
              ],
            ),
          )
        ),
      ),
    );
  }
  void login() async {
    setState(() {
      isLogin = true;
    });

    try {
      Map<String, dynamic>? response = await _api.login(
        euController.text,
        passwordController.text,
      );

      if (response != null) {
        if (response['status'] == true) {

          // Navigate to HomePage

          navigateWithoutHistory(context, HomePage());
          // Set state after navigating
          Future.microtask(() {
            setState(() {
              isLogin = false;
            });
          });
        } else {
          // Check if response['message'] is a String or a List
          if (response['message'] is String) {
            setState(() {
              errors = [response['message']]; // Wrap the String in a List
              isLogin = false; // Set isLogin to false for the failed login attempt
            });
          } else if (response['message'] is List<dynamic>) {
            setState(() {
              errors = response['message'].cast<String>();
              isLogin = false; // Set isLogin to false for the failed login attempt
            });
          }
        }
      }
    } catch (e) {
      // Catch network-related exceptions
      print('Network Error: $e');
      setState(() {
        // Update UI to indicate a network error occurred
        errors = ['Network error occurred. Please check your connection.'];
        isLogin = false;
      });
    }
  }


}