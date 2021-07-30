import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/TextFieldPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

import 'TelaPrincipal.dart';

class TelaDeCadastro extends StatefulWidget {
  const TelaDeCadastro({Key key}) : super(key: key);

  @override
  _TelaDeCadastroState createState() => _TelaDeCadastroState();
}

class _TelaDeCadastroState extends State<TelaDeCadastro> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  Usuario _usuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create an account"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Wrap(spacing: 15, runSpacing: 15, children: [
                      Text("Sign up now"),
                      Divider(),
                      TextFieldPadrao(
                        titulo: "E-mail",
                        onChanged: (text) {
                          _usuario.email = text;
                        },
                      ),
                      TextFieldPadrao(
                        titulo: "Full name",
                        onChanged: (text) {
                          _usuario.nome = text;
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
                      BotaoPadrao(
                        title: "Sign up",
                        onPressed: () {
                          _controladorUsuario.cadastrarUsuario(_usuario,
                              sucesso: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_) => TelaPrincipal(usuario: _usuario,)));
                          }, erro: (mensagem) {
                            UtilDialog.exibirInformacao(context,
                                titulo: "Ops!", mensagem: mensagem);
                          });
                        },
                      )
                    ])))
          ],
        ),
      ),
    );
  }
}
