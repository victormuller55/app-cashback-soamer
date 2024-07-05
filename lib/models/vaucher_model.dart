import 'package:muller_package/muller_package.dart';

class VaucherModel {
  int? id;
  String? titulo;
  String? info;
  String? dataInicio;
  String? dataFinal;
  int? pontosCheio;
  int? desconto;
  int? pontos;

  VaucherModel({
    this.id,
    this.titulo,
    this.info,
    this.dataInicio,
    this.dataFinal,
    this.pontosCheio,
    this.desconto,
    this.pontos,
  });

  factory VaucherModel.empty() {
    return VaucherModel(
      id: 0,
      titulo: AppStrings.vazio,
      info: AppStrings.vazio,
      dataInicio: AppStrings.vazio,
      dataFinal: AppStrings.vazio,
      pontosCheio: 0,
      desconto: 0,
      pontos: 0,
    );
  }

  VaucherModel.fromMap(Map<String, dynamic> json) {
    id = json['id_vaucher'];
    titulo = json['titulo_vaucher'];
    info = json['info_vaucher'];
    dataInicio = json['data_comeco_vaucher'];
    dataFinal = json['data_final_vaucher'];
    pontosCheio = json['pontos_cheio_vaucher'];
    desconto = json['desconto_vaucher'];
    pontos = json['pontos_vaucher'];
  }
}
