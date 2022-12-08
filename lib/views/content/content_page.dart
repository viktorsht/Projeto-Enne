import 'package:enne_barbearia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bakccolor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){}, 
            child: Text(
              'ENNE',
              style: TextStyle(fontSize: 30, color: AppColors.black54),
            )
          )
        ],
        backgroundColor: AppColors.red,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.red,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Inicio'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Agendamento Online'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Sobre a barbearia'
          ),
        ],
      selectedItemColor: Colors.red[800],
      ),
    );
  }
}