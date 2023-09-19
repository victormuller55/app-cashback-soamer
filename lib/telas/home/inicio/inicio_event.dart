abstract class InicioEvent {}

class InicioLoadEvent extends InicioEvent {
  String email;
  InicioLoadEvent(this.email);
}

class LoadVaucherPromocaoEvent extends InicioEvent {}