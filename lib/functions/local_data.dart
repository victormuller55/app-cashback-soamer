import 'package:app_cashback_soamer/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveLocalUserData(UsuarioModel usuarioModel) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();

  localData.setInt("id", usuarioModel.idUsuario ?? 0);
  localData.setString("nome", usuarioModel.nomeUsuario ?? "");
  localData.setString("email", usuarioModel.emailUsuario ?? "");
  localData.setString("celular", usuarioModel.celularUsuario ?? "");
  localData.setString("cpf", usuarioModel.cpfUsuario ?? "");
  localData.setString("data", usuarioModel.dataUsuario ?? "");
}

Future<UsuarioModel> getModelLocal() async {

  final SharedPreferences localData = await SharedPreferences.getInstance();

  return UsuarioModel(
    idUsuario: localData.getInt("id"),
    nomeUsuario: localData.getString("nome"),
    emailUsuario: localData.getString("email"),
    celularUsuario: localData.getString("celular"),
    cpfUsuario: localData.getString("cpf"),
    nomeConcessionaria: localData.getString("nome_concessionaria"),
    dataUsuario: localData.getString("data"),
  );
}

void clearLocalData() async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.clear();
}

Future<bool> temLocalData() async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  return localData.getInt("id") != null;
}

void addLocalDataString(String key, String value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setString(key, value);
}

void addLocalDataInt(String key, int value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setInt(key, value);
}

void addLocalDataDouble(String key, double value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setDouble(key, value);
}

void addLocalDataBool(String key, bool value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setBool(key, value);
}
