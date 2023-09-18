class VaucherModel {
  int? idVaucher;
  String? tituloVaucher;
  String? infoVaucher;
  String? dataComecoVaucher;
  String? dataFinalVaucher;
  int? pontosCheioVaucher;
  int? descontoVaucher;
  int? pontosVaucher;

  VaucherModel({
    this.idVaucher,
    this.tituloVaucher,
    this.infoVaucher,
    this.dataComecoVaucher,
    this.dataFinalVaucher,
    this.pontosCheioVaucher,
    this.descontoVaucher,
    this.pontosVaucher,
  });

  factory VaucherModel.empty() {
    return VaucherModel(
      idVaucher: 0,
      tituloVaucher: "",
      infoVaucher: "",
      dataComecoVaucher: "",
      dataFinalVaucher: "",
      pontosCheioVaucher: 0,
      descontoVaucher: 0,
      pontosVaucher: 0,
    );
  }

  VaucherModel.fromMap(Map<String, dynamic> json) {
    idVaucher = json['id_vaucher'];
    tituloVaucher = json['titulo_vaucher'];
    infoVaucher = json['info_vaucher'];
    dataComecoVaucher = json['data_comeco_vaucher'];
    dataFinalVaucher = json['data_final_vaucher'];
    pontosCheioVaucher = json['pontos_cheio_vaucher'];
    descontoVaucher = json['desconto_vaucher'];
    pontosVaucher = json['pontos_vaucher'];
  }
}
