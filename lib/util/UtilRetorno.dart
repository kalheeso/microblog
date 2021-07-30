import 'package:json_annotation/json_annotation.dart';
import 'package:microblog/models/Postagem.dart';
import 'package:microblog/models/Usuario.dart';

part 'UtilRetorno.g.dart';

@JsonSerializable()
class UtilRetornoUsuario {
  Usuario sucesso;

  UtilRetornoUsuario({this.sucesso});

  factory UtilRetornoUsuario.fromJson(Map<String, dynamic> json) =>
      _$UtilRetornoUsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$UtilRetornoUsuarioToJson(this);
}

@JsonSerializable()
class UtilRetornoPostagens {
  List<Postagem> sucesso;

  UtilRetornoPostagens({this.sucesso});

  factory UtilRetornoPostagens.fromJson(Map<String, dynamic> json) =>
      _$UtilRetornoPostagensFromJson(json);
  Map<String, dynamic> toJson() => _$UtilRetornoPostagensToJson(this);
}

@JsonSerializable()
class UtilRetornoPostagem {
  Postagem sucesso;

  UtilRetornoPostagem({this.sucesso});

  factory UtilRetornoPostagem.fromJson(Map<String, dynamic> json) =>
      _$UtilRetornoPostagemFromJson(json);
  Map<String, dynamic> toJson() => _$UtilRetornoPostagemToJson(this);
}
