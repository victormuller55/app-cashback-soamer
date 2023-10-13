abstract class AlterarSenhaEvent {}

class AlterarSenhaEnviarEvent extends AlterarSenhaEvent {
  String email;
  String novaSenha;
  AlterarSenhaEnviarEvent(this.email, this.novaSenha);
}