import 'package:enne_barbearia/app.dart';
import 'package:enne_barbearia/core/theme/app_colors.dart';
import 'package:enne_barbearia/views/content/navigation_bar.dart';
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
      drawer: const NavBar(),
      appBar: AppBar(
        title: Text('Enne'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person))
        ],
      ),
    );
  }
}