abstract class EnviarEmailEvent {}

class EnviarEmailSendEvent extends EnviarEmailEvent {
  String email;
  EnviarEmailSendEvent(this.email);
}