import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/UtilDialog.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({Key key}) : super(key: key);

  @override
  _TelaPerfilState createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60, 25, 60, 25),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(210),
                      child: Image.asset(
                        "assets/images/imagem.jpg",
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.person_outlined,
                          size: 28,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${_controladorUsuario.usuarioLogado.nome}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                              fontSize: 22),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.alternate_email_outlined,
                          size: 28,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("${_controladorUsuario.usuarioLogado.email}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontSize: 22)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              heightFactor: 3.0,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    width: 200,
                    child: BotaoPadrao(
                      backgroundColor: Colors.red,
                      onPressed: () {
                        _controladorUsuario.deletarDoPrefs();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/telaLogin', (Route<dynamic> route) => false);
                      },
                      title: "Logout",
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    width: 200,
                    child: BotaoPadrao(
                      backgroundColor: Colors.blueAccent,
                      onPressed: () {
                        UtilDialog.mudarSenha(
                            context, _controladorUsuario.usuarioLogado);
                      },
                      title: "Change password",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
