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
  String conteudo, id;
  DateTime dataDoComentario;
  Usuario criador;

  Comentario({this.conteudo, this.id, this.criador, this.dataDoComentario});

  factory Comentario.fromJson(Map<String, dynamic> json) =>
      _$ComentarioFromJson(json);
  Map<String, dynamic> toJson() => _$ComentarioToJson(this);
}

@JsonSerializable()
class EnviarComentario {
    EnviarComentario({
        this.comentario,
        this.criador,
    });

    String comentario;
    Usuario criador;
    
  factory EnviarComentario.fromJson(Map<String, dynamic> json) =>
      _$EnviarComentarioFromJson(json);
  Map<String, dynamic> toJson() => _$EnviarComentarioToJson(this);
}


