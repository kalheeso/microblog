import 'package:get_it/get_it.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:microblog/controladores/ControladorUsuario.dart';
import 'package:microblog/models/Usuario.dart';
part 'Postagem.g.dart';

@JsonSerializable()
class Postagem {
  String id, conteudo;
  DateTime dataDePostagem;
  Usuario criador;
  List<Usuario> likes;
  List<Comentario> comentarios;

  bool get isCriador => GetIt.I
      .get<ControladorUsuario>()
      .usuarioLogado
      .id
      .contains(criador?.id ?? "");

  Postagem(
      {this.conteudo,
      this.id,
      this.criador,
      this.dataDePostagem,
      this.likes,
      this.comentarios});

  factory Postagem.fromJson(Map<String, dynamic> json) =>
      _$PostagemFromJson(json);
  Map<String, dynamic> toJson() => _$PostagemToJson(this);
}

@JsonSerializable()
class Comentario {
  String comentario, id;
  DateTime dataDoComentario;
  Usuario criador;

  Comentario({this.comentario, this.id, this.criador, this.dataDoComentario});

  factory Comentario.fromJson(Map<String, dynamic> json) =>
      _$ComentarioFromJson(json);
  Map<String, dynamic> toJson() => _$ComentarioToJson(this);
}


