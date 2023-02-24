import 'package:enne_barbearia/views/content/navigation.dart';
import 'package:enne_barbearia/views/content/register_services.dart';
import 'package:enne_barbearia/views/content/profile_screen.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';


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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
  );


    return Scaffold(
      //bakccolor: AppColors.primaryColor,
      backgroundColor: AppColors.primaryColor,
      drawer: Navigation(),
      appBar: AppBar(
        title: const Text('Enne'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen()));
          }, icon: Icon(Icons.person))
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
                  fontSize: 25,
                  color: AppColors.textColor
                  )
                ),
              ),
            ),
            /*
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
              ),*/
          ]
        )
      ),
    );
  }
}