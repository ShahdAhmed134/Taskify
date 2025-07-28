import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class ThemeApp{
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
      appBarTheme: AppBarTheme(
          color: AppColors.primaryColor,
       iconTheme: IconThemeData(
         color: AppColors.whiteColor,
         size: 30
       )
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      splashColor: Colors.transparent,      // لمنع الـ splash effect
      highlightColor: Colors.transparent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grayColor,
        showUnselectedLabels: false,

      ),

      floatingActionButtonTheme:  FloatingActionButtonThemeData(
        backgroundColor:AppColors.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
              side: BorderSide(color: AppColors.whiteColor, width: 4)),
      ),

      bottomSheetTheme: BottomSheetThemeData(

        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(20),
            topRight:Radius.circular(20),
          ),

        ),

      ),

      textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
              color: AppColors.whiteColor,
              fontSize: 22,
              fontWeight: FontWeight.bold
          ),
          titleSmall: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
         labelMedium: GoogleFonts.cabin(
            color: AppColors.grayColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
        labelLarge:  GoogleFonts.poppins(
            color: AppColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
        labelSmall:  GoogleFonts.roboto(
            color: AppColors.blackTime,
            fontSize: 12,
            fontWeight: FontWeight.w400
        ),
      )
  );
  static final ThemeData darkTheme = ThemeData(
      appBarTheme: AppBarTheme(
          color: AppColors.primaryColor
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      splashColor: Colors.transparent,      // لمنع الـ splash effect
      highlightColor: Colors.transparent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grayColor,
        showUnselectedLabels: false,

      ),
      floatingActionButtonTheme:  FloatingActionButtonThemeData(
        backgroundColor:AppColors.primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
            side: BorderSide(color: AppColors.whiteColor, width: 4)),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(20),
            topRight:Radius.circular(20),
          ),

        ),

      ),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
        titleSmall: GoogleFonts.poppins(
            color: AppColors.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
        labelMedium: GoogleFonts.cabin(
            color: AppColors.grayColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
        labelLarge:  GoogleFonts.poppins(
            color: AppColors.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),
        labelSmall:  GoogleFonts.roboto(
            color: AppColors.blackTime,
            fontSize: 12,
            fontWeight: FontWeight.w400
        ),
      )
  );
}