import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/screens/TelaPrincipal.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/TextFieldPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Wrap(spacing: 15, runSpacing: 15, children: [
                      Text("Log in or create an account"),
                      Divider(),
                      TextFieldPadrao(
                        titulo: "E-mail",
                        onChanged: (text) {
                          _usuario.email = text;
                        },
                      ),
                      TextFieldPadrao(
                        obscureText: true,
                        titulo: "Password",
                        onChanged: (text) {
                          _usuario.senha = text;
                        },
                      ),
                      Container(),
                      Column(
                        children: [
                          BotaoPadrao(
                            backgroundColor: Colors.blue,
                            title: "Login",
                            onPressed: () {
                              _controladorUsuario.logarUsuario(_usuario,
                                  sucesso: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => TelaPrincipal(
                                              usuario: _usuario,
                                            )));
                              }, erro: (mensagem) {
                                UtilDialog.exibirInformacao(context,
                                    titulo: "Ops!", mensagem: mensagem);
                              });
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(child: Divider()),
                              Text("Or"),
                              Expanded(child: Divider())
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          BotaoPadrao(
                            backgroundColor: Colors.blue,
                            title: "Sign up",
                            onPressed: () {
                              Navigator.pushNamed(context, "/telaDeCadastro");
                            },
                          )
                        ],
                      ),
                    ])))
          ],
        ),
      ),
    );
  }
}
