class VendaModel {
  int? idUsuario;
  String? vendaNfeCode;

  VendaModel({
    this.idUsuario,
    this.vendaNfeCode,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['venda_nfe_code'] = vendaNfeCode;
    return data;
  }
}
