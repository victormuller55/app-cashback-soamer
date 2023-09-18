import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';

abstract class HomeState {
  ErrorModel errorModel;
  HomeModel homeModel;

  HomeState({required this.homeModel, required this.errorModel});
}

class HomeInitialState extends HomeState {
  HomeInitialState({required HomeModel homeModel, required ErrorModel errorModel}) : super(homeModel: homeModel, errorModel: errorModel);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState({required HomeModel homeModel, required ErrorModel errorModel}) : super(homeModel: homeModel, errorModel: errorModel);
}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required HomeModel homeModel, required ErrorModel errorModel}) : super(homeModel: homeModel, errorModel: errorModel);
}

class HomeErrorState extends HomeState {
  HomeErrorState({required HomeModel homeModel, required ErrorModel errorModel}) : super(homeModel: homeModel, errorModel: errorModel);
}
