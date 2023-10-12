const String server = "http://192.168.0.188:8080";

class Endpoint {
  static String endpointHome = "$server/v1/soamer/usuario/home";
  static String endpointEntrarCadastrar = "$server/v1/soamer/usuario";
  static String endpointVaucher = "$server/v1/soamer/vaucher";
  static String endpointVaucherMaisTrocados = "$server/v1/soamer/vaucher/trocados";
  static String endpointVaucherPromocao = "$server/v1/soamer/vaucher/promocao";
  static String endpointTrocarVoucher = "$server/v1/soamer/vaucher/trocar";
  static String endpointConcessionaria = "$server/v1/soamer/concessionaria";
  static String endpointExtrato = "$server/v1/soamer/extrato";

  static String endpointImageUsuario(int idUsuario) {
    return "$server/v1/soamer/usuario/foto?id_usuario=$idUsuario";
  }
}
