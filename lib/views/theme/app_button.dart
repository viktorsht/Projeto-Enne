import 'package:flutter/material.dart';
class ButtonTheme{
  raisedButtonStyle(){
    final ButtonStyle raisedButtonStyle_theme = ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      minimumSize: Size(100, 50),
      padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}