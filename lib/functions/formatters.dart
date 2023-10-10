import 'package:intl/intl.dart';

String formatarCPF(String cpf) {
  if (cpf.length != 11) {
    return "CPF inválido";
  }
  return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
}

DateTime formatarDDMMYYYYHHMMToDate(String dataHora) {
  try {
    List<String> partes = dataHora.split(' ');

    if (partes.length == 2) {
      String data = partes[0];
      String hora = partes[1];

      List<String> dataPartes = data.split('/');
      List<String> horaPartes = hora.split(':');

      if (dataPartes.length == 3 && horaPartes.length == 2) {
        int dia = int.parse(dataPartes[0]);
        int mes = int.parse(dataPartes[1]);
        int ano = int.parse(dataPartes[2]);
        int hora = int.parse(horaPartes[0]);
        int minuto = int.parse(horaPartes[1]);

        return DateTime(ano, mes, dia, hora, minuto);
      } else {
        throw Exception("Formato de data/hora inválido.");
      }
    } else {
      throw Exception("Formato de data/hora inválido.");
    }
  } catch (e) {
    throw Exception("Erro ao converter data/hora: $e");
  }
}

String formatarData(String data) {
  DateTime dataAtual = DateTime.now();
  DateTime dataRecebida = DateTime.parse(data).subtract(Duration(hours: 3));

  if (dataRecebida.year == dataAtual.year && dataRecebida.month == dataAtual.month && dataRecebida.day == dataAtual.day) {
    String horaMinuto = DateFormat('HH:mm').format(dataRecebida);
    return horaMinuto;
  } else {
    String dataFormatada = DateFormat('dd/MM/yyyy').format(dataRecebida);
    return dataFormatada;
  }
}
