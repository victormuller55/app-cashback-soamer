import 'package:app_cashback_soamer/models/concessionaria_model.dart';
import 'package:app_cashback_soamer/widgets/util.dart';
import 'package:flutter/material.dart';

DropdownMenuItem<ConcessionariaModel> _menuItem(ConcessionariaModel concessionariaModel) {
  return DropdownMenuItem<ConcessionariaModel>(
    value: concessionariaModel,
    child: Row(
      children: [
        appText(concessionariaModel.nome!),
        appText(" (${concessionariaModel.marca})", bold: true),
      ],
    ),
  );
}

Widget getDropdownConcessionarias({required List<ConcessionariaModel> modelList}) {

  List<DropdownMenuItem<ConcessionariaModel>> list = [];

  for (ConcessionariaModel concessionariaModel in modelList) {
    list.add(_menuItem(concessionariaModel));
  }

  ConcessionariaModel dropdownValue = modelList.first;

  return StatefulBuilder(
    builder: (context, setState) {
      return DropdownButtonFormField<ConcessionariaModel>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          border: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
          disabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(40)),
          focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent, width: 0.5), borderRadius: BorderRadius.circular(40)),
          hintText: "Escolha uma opção",
          hintStyle: const TextStyle(fontFamily: 'lato', fontSize: 13, color: Colors.grey),
        ),
        value: dropdownValue,
        onChanged: (ConcessionariaModel? value) => setState(() => dropdownValue = value!),
        items: list,
      );
    },
  );
}
