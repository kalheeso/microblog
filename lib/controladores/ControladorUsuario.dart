import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/servicos/ServicoMicroblog.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'ControladorUsuario.g.dart';

class ControladorUsuario = _ControladorUsuarioBase with _$ControladorUsuario;

abstract class _ControladorUsuarioBase with Store {
  Usuario usuarioLogado;
  ServicoMicroblog service = GetIt.I.get<ServicoMicroblog>();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void deletarDoPrefs() {
    _prefs.then((db) {
      db.remove("user");
    });
  }

  void verificarSeTemUsuario(
      {Function() temUsuario, Function() naoTemUsuario}) {
    _prefs.then((db) {
      String usuarioJson = db.getString("user");
      if (usuarioJson != null) {
        usuarioLogado = Usuario.fromJson(JsonCodec().decode(usuarioJson));
        temUsuario?.call();
      } else {
        naoTemUsuario?.call();
      }
    });
  }

  void cadastrarUsuario(Usuario usuarioCadastrar,
      {Function() sucesso, Function(String mensagem) erro}) {
    if (usuarioCadastrar.email?.isEmpty ?? true) {
      erro?.call("Email inválido");
    } else if (usuarioCadastrar.nome?.isEmpty ?? true) {
      erro?.call("Nome inválido");
    } else if (usuarioCadastrar.senha?.isEmpty ?? true) {
      erro?.call("Senha inválida");
    } else {
      service.cadastrarUsuario(usuarioCadastrar).then((usuario) {
        _prefs.then((db) {
          db.setString("user", JsonCodec().encode(usuario.toJson()));
          usuarioLogado = usuario.sucesso;
          sucesso?.call();
        });
      }).catchError((onError) {
        erro?.call(onError.response.data["falha:"]);
      });
    }
  }

  void logarUsuario(Usuario usuarioLogar,
      {Function() sucesso, Function(String mensagem) erro}) {
    if ((usuarioLogar.email?.isEmpty ?? true) ||
        (usuarioLogar.senha?.isEmpty ?? true)) {
      erro?.call("Email ou senha inválidos");
    } else {
      service
          .logarUsuario(usuarioLogar.email, usuarioLogar.senha)
          .then((usuario) {
        _prefs.then((db) {
          usuarioLogado = usuario.sucesso;
          db.setString("user", JsonCodec().encode(usuario.sucesso.toJson()));
          sucesso?.call();
        });
      }).catchError((onError) {
        erro?.call(onError.response.data["falha:"]);
      });
    }
  }

  void mudarSenha(Usuario usuario,
      {Function() sucesso, Function(String mensagem) erro}) {
    if (usuario.senha?.isEmpty ?? true) {
      erro?.call("Invalid password");
    } else {
      service.editarUsuario(usuario).then((value) {
        sucesso?.call();
      }).catchError((onError) {
        erro?.call(onError.response.data["falha:"]);
      });
    }
  }
}
