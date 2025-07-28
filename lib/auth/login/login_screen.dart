import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_color.dart';
import 'package:to_do_app/auth/custom_text_form_field.dart';
import 'package:to_do_app/auth/register/register_screen.dart';
import 'package:to_do_app/dialog_utils.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/provider/app_config_provider.dart';

import '../../home/home_screen.dart';
import '../../provider/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState=GlobalKey();

  bool obscurePass=true;
  TextEditingController emailController =TextEditingController(text: 'shahd@gmail.com');
  TextEditingController passwordController =TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    var appProvider =Provider.of<AppProvider>(context);
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
                colors:appProvider.modeApp==ThemeMode.light ?
                [
                  AppColors.primaryColor,
                  AppColors.backgroundLight,
                ]: [
                  AppColors.primaryColor,
                  AppColors.backgroundDark,
                ]

              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
              color : appProvider.modeApp==ThemeMode.light ?
            AppColors.whiteColor
                :
                AppColors.backgroundDark
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.04,),
                  Text(
                    AppLocalizations.of(context)!.welcome,
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
                          child: Text(AppLocalizations.of(context)!.email,
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color:  appProvider.modeApp==ThemeMode.light ?
                                Color(0xff6C7278)
                                    :
                                Color(0xffc4c4c4)
                            )


                            ),
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
                          padding: const EdgeInsets.only(left: 12.0,top: 15),
                          child:  Text(AppLocalizations.of(context)!.password,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color:  appProvider.modeApp==ThemeMode.light ?
                                  Color(0xff6C7278)
                                      :
                                  Color(0xffc4c4c4)
                              )


                          ),
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
                            child: Text(AppLocalizations.of(context)!.login),
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
                            }, child: Text(AppLocalizations.of(context)!.orCreate,
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
       var user= await FirebaseUtils.getUserFromFireStore(credential.user!.uid??'');
       if(user==null){
         return;
       }
        UserAuthProvider authProvider=Provider.of<UserAuthProvider>(context,listen: false);
        authProvider.updateUser(user);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMassage(context: context, title: AppLocalizations.of(context)!.success,
            content: AppLocalizations.of(context)!.loginSuccess,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: (){
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMassage(context: context, title: AppLocalizations.of(context)!.error,
            content:AppLocalizations.of(context)!.noUser,
            posActionName: AppLocalizations.of(context)!.ok,
          );
         /// print('No user found for that email or Wrong Password.');
        }
        else if (e.code == 'network-request-failed') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //todo: show message
          DialogUtils.showMassage(context: context, title:AppLocalizations.of(context)!.error,
            content: AppLocalizations.of(context)!.networkError,
            posActionName: AppLocalizations.of(context)!.ok,
          );


        }
      }catch(e){

        //todo: hide loading
        DialogUtils.hideLoading(context);
        //todo: show message
        DialogUtils.showMassage(context: context, title: AppLocalizations.of(context)!.error,
          content: e.toString(),
          posActionName:AppLocalizations.of(context)!.ok,
        );

        print(e);
      }
    }
  }

}

