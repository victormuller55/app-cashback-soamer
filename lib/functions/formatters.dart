import 'package:app_cashback_soamer/app_widget/app_consts/app_strings.dart';
import 'package:intl/intl.dart';

String formataCPF(String cpf) {
  if (cpf.length != 11) {
    return AppStrings.cpfInvalido;
  }
  return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
}

DateTime formataStringParaDateTime(String dateString) {
  return DateTime.parse(dateString);
}

DateTime formataDDMMYYYYHHMMParaDateTime(String dataHora) {
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
        throw Exception(AppStrings.formatoDataHoraInvalido);
      }
    } else {
      throw Exception(AppStrings.formatoDataHoraInvalido);
    }
  } catch (e) {
    throw Exception("Erro ao converter data/hora: $e");
  }
}

String formatarDataApi(String data) {
  DateTime dataAtual = DateTime.now();
  DateTime dataRecebida = DateTime.parse(data).subtract(const Duration(hours: 3));

  if (dataRecebida.year == dataAtual.year && dataRecebida.month == dataAtual.month && dataRecebida.day == dataAtual.day) {
    String horaMinuto = DateFormat('HH:mm').format(dataRecebida);
    return horaMinuto;
  } else {
    String dataFormatada = DateFormat('dd/MM/yyyy').format(dataRecebida);
    return dataFormatada;
  }
}

String somenteNumeros(String str) {
  RegExp regExp = RegExp(r'\d+');
  Iterable<RegExpMatch> matches = regExp.allMatches(str);
  String numbers = matches.map((match) => match.group(0)).join();

  if (numbers.isEmpty) {
    return AppStrings.vazio;
  }

  return int.parse(numbers).toString();
}

String formataCelular(String phoneNumber) {
  String digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

  if (digitsOnly.length != 11) {
    return AppStrings.numeroInvalido;
  }

  String formattedNumber = '(${digitsOnly.substring(0, 2)}) ${digitsOnly.substring(2, 7)}-${digitsOnly.substring(7)}';
  return formattedNumber;
}
