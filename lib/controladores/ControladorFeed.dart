import 'package:get_it/get_it.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/models/ManterPostagem.dart';
import 'package:microblog/models/Postagem.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/servicos/ServicoMicroblog.dart';
import 'package:microblog/util/StatusConsulta.dart';
import 'package:mobx/mobx.dart';
part 'ControladorFeed.g.dart';

class ControladorFeed = _ControladorFeedBase with _$ControladorFeed;

abstract class _ControladorFeedBase with Store {
  ServicoMicroblog service = GetIt.I.get<ServicoMicroblog>();

  @observable
  ObservableList<Postagem> postagens = ObservableList<Postagem>();

  @observable
  String conteudoPostagem = "";

  @observable
  StatusConsulta statusConsultaFeed = StatusConsulta.CARREGANDO;

  @computed
  bool get habilitarPostar => conteudoPostagem.isNotEmpty;

  void consultarOFeed(
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    statusConsultaFeed = StatusConsulta.CARREGANDO;
    service.consultarPosts().then((responseTodosOsPosts) {
      statusConsultaFeed = StatusConsulta.SUCESSO;
      postagens.clear();
      postagens.addAll(responseTodosOsPosts.sucesso);
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha:"]);
    });
  }

  void publicarPostagem(Postagem postagem,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    if (postagem == null) {
      postagem = Postagem(
          conteudo: conteudoPostagem,
          criador: GetIt.I.get<ControladorUsuario>().usuarioLogado);
    } else {
      postagem.conteudo = conteudoPostagem;
    }
    Criador criador = Criador(
        email: postagem.criador.email,
        id: postagem.criador.id,
        nome: postagem.criador.nome);
    ManterPostagem manterPostagem =
        ManterPostagem(conteudo: postagem.conteudo, criador: criador);
    carregando?.call();
    service.manterPostagem(manterPostagem).then((value) {
      if (postagem.id == null) {
        postagens.insert(0, value.sucesso);
      } else {
        var index = postagens.indexWhere((post) => post.id == postagem.id);
        postagens.removeAt(index);
        postagens.insert(index, value.sucesso);
      }
      conteudoPostagem = "";
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha:"]);
    });
  }

  void excluirPost(Postagem postagem,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    service.excluirPostagem(postagem.id).then((value) {
      postagens.removeWhere((post) => post.id == postagem.id);
      sucesso?.call();
    }).catchError((onError) {
      statusConsultaFeed = StatusConsulta.FALHA;
      erro?.call(onError.response.data["falha:"]);
    });
  }

  void darUmLike(String id, Usuario usuario,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    statusConsultaFeed = StatusConsulta.CARREGANDO;
    service.darLike(id, usuario).then((responseTodosOsPosts) {
      statusConsultaFeed = StatusConsulta.SUCESSO;
      sucesso.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha:"]);
    });
  }

  void desdarLike(String id, Usuario usuario,
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    statusConsultaFeed = StatusConsulta.CARREGANDO;
    service.darDislike(id, usuario.id).then((utilRetornoPostagem) {
      statusConsultaFeed = StatusConsulta.SUCESSO;
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha:"]);
    });
  }

  void comentar(Comentario comentario, String idPost, 
      {Function() sucesso,
      Function() carregando,
      Function(String mensagem) erro}) {
    carregando?.call();
    service.comentarPostagem(comentario, idPost).then((value) {
      sucesso?.call();
    }).catchError((onError) {
      erro?.call(onError.response.data["falha:"]);
    });
  }
}
