class HomeModel {
  int? pontosUsuario;
  int? valorPix;

  HomeModel({
    this.pontosUsuario,
    this.valorPix,
  });

  factory HomeModel.empty() {
    return HomeModel(
      pontosUsuario: 0,
      valorPix: 0,
    );
  }

  HomeModel.fromJson(Map<String, dynamic> json) {
    pontosUsuario = json['pontos_usuario'];
    valorPix = json['valor_pix'];
  }
}
