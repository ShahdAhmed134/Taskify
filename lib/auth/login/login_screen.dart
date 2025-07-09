import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';
import 'package:to_do_app/auth/register/register_screen.dart';
import 'package:to_do_app/dialog_utils.dart';

import '../../home_screen.dart';
class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState=GlobalKey();

  bool obscurePass=true;
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor,
                  AppColors.backgroundLight,
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.9,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.whiteColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.04,),
                  Text(
                    'Welcome Back',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,),
                  Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text('Email',
                            style: TextStyle(
                                color: Color(0xff6C7278)
                            ),),
                        ),
                        CustomTextFormField(text: 'Shahd@example.com',
                          preIcon: Icon(Icons.email_outlined, color: Colors
                              .grey,),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'Enter Your Email';
                            }
                            final bool emailValid =
                            RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~!]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text);
                            if (!emailValid) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text('Password',
                            style: TextStyle(
                                color: Color(0xff6C7278)
                            ),),
                        ),
                        CustomTextFormField(text: '******',
                          obscureText: obscurePass,
                          preIcon: Icon(
                            Icons.lock_outline_rounded, color: Colors.grey,),
                          suffIcon: IconButton(
                            icon: Icon(
                              obscurePass ? Icons.visibility_off : Icons
                                  .visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePass =
                                !obscurePass; // تقلب بين الإظهار والإخفاء
                              });
                            },
                          ),
                          controller: passwordController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return 'Enter Your Password';
                            }
                            if (text.length < 6) {
                              return 'Password Must be at least 6 character';
                            }
                            return null;
                          },),
                        SizedBox(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.06,),
                        Padding(

                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: Text('Login'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: AppColors.whiteColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            }, child: Text('or Creat Account ?',
                          style: TextStyle(
                              color: AppColors.primaryColor
                          ),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void login() async{
    if(formState.currentState!.validate()){
      //todo: show Loading
      DialogUtils.showLoading(context);
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMassage(context: context, title: 'success',
            content: 'Login Successfully',
            posActionName: 'OK',
            posAction: (){
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMassage(context: context, title: 'Error!',
            content: 'No user found for that email or Wrong Password.',
            posActionName: 'OK',
          );
          print('No user found for that email or Wrong Password.');
        }
        else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMassage(context: context, title: 'Error!',
            content: ' A network error has occurred',
            posActionName: 'OK',
          );


        }
      }catch(e){

        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMassage(context: context, title: 'Error!',
          content: e.toString(),
          posActionName: 'OK',
        );

        print(e);
      }
    }
  }

}

