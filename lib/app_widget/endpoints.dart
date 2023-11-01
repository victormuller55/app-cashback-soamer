const String server = "http://34.228.32.167";

class Endpoint {

  // Entrar e Cadastrar
  static String endpointEntrarCadastrar = "$server/v1/soamer/usuario";
  static String endpointConcessionaria = "$server/v1/soamer/concessionaria";

  // Dados do usuarios
  static String endpointHome = "$server/v1/soamer/usuario/home";
  static String endpointEditarUsuario = "$server/v1/soamer/usuario/edit";
  static String endpointExtrato = "$server/v1/soamer/extrato";
  static String endpointRecuperarSenha = "$server/v1/soamer/senha/recuperar";

  // Voucher
  static String endpointVaucher = "$server/v1/soamer/vaucher";
  static String endpointVaucherMaisTrocados = "$server/v1/soamer/vaucher/trocados";
  static String endpointVaucherPromocao = "$server/v1/soamer/vaucher/promocao";
  static String endpointTrocarVoucher = "$server/v1/soamer/vaucher/trocar";

  // PDF
  static String endpointLoadPDF = "$server/v1/soamer/usuario/pdf/nota_exemplo_1.pdf";

  static String endpointImageUsuario(int idUsuario) {
    return "$server/v1/soamer/usuario/foto?id_usuario=$idUsuario";
  }
}
