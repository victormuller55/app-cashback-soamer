import 'package:app_cashback_soamer/models/vendedor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveLocalUserData(VendedorModel vendedorModel) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();

  localData.setInt("id", vendedorModel.id ?? 0);
  localData.setString("nome", vendedorModel.nome ?? "");
  localData.setString("email", vendedorModel.email ?? "");
  localData.setString("celular", vendedorModel.celular.toString());
  localData.setString("cpf", vendedorModel.cpf ?? "");
  localData.setString("data", vendedorModel.data ?? "");
}

Future<VendedorModel> getModelLocal() async {

  final SharedPreferences localData = await SharedPreferences.getInstance();

  return VendedorModel(
    id: localData.getInt("id"),
    nome: localData.getString("nome"),
    email: localData.getString("email"),
    celular: localData.getString("celular"),
    cpf: localData.getString("cpf"),
    nomeConcessionaria: localData.getString("nome_concessionaria"),
    data: localData.getString("data"),
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
