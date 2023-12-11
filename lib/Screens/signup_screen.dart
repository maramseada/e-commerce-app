import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:task1/Screens/profilepage.dart';

import '../helper/api.dart';
import '../models/User.dart';
import '../utilities/navigator.dart';
import '../utilities/userprofile.dart';
import 'home_screen.dart';
import 'login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSigningUp = false;
  final _api = Api();
  String error = '';
  bool passwordVisible = true;
  bool passwordVisible2 = true;
  String? phoneNumber;
  List<String> errors = [];
  final _formKey = GlobalKey<FormState>();
  late User user;
  UserProfile? currentUserProfile;
  var name;
  var email;
  var phone;
  TextEditingController euController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h,),
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
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: euController,
                          decoration: InputDecoration(
                            hintText: 'email',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          validator:
                          EmailValidator(errorText: "Enter valid email id"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: IntlPhoneField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            hintText: ' Phone number ',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              fontFamily: 'Cairo',
                            ),
                          ),
                          onChanged: (phone) {
                            phoneNumber = phone.completeNumber;
                          },
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
                                  errorText:
                                  "Password should be atleast 6 characters"),
                            ])),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ElevatedButton(
                          onPressed: isSigningUp ? null : () => signup(),
                          child: isSigningUp
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )

                              : Text(
                            'Signup',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Color(0xFF195D81),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/Login');
                        },
                        child: Text('Login', style: TextStyle(fontSize: 16.sp),),
                      ),
                    ),
                  ],),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  void signup() async {
    User user = User(
      name: nameController.text,
      phone: phoneController.text,
      email: euController.text,
      password: passwordController.text,
    );

    setState(() {
      isSigningUp = true;
      name = nameController.text;
      phone = phoneController.text;
      email = euController.text;
    });

    try {
      Map<String, dynamic>? response = await _api.register(user);

      if (response != null && response['status'] == true) {
        setState(() {
          ProfilePage().currentUserProfile = currentUserProfile;
        });
        navigateWithoutHistory(context, HomePage());
      } else {
        if (response != null && response['message'] != null) {
          setState(() {
            if (response['message'] is String) {
              errors = [response['message']];
            } else if (response['message'] is List<dynamic>) {
              errors = response['message'].cast<String>();
            }
            isSigningUp = false;
          });
        }
      }
    } catch (e) {
      print('Network Error: $e');
      setState(() {
        errors = ['Network error occurred. Please check your connection.'];
        isSigningUp = false;
      });
    }
  }
}
