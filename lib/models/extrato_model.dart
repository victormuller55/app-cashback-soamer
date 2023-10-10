class ExtratoModel {
  int? id;
  String? titulo;
  String? descricao;
  int? pontos;
  String? data;
  bool? entrada;
  int? idUsuario;
  int? idVaucher;

  ExtratoModel({
    this.id,
    this.titulo,
    this.descricao,
    this.pontos,
    this.data,
    this.entrada,
    this.idUsuario,
    this.idVaucher,
  });

  factory ExtratoModel.empty() {
    return ExtratoModel(
      id: 0,
      idVaucher: 0,
      titulo: "",
      descricao: "",
      pontos: 0,
      idUsuario: 0,
      data: "",
      entrada: false,
    );
  }

  ExtratoModel.fromMap(Map<String, dynamic> json) {
    id = json['id_extrato'];
    titulo = json['titulo_extrato'];
    descricao = json['descricao_extrato'];
    pontos = json['pontos_extrato'];
    data = json['data_extrato'];
    entrada = json['entrada_extrato'];
    idUsuario = json['id_usuario_extrato'];
    idVaucher = json['id_vaucher_extrato'];
  }
}
