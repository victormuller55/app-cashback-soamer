import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/models/vaucher_model.dart';

abstract class InicioEvent {}

class InicioLoadEvent extends InicioEvent {
  String email;
  InicioLoadEvent(this.email);
}

class LoadVaucherPromocaoEvent extends InicioEvent {
  HomeModel homeModel;
  LoadVaucherPromocaoEvent(this.homeModel);
}

class LoadVaucherMaisTrocadosEvent extends InicioEvent {
  HomeModel homeModel;
  List<VaucherModel> vaucherListPromocaoModel;
  LoadVaucherMaisTrocadosEvent( this.homeModel, this.vaucherListPromocaoModel);
}