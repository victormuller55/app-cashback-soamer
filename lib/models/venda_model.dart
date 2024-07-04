class VendaModel {
  int? idVendedor;
  String? nfeCode;
  int? idPonteira;

  VendaModel({
    this.idVendedor,
    this.nfeCode,
    this.idPonteira,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idVendedor;
    data['venda_nfe_code'] = nfeCode;
    data['id_ponteira'] = idPonteira;
    return data;
  }
}
