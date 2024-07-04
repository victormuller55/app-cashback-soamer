import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class CadastroEvent {}

class CadastroSalvarEvent extends CadastroEvent {
  VendedorModel usuarioModel;
  CadastroSalvarEvent(this.usuarioModel);
}
