abstract class VoucherEvent {}

class VoucherTrocarEvent extends VoucherEvent {
  int idVoucher;

  VoucherTrocarEvent(this.idVoucher);
}
