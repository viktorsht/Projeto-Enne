import 'dart:convert';
import 'package:enne_barbearia/views/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../api.dart';

class Service {
  final String id;
  final String name;
  final String duration;
  final String price;

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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secundaryColor,
        onPressed: () {
        
      }, 
      child: const Icon(Icons.add),
      ),
    );
  }
}
