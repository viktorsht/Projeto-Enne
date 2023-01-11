import 'package:enne_barbearia/app.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
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

    final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      minimumSize: Size(100, 50),
      padding: EdgeInsets.symmetric(horizontal: 30),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );


    return Scaffold(
      //bakccolor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryColor,
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Enne'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person))
        ],
      ),
      body: Container(
        child: ListView(
        children: [
        SizedBox(
              width: 150,
              height: 160,
              child: Image.asset('assets/logo.png'),
        ),
        SizedBox(height: 300,),
        Container(
            child: ElevatedButton(
              style: theme_button_general,
              onPressed: () {
                //Cadastro concluído com sucesso
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterService()),
                );
              },
              child: const Text(
                'Agendar agora!',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor
                  )
                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
            child: ElevatedButton(
              style: theme_button_general,
              onPressed: () {
                /*Cadastro concluído com sucesso
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const (RegisterService)),
                );
                */
              },
              child: const Text(
                'Quem Somos',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor
                  )
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}