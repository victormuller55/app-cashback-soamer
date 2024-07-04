
abstract class RegistrarVendaEvent {}

class RegistrarVendaLoadEvent extends RegistrarVendaEvent {
  String nfc;
  int idPonteira;
  RegistrarVendaLoadEvent(this.nfc, this.idPonteira);
}