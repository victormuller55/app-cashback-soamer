class HomeModel {
  int? pontosUsuario;
  int? pontosPedentesUsuario;
  int? valorPix;

  HomeModel({
    this.pontosUsuario,
    this.pontosPedentesUsuario,
    this.valorPix,
  });

  factory HomeModel.empty() {
    return HomeModel(
      pontosUsuario: 0,
      pontosPedentesUsuario: 0,
      valorPix: 0,
    );
  }

  HomeModel.fromMap(Map<String, dynamic> json) {
    pontosUsuario = json['pontos_usuario'];
    pontosPedentesUsuario = json['pontos_pedentes_usuario'];
    valorPix = json['valor_pix'];
  }
}
