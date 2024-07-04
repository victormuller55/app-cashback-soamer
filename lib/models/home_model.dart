class HomeModel {
  int? pontos;
  int? pontosPendentes;
  int? valorPix;

  HomeModel({
    this.pontos,
    this.pontosPendentes,
    this.valorPix,
  });

  factory HomeModel.empty() {
    return HomeModel(
      pontos: 0,
      pontosPendentes: 0,
      valorPix: 0,
    );
  }

  HomeModel.fromMap(Map<String, dynamic> json) {
    pontos = json['pontos_usuario'];
    pontosPendentes = json['pontos_pedentes_usuario'];
    valorPix = json['valor_pix'];
  }
}
