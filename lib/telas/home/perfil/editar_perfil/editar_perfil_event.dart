import 'dart:io';

import 'package:app_cashback_soamer/models/edit_usuario_model.dart';

abstract class EditarUsuarioEvent {}

class EditarUsuarioSalvarEvent extends EditarUsuarioEvent {
  EditUsuarioModel editUsuarioModel;
  File image;
  EditarUsuarioSalvarEvent(this.editUsuarioModel, this.image);
}