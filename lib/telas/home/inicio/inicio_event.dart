import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioEvent {}

class InicioLoadEvent extends InicioEvent {
  String email;
  InicioLoadEvent(this.email);
}

class LoadConcessionariaEvent extends InicioEvent {}

class SetConcessionariaEvent extends InicioEvent {
  int idConcessionaria;
  SetConcessionariaEvent(this.idConcessionaria);
}