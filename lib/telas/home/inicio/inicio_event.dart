
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