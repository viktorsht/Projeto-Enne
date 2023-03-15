import 'dart:convert';
import 'package:enne_barbearia/views/admin/modal.dart';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';

class Service {
  final String id;
  late final String name;
  late final String duration;
  late final String price;

  Service({required this.id, required this.name, required this.price, required this.duration});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      duration: json['duration'],
    );
  }
}

class EditServices extends StatefulWidget {
  const EditServices({super.key});

  @override
  _EditServicesState createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {
  List<Service> products = [];

  Future<List<Service>> fetchProducts() async {
    String apiUrl = "${DataApi.urlBaseApi}service";
    final response = await http.get(Uri.parse(apiUrl));
    ///print(response);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData['data']);
      return List<Service>.from(jsonData['data'].map((json) => Service.fromJson(json)));
    } else {
      throw Exception('Failed to load products');
    }
 }


  @override
  void initState() {
    super.initState();
    fetchProducts().then((value) => setState(() => products = value));
  }

  Future<Service?> _atualizarServico(BuildContext context, Service service) async {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: service.name);
  final TextEditingController durationController = TextEditingController(text: service.duration);
  final TextEditingController priceController = TextEditingController(text: service.price);

  return await showDialog<Service>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Editar serviço'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O nome é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duração',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A duração é obrigatória';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Preço',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'O preço é obrigatório';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Atualizar'),
            onPressed: () async {
            },
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Serviços'),
        centerTitle: true,
        backgroundColor: AppColors.secundaryColor,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name, style: const TextStyle(color: AppColors.textColor),),
            subtitle: Text('Valor: R\$${product.price}  Duração: ${product.duration}', style: const TextStyle(color: AppColors.textColor),),
            //trailing: Text('#${product.id}'),
            onTap: () {
              _atualizarServico(context, product);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secundaryColor,
        onPressed: () {
        //BottomSheetApp

      }, 
      child: const Icon(Icons.add),
      ),
    );
  }
}