import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: TextFormField(
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFEEEEEE),
                hintText: 'email',

                hintStyle: const TextStyle(color: Color(0xFFA4A4A4)),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xFFEEEEEE),
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              validator:
              EmailValidator(errorText: "من فضلك ادخل بريد الكتروني صحيح"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right:25),
            child: TextFormField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFEEEEEE),
                  hintText:  'password',
                  hintStyle: const TextStyle(color: Color(0xFFA4A4A4)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 2, color: Color(0xFFEEEEEE)), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: MultiValidator([
                  RequiredValidator(errorText: "* يجب ادخال كلمه السر "),
                  MinLengthValidator(6,
                      errorText: "كلمه السر يجب ان تكون ٦ احرف على الاقل"),
                ])),
          ),

          Padding(padding: EdgeInsets.only(right: 30), child:

          Align(
            alignment: Alignment.centerRight,
            child:
            TextButton(
                onPressed: null,
                child: Text(
                  'forgot your password',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE1A31E),
                  ),
                )) ,
          ),),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              style: ButtonStyle(
                minimumSize:
                MaterialStateProperty.all<Size>(const Size.fromHeight(70)),
                shadowColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(4),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF195D81), Color(0xFF009AC7)],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 70, // Adjust the height of the container as needed
                    child: Center(
                      child: Text(
                     "SignIn",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
