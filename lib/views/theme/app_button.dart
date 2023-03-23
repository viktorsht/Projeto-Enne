import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonApp{

  static ButtonStyle themeButtonAppPrimary = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: const Size(130, 50),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );

  static ButtonStyle themeButtonAppSecundary = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: const Size(100, 50),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );

  static ButtonStyle themeButtonSmall = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: const Size(100, 40),
    );

  static ButtonStyle themeButtonViewUpdate = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 30),
    );
}