import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorFeed.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/models/Postagem.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/util/BotaoPadrao.dart';
import 'package:microblog/util/PostagemWidget.dart';
import 'package:microblog/util/TextFieldPadrao.dart';

class UtilDialog {
  static void exibirInformacao(
    BuildContext context, {
    String titulo,
    String mensagem,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Card(
                  margin: EdgeInsets.all(24.0),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "$titulo",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Divider(),
                          Text("$mensagem"),
                          SizedBox(
                            height: 16.0,
                          ),
                          BotaoPadrao(
                            backgroundColor: Colors.greenAccent,
                            title: "OK",
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ))));
        });
  }

  static void showLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
              child: Card(
                  margin: EdgeInsets.all(24.0),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey,
                      ))));
        });
  }

  static void excluirPost(BuildContext mainContext, Postagem postagem,
      {String titulo, String mensagem}) {
    ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
    showDialog(
        context: mainContext,
        builder: (context) {
          return Center(
              child: Card(
                  margin: EdgeInsets.all(24.0),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Are you sure you want to delete it?"),
                          Divider(),
                          Text(
                            "${postagem.criador.nome}",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text("${postagem.conteudo}"),
                          SizedBox(
                            height: 16.0,
                          ),
                          Container(
                            height: 45,
                            child: Row(
                              children: [
                                Expanded(
                                  child: BotaoPadrao(
                                    backgroundColor: Colors.grey,
                                    title: "Cancel",
                                    onPressed: () {
                                      Navigator.pop(mainContext);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: BotaoPadrao(
                                    backgroundColor: Colors.red,
                                    title: "Confirm",
                                    onPressed: () {
                                      _controladorFeed.excluirPost(postagem,
                                          carregando: () {
                                        Navigator.pop(mainContext);
                                        showLoading(mainContext);
                                      }, sucesso: () {
                                        Navigator.pop(mainContext);
                                        exibirInformacao(
                                          mainContext,
                                          titulo: "Success",
                                          mensagem: "The post was deleted",
                                        );
                                      }, erro: (mensagem) {
                                        Navigator.pop(mainContext);
                                        exibirInformacao(mainContext,
                                            titulo: "Ops!", mensagem: mensagem);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ))));
        });
  }

  static void editarPost(BuildContext mainContext, Postagem postagem,
      {String titulo, String mensagem}) {
    showDialog(
        context: mainContext,
        builder: (context) {
          return Center(
              child: Card(
                  margin: EdgeInsets.all(24.0),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Editing"),
                          Divider(),
                          PostagemWidget(
                            postagemEditar: postagem,
                            sucesso: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ))));
        });
  }

  static void mudarSenha(BuildContext mainContext, Usuario usuario) {
    String senha = "";
    ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
    showDialog(
        context: mainContext,
        builder: (context) {
          return Center(
            child: Card(
                margin: EdgeInsets.all(24.0),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("New password: "),
                        Divider(),
                        TextFieldPadrao(
                          onChanged: (text) {
                            senha = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BotaoPadrao(
                              backgroundColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: "Cancel",
                            ),
                            BotaoPadrao(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                if (senha.isNotEmpty && senha != " ") {
                                  usuario.senha = senha;
                                  _controladorUsuario.editarUsuario(usuario,
                                      sucesso: () {
                                    Navigator.pop(context);
                                    exibirInformacao(
                                      context,
                                      titulo: "Success",
                                      mensagem: "The password has been changed",
                                    );
                                  }, erro: (mensagem) {
                                    Navigator.pop(context);
                                    exibirInformacao(context,
                                        mensagem: "There' been an error",
                                        titulo: "Sorry");
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Insert a valid password",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 10);
                                }
                              },
                              title: "Confirm",
                            )
                          ],
                        )
                      ],
                    ))),
          );
        });
  }

  static void mudarEmail(BuildContext mainContext, Usuario usuario) {
    String email = "";
    ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
    showDialog(
        context: mainContext,
        builder: (context) {
          return Center(
            child: Card(
                margin: EdgeInsets.all(24.0),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("New user email: "),
                        Divider(),
                        TextFieldPadrao(onChanged: (text) {
                          email = text;
                        }),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BotaoPadrao(
                              backgroundColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: "Cancel",
                            ),
                            BotaoPadrao(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                if (email.isNotEmpty && email != " ") {
                                  usuario.email = email;
                                  _controladorUsuario.editarUsuario(usuario,
                                      sucesso: () {
                                    Navigator.pop(context);
                                    exibirInformacao(
                                      context,
                                      titulo: "Success",
                                      mensagem: "The email has been changed",
                                    );
                                  }, erro: (mensagem) {
                                    Navigator.pop(context);
                                    exibirInformacao(context,
                                        titulo: "Sorry",
                                        mensagem: "There' been an error");
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Insert a valid email",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 10);
                                }
                              },
                              title: "Confirm",
                            )
                          ],
                        )
                      ],
                    ))),
          );
        });
  }

  static void darLikeOuRetirar(
      BuildContext mainContext, Postagem postagem, Usuario usuario,
      {String mensagem, Function() sucesso}) {
    if (postagem.likes == null) {
      List<Usuario> likesList = new List<Usuario>();
      postagem.likes = likesList;
    }
    ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
    bool hasLikedBefore = false;

    for (int i = 0; i < postagem.likes.length; i++) {
      hasLikedBefore = postagem.likes[i].id.contains(usuario.id);
    }

    if (!hasLikedBefore) {
      showDialog(
          context: mainContext,
          builder: (context) {
            return Center(
                child: Card(
                    margin: EdgeInsets.all(24.0),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Like it?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                            Text(
                              "${postagem.criador.nome}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text("${postagem.conteudo}"),
                            SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: BotaoPadrao(
                                      backgroundColor: Colors.red,
                                      title: "Cancel",
                                      onPressed: () {
                                        Navigator.pop(mainContext);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: BotaoPadrao(
                                      backgroundColor: Colors.green,
                                      title: "Confirm",
                                      onPressed: () {
                                        _controladorFeed
                                            .darUmLike(postagem.id, usuario,
                                                carregando: () {
                                          Navigator.pop(mainContext);
                                          UtilDialog.showLoading(mainContext);
                                        }, sucesso: () {
                                          Navigator.pop(mainContext);
                                          UtilDialog.exibirInformacao(
                                            mainContext,
                                            titulo: "Success",
                                            mensagem: "Liked",
                                          );
                                          sucesso?.call();
                                        }, erro: (mensagem) {
                                          Navigator.pop(mainContext);
                                          UtilDialog.exibirInformacao(
                                              mainContext,
                                              titulo: "Ops!",
                                              mensagem: mensagem);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))));
          });
    } else {
      showDialog(
          context: mainContext,
          builder: (context) {
            return Center(
                child: Card(
                    margin: EdgeInsets.all(24.0),
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dislike it?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                            Text(
                              "${postagem.criador.nome}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Text("${postagem.conteudo}"),
                            SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: BotaoPadrao(
                                      backgroundColor: Colors.red,
                                      title: "Cancel",
                                      onPressed: () {
                                        Navigator.pop(mainContext);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: BotaoPadrao(
                                      backgroundColor: Colors.green,
                                      title: "Confirm",
                                      onPressed: () {
                                        _controladorFeed
                                            .desdarLike(postagem.id, usuario,
                                                carregando: () {
                                          Navigator.pop(mainContext);
                                          UtilDialog.showLoading(mainContext);
                                        }, sucesso: () {
                                          Navigator.pop(mainContext);
                                          UtilDialog.exibirInformacao(
                                            mainContext,
                                            titulo: "Success",
                                            mensagem: "Disliked",
                                          );
                                          sucesso?.call();
                                        }, erro: (mensagem) {
                                          Navigator.pop(mainContext);
                                          UtilDialog.exibirInformacao(
                                              mainContext,
                                              titulo: "Ops!",
                                              mensagem: mensagem);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))));
          });
    }
  }

  static void comentarPost(BuildContext mainContext, Postagem postagem,
      {Function() sucesso}) {
    ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();
    ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();

    Comentario comentario =
        new Comentario(criador: _controladorUsuario.usuarioLogado);

    showDialog(
        context: mainContext,
        builder: (context) {
          return Center(
            child: Card(
                margin: EdgeInsets.all(24.0),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Comment"),
                        Divider(),
                        TextFieldPadrao(
                          onChanged: (text) {
                            comentario.comentario = text;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BotaoPadrao(
                              backgroundColor: Colors.red,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              title: "Cancel",
                            ),
                            BotaoPadrao(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                _controladorFeed.comentar(
                                    comentario, postagem.id, sucesso: () {
                                  UtilDialog.exibirInformacao(context,
                                      titulo: "Succes",
                                      mensagem:
                                          "You commented the post, access the firestore db to check");
                                }, erro: (mensagem) {
                                  UtilDialog.exibirInformacao(context,
                                      titulo: "Error",
                                      mensagem: "Sorry, something went wrong");
                                });
                              },
                              title: "Confirm",
                            )
                          ],
                        )
                      ],
                    ))),
          );
        });
  }
}
