import 'dart:io';

import 'package:app_cashback_soamer/models/edit_vendedor_model.dart';

abstract class EditarVendedorEvent {}

class EditarVendedorSalvarEvent extends EditarVendedorEvent {
  EditVendedorModel editarVendedorModel;
  File image;
  EditarVendedorSalvarEvent(this.editarVendedorModel, this.image);
}