
abstract class EntrarEvent {}

class EntrarLoginEvent extends EntrarEvent {
  String email;
  String senha;
  EntrarLoginEvent(this.email, this.senha);
}