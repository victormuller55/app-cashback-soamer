class UsuarioModel {
  int? idUsuario;
  String? nomeUsuario;
  String? emailUsuario;
  String? cpfUsuario;
  int? pontosUsuario;
  int? pontosPendentesUsuario;
  String? senhaUsuario;
  String? dataUsuario;
  int? pontosPedentesUsuario;
  int? valorPix;
  int? idConcessionaria;
  String? nomeConcessionaria;

  UsuarioModel({
    this.idUsuario,
    this.nomeUsuario,
    this.emailUsuario,
    this.cpfUsuario,
    this.pontosUsuario,
    this.pontosPendentesUsuario,
    this.senhaUsuario,
    this.dataUsuario,
    this.pontosPedentesUsuario,
    this.valorPix,
    this.idConcessionaria,
    this.nomeConcessionaria,
  });

  factory UsuarioModel.empty() {
    return UsuarioModel(
      idUsuario: 0,
      nomeUsuario: "",
      cpfUsuario: "",
      pontosUsuario: 0,
      pontosPendentesUsuario: 0,
      emailUsuario: "",
      senhaUsuario: "",
      dataUsuario: "",
      pontosPedentesUsuario: 0,
      valorPix: 0,
    );
  }

  UsuarioModel.fromMap(Map<String, dynamic> json) {
    idUsuario = json['id_usuario'];
    nomeUsuario = json['nome_usuario'];
    emailUsuario = json['email_usuario'];
    cpfUsuario = json['cpf_usuario'];
    pontosUsuario = json['pontos_usuario'];
    pontosPendentesUsuario = json['pontos_pendentes_usuario'];
    senhaUsuario = json['senha_usuario'];
    dataUsuario = json['data_usuario'];
    idConcessionaria = json['id_concessionaria'];
    nomeConcessionaria = json['nome_concessionaria'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id_usuario'] = idUsuario;
    data['nome_usuario'] = nomeUsuario;
    data['email_usuario'] = emailUsuario;
    data['cpf_usuario'] = cpfUsuario;
    data['senha_usuario'] = senhaUsuario;

    return data;
  }
}
