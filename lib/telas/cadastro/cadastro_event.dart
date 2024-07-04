import 'package:app_cashback_soamer/models/vendedor_model.dart';

abstract class CadastroEvent {}

class CadastroSalvarEvent extends CadastroEvent {
  VendedorModel vendedorModel;
  CadastroSalvarEvent(this.vendedorModel);
}
