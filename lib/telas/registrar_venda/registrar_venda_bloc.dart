// import 'package:app_cashback_soamer/app_widget/endpoints.dart';
// import 'package:app_cashback_soamer/functions/service.dart';
// import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_event.dart';
// import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_service.dart';
// import 'package:app_cashback_soamer/telas/registrar_venda/registrar_venda_state.dart';
// import 'package:bloc/bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_pdfview/flutter_pdfview.dart';
//
// class RegistrarVendaBloc extends Bloc<RegistrarVendaEvent, RegistrarVendaState> {
//   RegistrarVendaBloc() : super(RegistrarVendaInitialState()) {
//     on<RegistrarVendaLoadEvent>((event, emit) async {
//       emit(RegistrarVendaLoadingState());
//
//       try {
//         Response response = await getPDF();
//         emit(RegistrarVendaSuccessState(pdfBytes: response.by));
//       } catch (e) {
//         emit(RegistrarVendaErrorState(errorModel: e is ApiException ? ErrorModel.fromMap(jsonDecode(e.response.body)) : ErrorModel.empty()));
//       }
//     });
//   }
// }
