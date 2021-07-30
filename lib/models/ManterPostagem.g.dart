// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ManterPostagem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManterPostagem _$ManterPostagemFromJson(Map<String, dynamic> json) {
  return ManterPostagem(
    conteudo: json['conteudo'] as String,
    criador: json['criador'] == null
        ? null
        : Criador.fromJson(json['criador'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ManterPostagemToJson(ManterPostagem instance) =>
    <String, dynamic>{
      'conteudo': instance.conteudo,
      'criador': instance.criador,
    };

Criador _$CriadorFromJson(Map<String, dynamic> json) {
  return Criador(
    id: json['id'] as String,
    nome: json['nome'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$CriadorToJson(Criador instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'email': instance.email,
    };
