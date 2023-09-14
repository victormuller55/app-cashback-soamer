class UsuarioModel {
  int? idUsuario;
  String? nomeUsuario;
  String? emailUsuario;
  String? cpfUsuario;
  int? pontosUsuario;
  int? pontosPendentesUsuario;
  String? senhaUsuario;
  String? dataUsuario;

  UsuarioModel({
    this.idUsuario,
    this.nomeUsuario,
    this.emailUsuario,
    this.cpfUsuario,
    this.pontosUsuario,
    this.pontosPendentesUsuario,
    this.senhaUsuario,
    this.dataUsuario,
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
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['nome_usuario'] = nomeUsuario;
    data['email_usuario'] = emailUsuario;
    data['cpf_usuario'] = cpfUsuario;
    data['senha_usuario'] = senhaUsuario;

    return data;
  }
}
