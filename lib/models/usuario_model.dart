  import 'package:app_cashback_soamer/app_widget/consts/app_strings.dart';

class VendedorModel {
    int? id;
    String? nome;
    String? email;
    String? celular;
    String? cpf;
    int? pontos;
    int? pontosPendentes;
    String? senha;
    String? data;
    int? valorPix;
    int? idConcessionaria;
    String? nomeConcessionaria;

    VendedorModel({
      this.id,
      this.nome,
      this.email,
      this.celular,
      this.cpf,
      this.pontos,
      this.pontosPendentes,
      this.senha,
      this.data,
      this.valorPix,
      this.idConcessionaria,
      this.nomeConcessionaria,
    });

    factory VendedorModel.empty() {
      return VendedorModel(
        id: 0,
        nome: AppStrings.vazio,
        cpf: AppStrings.vazio,
        pontos: 0,
        pontosPendentes: 0,
        email: AppStrings.vazio,
        senha: AppStrings.vazio,
        data: AppStrings.vazio,
        valorPix: 0,
      );
    }

    VendedorModel.fromMap(Map<String, dynamic> json) {
      id = json['id_usuario'];
      nome = json['nome_usuario'];
      email = json['email_usuario'];
      celular = json['celular_usuario'];
      cpf = json['cpf_usuario'];
      pontos = json['pontos_usuario'];
      pontosPendentes = json['pontos_pendentes_usuario'];
      senha = json['senha_usuario'];
      data = json['data_usuario'];
      idConcessionaria = json['id_concessionaria'];
      nomeConcessionaria = json['nome_concessionaria'];
    }

    Map<String, dynamic> toMap() {
      final Map<String, dynamic> data = <String, dynamic>{};

      data['id_usuario'] = id;
      data['nome_usuario'] = nome;
      data['email_usuario'] = email;
      data['celular_usuario'] = celular;
      data['cpf_usuario'] = cpf;
      data['senha_usuario'] = senha;

      return data;
    }
  }
