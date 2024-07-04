bool validaVazio(String value) {
  if (value.isEmpty) {
    return false;
  }

  return true;
}

bool validaEmail(String value) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (value.isEmpty) {
    return false;
  } else if (!emailRegex.hasMatch(value)) {
    return false;
  }
  return true;
}
bool validaCPF(String value) {

  if (value.isEmpty) {
    return false;
  }

  value = value.replaceAll('.', '').replaceAll('-', '');

  if (value.length != 11) {
    return false;
  }

  if (RegExp(r'^(\d)\1*$').hasMatch(value)) {
    return false;
  }

  int sum1 = 0;
  for (int i = 0; i < 9; i++) {
    sum1 += int.parse(value[i]) * (10 - i);
  }
  int digit1 = 11 - (sum1 % 11);

  if (digit1 == 10 || digit1 == 11) {
    digit1 = 0;
  }

  int sum2 = 0;
  for (int i = 0; i < 10; i++) {
    sum2 += int.parse(value[i]) * (11 - i);
  }
  int digit2 = 11 - (sum2 % 11);

  if (digit2 == 10 || digit2 == 11) {
    digit2 = 0;
  }

  if (digit1 != int.parse(value[9]) || digit2 != int.parse(value[10])) {
    return false;
  }

  return true;
}