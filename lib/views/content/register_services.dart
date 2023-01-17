import 'package:enne_barbearia/app.dart';
import 'package:enne_barbearia/views/content/content_page.dart';
import 'package:enne_barbearia/views/content/register_date.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterService extends StatefulWidget {
  const RegisterService({super.key});

  @override
  State<RegisterService> createState() => _RegisterServiceState();
}

class _RegisterServiceState extends State<RegisterService> {

  final dropValue = ValueNotifier('');
  final dropOpcoes = ['Corte','barba','corte e barba'];

  final ButtonStyle theme_button_general = ElevatedButton.styleFrom(
      backgroundColor: AppColors.secundaryColor,
      //minimumSize: Size(30, 15),
      fixedSize: Size(50, 25),
      padding: EdgeInsets.all(12),
      /*shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),*/
  );
  // ignore: prefer_const_constructors
  final style_text = TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor
                  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("1 - Serviço"), 
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.primaryColor,
      body: Container(
        child: ListView(
        children: [
          /*
          Container(
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.only(top:100.0, left: 50.0),
              child: const Text(
                '1 - Serviço',
                style: TextStyle(
                  fontSize: 30,
                  color: AppColors.textColor
                  )
                ),
              ),
            ),*/
          SizedBox(height: 100,),
          Center(
            child: ValueListenableBuilder(
              valueListenable: dropValue,
              builder: (BuildContext context,String  value, _){
                return SizedBox(
                  width: 280,
                  child:DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: const Text('Selecione corte',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor
                    )
                  ),
                  decoration:InputDecoration(
                    filled: true,
                    fillColor: AppColors.textColor,
                    //fillColor: ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    )
                  ),
                  value: (value.isEmpty) ? null : value,
                  onChanged: (escolha) => dropValue.value = escolha.toString(),
                  items: dropOpcoes.map((op) => DropdownMenuItem(
                    value: op,
                    child: Text(op,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.primaryColor
                        )
                      ),
                    ),
                  ).toList(),
                ),
                );
              }),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(35)),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                minimumSize: Size(125, 40), 
                //padding: EdgeInsets.only(left: 20)
              
              ),
              onPressed: () {
                //BOTÃO VOLTAR ...
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ContentPage()),
                );
              },
              child: const Text(
                'Voltar',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor
                  )
                ),
              ),
              SizedBox(width: 25,),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secundaryColor,
                minimumSize: Size(100, 40), 
              ),
              onPressed: () {
                // CONTINUAR AGENDAMENTO ...
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterDate()),
                );
              },
              child: const Text(
                'Prosseguir',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textColor
                  )
                ),
              ),
            ],
          )
          ]
        )
      )
    );
  }
}