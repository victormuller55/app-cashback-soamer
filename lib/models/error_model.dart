class ErrorModel {
  String? tipo;
  String? mensagem;
  String? erro;

  ErrorModel({
    this.tipo,
    this.mensagem,
    this.erro,
  });

  factory ErrorModel.empty() {
    return ErrorModel(
      erro: "Ocorreu um erro",
      mensagem: "Tente novamente mais tarde",
      tipo: "",
    );
  }

  ErrorModel.fromMap(Map<String, dynamic> json) {
    tipo = json['tipo'];
    mensagem = json['mensagem'];
    erro = json['erro'];
  }
}
