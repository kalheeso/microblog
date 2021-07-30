import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorFeed.dart';
import 'package:microblog/models/Postagem.dart';

import 'BotaoPadrao.dart';
import 'TextFieldPadrao.dart';
import 'UtilDialog.dart';

class PostagemWidget extends StatefulWidget {
  final Function() sucesso;
  final Postagem postagemEditar;
  PostagemWidget({Key key, this.postagemEditar, this.sucesso})
      : super(key: key);

  @override
  _PostagemWidgetState createState() => _PostagemWidgetState();
}

class _PostagemWidgetState extends State<PostagemWidget> {
  ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
  List<Comentario> _listComentarios = new List<Comentario>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            TextFieldPadrao(
              value: widget.postagemEditar?.conteudo ??
                  _controladorFeed.conteudoPostagem,
              onChanged: (text) {
                _controladorFeed.conteudoPostagem = text;
              },
              titulo: widget.postagemEditar != null
                  ? "Edit your post"
                  : "Post something",
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Observer(builder: (_) {
                  return Container(
                    height: 30.0,
                    width: 80.0,
                    child: BotaoPadrao(
                      backgroundColor: Colors.blueAccent,
                      onPressed: _controladorFeed.habilitarPostar
                          ? () {
                              _controladorFeed.publicarPostagem(
                                  widget.postagemEditar, sucesso: () {
                                    widget.postagemEditar.comentarios = _listComentarios;
                                Navigator.pop(context);
                                setState(() {});
                                widget.sucesso();
                              }, erro: (mensagem) {
                                Navigator.pop(context);
                                UtilDialog.exibirInformacao(context,
                                    titulo: "Ops", mensagem: mensagem);
                              }, carregando: () {
                                UtilDialog.showLoading(context);
                              });
                            }
                          : null,
                      title: widget.postagemEditar != null ? "Edit" : "Post",
                    ),
                  );
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
