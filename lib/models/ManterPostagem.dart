
import 'package:json_annotation/json_annotation.dart';
part 'ManterPostagem.g.dart';

@JsonSerializable()
class ManterPostagem {
  
  factory ManterPostagem.fromJson(Map<String, dynamic> json) => _$ManterPostagemFromJson(json);
  Map<String, dynamic> toJson() => _$ManterPostagemToJson(this);
  ManterPostagem clone() => _$ManterPostagemFromJson(this.toJson());
    ManterPostagem({
        this.conteudo,
        this.criador,
    });

    String conteudo;
    Criador criador;

    
}

@JsonSerializable()
class Criador {
  factory Criador.fromJson(Map<String, dynamic> json) => _$CriadorFromJson(json);
  Map<String, dynamic> toJson() => _$CriadorToJson(this);
  Criador clone() => _$CriadorFromJson(this.toJson());
    Criador({
        this.id,
        this.nome,
        this.email,
    });

    String id;
    String nome;
    String email;
}
