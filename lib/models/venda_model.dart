class VendaModel {
  int? idUsuario;
  String? nfeCode;
  int? idPonteira;

  VendaModel({
    this.idUsuario,
    this.nfeCode,
    this.idPonteira,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['venda_nfe_code'] = nfeCode;
    data['id_ponteira'] = idPonteira;
    return data;
  }
}
