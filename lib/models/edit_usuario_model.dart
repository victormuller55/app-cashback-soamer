class EditUsuarioModel {
  String? nome;
  String? newEmail;
  String? newSenha;
  String? email;
  String? senha;
  int? idConcessionaria;

  EditUsuarioModel({
    this.nome,
    this.newEmail,
    this.newSenha,
    this.email,
    this.senha,
    this.idConcessionaria,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['new_email'] = newEmail;
    data['new_senha'] = newSenha;
    data['email'] = email;
    data['senha'] = senha;
    data['id_concessionaria'] = idConcessionaria;
    return data;
  }
}
