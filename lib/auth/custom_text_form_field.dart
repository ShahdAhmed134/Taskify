import 'package:flutter/material.dart';
import 'package:to_do_app/app_color.dart';
typedef myValidator = String? Function(String?)? ;
class CustomTextFormField extends StatelessWidget {
  String text;
  bool obscureText;
 /// String? Function(String?)? validator; ( OR )
  myValidator validator;
  Widget preIcon;
  Widget? suffIcon;
  TextEditingController controller;
  TextInputType keyboardType;
  CustomTextFormField({required this.text,this.obscureText=false,required this.validator,
    required this.controller,required this.preIcon,
    this.keyboardType=TextInputType.text,
  this.suffIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        obscuringCharacter: '*',
        keyboardType: keyboardType,
        decoration:  InputDecoration(
          contentPadding: EdgeInsets.only(top: 13),
          prefixIcon: preIcon,
          suffixIcon: suffIcon,
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade400
            )
          ),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  width: 1,
                  color:  Colors.grey.shade400
              )
          ),
          errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  width: 1,
                  color: AppColors.redColor
              )
          ),
          focusedErrorBorder:UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  width: 1,
                  color: AppColors.redColor
              )
          ),
          hintText: text ,
          hintStyle : TextStyle(

            color: Color(0xff6C7278)
      ),



        ),
        validator: validator,

      ),

    );
  }
}
/*
*  decoration: BoxDecoration(
          color: Colors.white, // لون الخلفية للـ TextField
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400, // لون الظل
              spreadRadius: 1, //مدى انتشار الظل
              blurRadius: 8, //نُعومة الظل
              offset: Offset(3, 3), // اتجاه الظل: يمين وأسفل
            ),
          ],
        ),*/