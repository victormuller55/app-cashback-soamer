const String server = "http://44.201.116.140:5000"; // "44.201.116.140:5000";

class AppEndpoints {

  static String endpointEntrarCadastrar = "$server/v1/soamer/usuario";
  static String endpointConcessionaria = "$server/v1/soamer/concessionaria";
  static String endpointHome = "$server/v1/soamer/usuario/home";
  static String endpointEditarVendedor = "$server/v1/soamer/usuario/edit";
  static String endpointExtrato = "$server/v1/soamer/extrato";
  static String endpointRecuperarSenha = "$server/v1/soamer/senha/recuperar";
  static String endpointVoucher = "$server/v1/soamer/vaucher";
  static String endpointVoucherMaisTrocados = "$server/v1/soamer/vaucher/trocados";
  static String endpointVoucherPromocao = "$server/v1/soamer/vaucher/promocao";
  static String endpointTrocarVoucher = "$server/v1/soamer/vaucher/trocar";
  static String endpointVenda = "$server/v1/soamer/venda";

  static String endpointImageVendedor(int idVendedor) {
    return "$server/v1/soamer/usuario/foto?id_usuario=$idVendedor";
  }

  static String endpointImageVoucher(int idVoucher) {
    return "$server/v1/soamer/vaucher/image?id_voucher=$idVoucher";
  }
}
