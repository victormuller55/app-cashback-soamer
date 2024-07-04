
import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';

class ConcessionariaModel {
  int? id;
  String? marca;
  String? nome;
  String? cnpj;
  String? endereco;

  ConcessionariaModel({
    this.id,
    this.marca,
    this.nome,
    this.cnpj,
    this.endereco,
  });

  factory ConcessionariaModel.empty() {
    return ConcessionariaModel(
      id: 0,
      nome: AppStrings.vazio,
      cnpj: AppStrings.vazio,
      marca: AppStrings.vazio,
      endereco: AppStrings.vazio,
    );
  }

  ConcessionariaModel.fromMap(Map<String, dynamic> json) {
    id = json['id_concessionaria'];
    marca = json['marca_concessionaria'];
    nome = json['nome_concessionaria'];
    cnpj = json['cnpj_concessionaria'];
    endereco = json['endereco_concessionaria'];
  }
}
