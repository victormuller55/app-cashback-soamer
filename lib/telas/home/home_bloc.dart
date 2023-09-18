import 'dart:convert';

import 'package:app_cashback_soamer/functions/service.dart';
import 'package:app_cashback_soamer/models/error_model.dart';
import 'package:app_cashback_soamer/models/home_model.dart';
import 'package:app_cashback_soamer/telas/home/home_event.dart';
import 'package:app_cashback_soamer/telas/home/home_service.dart';
import 'package:app_cashback_soamer/telas/home/home_state.dart';
import 'package:bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState(homeModel: HomeModel.empty(), errorModel: ErrorModel.empty())) {
    on<HomeLoadEvent>((event, emit) async {
      emit(HomeLoadingState(homeModel: HomeModel.empty(), errorModel: ErrorModel.empty()));
      Response response = Response(statusCode: 0, body: "");
      try {
        response = await getHome(event.email);
        if (response.statusCode == 200) {
          emit(HomeSuccessState(homeModel: HomeModel.fromJson(jsonDecode(response.body)), errorModel: ErrorModel.empty()));
        } else {
          emit(HomeErrorState(homeModel: HomeModel.empty(), errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
        }
      } catch (e) {
        emit(HomeErrorState(homeModel: HomeModel.empty(), errorModel: ErrorModel.fromMap(jsonDecode(response.body))));
      }
    });
  }
}
