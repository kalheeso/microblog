import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorFeed.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/screens/TelaCadastro.dart';
import 'package:microblog/screens/TelaPerfil.dart';
import 'package:microblog/screens/TelaPrincipal.dart';
import 'package:microblog/screens/TelaSplash.dart';
import 'package:microblog/servicos/ServicoMicroblog.dart';

import 'screens/TelaLogin.dart';

final getIt = GetIt.instance;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton(ServicoMicroblog(Dio()));
  getIt.registerSingleton(ControladorUsuario());
  getIt.registerSingleton(ControladorFeed());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App do Matheus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (_) => TelaSplash(),
        "/telaLogin": (_) => TelaLogin(),
        "/telaPrincipal": (_) => TelaPrincipal(),
        "/telaDeCadastro": (_) => TelaDeCadastro(),
        "/telaPerfil": (_) => TelaPerfil()
      },
    );
  }
}
