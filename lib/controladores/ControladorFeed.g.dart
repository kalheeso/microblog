// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ControladorFeed.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ControladorFeed on _ControladorFeedBase, Store {
  Computed<bool> _$habilitarPostarComputed;

  @override
  bool get habilitarPostar =>
      (_$habilitarPostarComputed ??= Computed<bool>(() => super.habilitarPostar,
              name: '_ControladorFeedBase.habilitarPostar'))
          .value;

  final _$postagensAtom = Atom(name: '_ControladorFeedBase.postagens');

  @override
  ObservableList<Postagem> get postagens {
    _$postagensAtom.reportRead();
    return super.postagens;
  }

  @override
  set postagens(ObservableList<Postagem> value) {
    _$postagensAtom.reportWrite(value, super.postagens, () {
      super.postagens = value;
    });
  }

  final _$conteudoPostagemAtom =
      Atom(name: '_ControladorFeedBase.conteudoPostagem');

  @override
  String get conteudoPostagem {
    _$conteudoPostagemAtom.reportRead();
    return super.conteudoPostagem;
  }

  @override
  set conteudoPostagem(String value) {
    _$conteudoPostagemAtom.reportWrite(value, super.conteudoPostagem, () {
      super.conteudoPostagem = value;
    });
  }

  final _$statusConsultaFeedAtom =
      Atom(name: '_ControladorFeedBase.statusConsultaFeed');

  @override
  StatusConsulta get statusConsultaFeed {
    _$statusConsultaFeedAtom.reportRead();
    return super.statusConsultaFeed;
  }

  @override
  set statusConsultaFeed(StatusConsulta value) {
    _$statusConsultaFeedAtom.reportWrite(value, super.statusConsultaFeed, () {
      super.statusConsultaFeed = value;
    });
  }

  @override
  String toString() {
    return '''
postagens: ${postagens},
conteudoPostagem: ${conteudoPostagem},
statusConsultaFeed: ${statusConsultaFeed},
habilitarPostar: ${habilitarPostar}
    ''';
  }
}
