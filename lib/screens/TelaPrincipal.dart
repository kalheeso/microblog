import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorFeed.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/util/PostagemWidget.dart';
import 'package:microblog/util/StatusConsulta.dart';
import 'package:microblog/util/UtilDataHora.dart';
import 'package:microblog/util/UtilDialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TelaPrincipal extends StatefulWidget {
  final Usuario usuario;
  TelaPrincipal({this.usuario});

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal>
    with AfterLayoutMixin<TelaPrincipal> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ControladorUsuario _controladorUsuario = GetIt.I.get<ControladorUsuario>();
  BuildContext mainContext;
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  ControladorFeed _controladorFeed = GetIt.I.get<ControladorFeed>();

  @override
  void initState() {
    mainContext = context;
    super.initState();
  }

  _consultarFeed() {
    _controladorFeed.consultarOFeed(sucesso: () {
      Navigator.pop(context);
      _refreshController.refreshCompleted();
    }, erro: (mensagem) {
      Navigator.pop(context);
      _refreshController.refreshFailed();
    }, carregando: () {
      UtilDialog.showLoading(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.pushNamed(context, "/telaPerfil");
            },
          ),
          title: Text("Home"),
          backgroundColor: Colors.blue,
        ),
        body: SmartRefresher(
          onRefresh: _consultarFeed,
          controller: _refreshController,
          header: WaterDropMaterialHeader(),
          child: SingleChildScrollView(
            key: _scaffoldKey,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                PostagemWidget(),
                Observer(builder: (_) {
                  switch (_controladorFeed.statusConsultaFeed) {
                    case StatusConsulta.CARREGANDO:
                      return Text("Loading...");
                      break;
                    case StatusConsulta.FALHA:
                      return Text("There's been an error");
                      break;
                    case StatusConsulta.SUCESSO:
                      return ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var post = _controladorFeed.postagens[index];
                          return Card(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${post.criador.nome}"),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Visibility(
                                              visible: post?.isCriador ?? "",
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        UtilDialog.editarPost(
                                                            mainContext, post);
                                                      }),
                                                  IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () {
                                                        UtilDialog.excluirPost(
                                                            mainContext, post);
                                                      })
                                                ],
                                              )),
                                          Row(
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.thumb_up_rounded),
                                                  onPressed: () {
                                                    UtilDialog.darLikeOuRetirar(
                                                        mainContext,
                                                        post,
                                                        _controladorUsuario
                                                            .usuarioLogado,
                                                        sucesso: () {
                                                      _consultarFeed();
                                                    });
                                                  }),
                                              IconButton(
                                                  icon: Icon(Icons.comment),
                                                  onPressed: () {
                                                    UtilDialog.comentarPost(
                                                        mainContext,
                                                        _controladorFeed
                                                            .postagens[index]);
                                                  })
                                            ],
                                          )
                                        ],
                                      ),
                                    ]),
                                Divider(),
                                Text("${post.conteudo}"),
                                Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(),
                                      Text(UtilDataHora.convertDateTime(
                                          post.dataDePostagem))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ));
                        },
                        itemCount: _controladorFeed.postagens.length,
                        shrinkWrap: true,
                      );
                      break;
                    default:
                      return Container();
                  }
                })
              ],
            ),
          ),
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _consultarFeed();
  }
}
