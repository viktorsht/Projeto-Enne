/*Importações do flutter*/
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

/*Importações do app*/
import 'app.dart';
void main() {
  initializeDateFormatting().then((_) => runApp(const App()));
}
