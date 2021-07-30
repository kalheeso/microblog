import 'package:microblog/models/ManterPostagem.dart';
import 'package:microblog/models/Postagem.dart';
import 'package:microblog/models/Usuario.dart';
import 'package:microblog/util/UtilRetorno.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'ServicoMicroblog.g.dart';

@RestApi(baseUrl: "https://us-central1-meu-blog-curso.cloudfunctions.net")
abstract class ServicoMicroblog {
  factory ServicoMicroblog(Dio dio, {String baseUrl}) = _ServicoMicroblog;

  @POST("/usuariosMatheus/cadastrarUsuario")
  Future<UtilRetornoUsuario> cadastrarUsuario(@Body() Usuario usuario);

  @POST("/usuariosMatheus/editarUsuario")
  Future<String> editarUsuario(@Body() Usuario usuario);

  @GET("/usuariosMatheus/logarUsuario")
  Future<UtilRetornoUsuario> logarUsuario(
      @Query("email") String email, @Query("senha") String senha);

  @GET("/feedMatheus/consultarPosts")
  Future<UtilRetornoPostagens> consultarPosts();

  @POST("/feedMatheus/darDislike")
  Future<UtilRetornoPostagem> darDislike(
      @Query("id") String idPostagem, @Query("idUsuario") String idUsuario);

  @POST("/feedMatheus/darLike?id={id}")
  Future<UtilRetornoPostagem> darLike(
      @Path("id") String id, @Body() Usuario usuario);

  @DELETE("/feedMatheus/excluirComentario")
  Future<UtilRetornoPostagem> excluirComentario(
      @Query("id") String id, @Query("idPostagem") String idPostagem);

  @POST("/feedMatheus/comentarPost")
  Future<UtilRetornoPostagem> comentarPostagem(
      @Body() Comentario comentario, @Query("id") String id);

  @DELETE("/feedMatheus/excluirPostagem")
  Future<String> excluirPostagem(@Query("id") String id);

  @POST("/feedMatheus/manterPostagem")
  Future<UtilRetornoPostagem> manterPostagem(
      @Body() ManterPostagem manterPostagem);
}
