class ConcessionariaModel {
  int? idConcessionaria;
  String? marcaConcessionaria;
  String? nomeConcessionaria;
  String? cnpjConcessionaria;
  String? enderecoConcessionaria;

  ConcessionariaModel({
    this.idConcessionaria,
    this.marcaConcessionaria,
    this.nomeConcessionaria,
    this.cnpjConcessionaria,
    this.enderecoConcessionaria,
  });

  factory ConcessionariaModel.empty() {
    return ConcessionariaModel(
      idConcessionaria: 0,
      nomeConcessionaria: "",
      cnpjConcessionaria: "",
      marcaConcessionaria: "",
      enderecoConcessionaria: "",
    );
  }

  ConcessionariaModel.fromMap(Map<String, dynamic> json) {
    idConcessionaria = json['id_concessionaria'];
    marcaConcessionaria = json['marca_concessionaria'];
    nomeConcessionaria = json['nome_concessionaria'];
    cnpjConcessionaria = json['cnpj_concessionaria'];
    enderecoConcessionaria = json['endereco_concessionaria'];
  }
}
