import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api.dart';

class RegisterDateController{
  Future<List<String>> getDateActiveApi() async {
    var url = '${DataApi.urlBaseApi}dayActive';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body)['data'];
      List<String> dateList = [];

      for (var data in responseData) {
        dateList.add(data['status']); // pega os status do dia
      }
      return dateList;
    } else {
      throw Exception('Requisição falida');
    }
  }
}