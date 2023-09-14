import 'package:app_cashback_soamer/models/usuario_model.dart';

abstract class EntrarEvent {}

class EntrarLoginEvent extends EntrarEvent {
  String email;
  String senha;
  EntrarLoginEvent(this.email, this.senha);
}