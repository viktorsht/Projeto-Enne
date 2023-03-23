import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  static const _vitorSantosUrl = 'https://github.com/viktorsht';
  static const _texto = "Se você precisar de ajuda ou tiver alguma dúvida sobre o nosso aplicativo, visite nosso site para obter mais informações. Você também pode entrar em contato conosco diretamente através do nosso e-mail de suporte.";

  Future<void> _launchUrl(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda'),
        backgroundColor: AppColors.secundaryColor,
      ),
      body: Container(
        color: AppColors.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                _texto,
                style: TextStyle(fontSize: 25, color: AppColors.textColor),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => _launchUrl(_vitorSantosUrl),
                child: const Text(
                  'Feito por Vitor Santos',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
