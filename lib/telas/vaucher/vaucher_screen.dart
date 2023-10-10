import 'package:app_cashback_soamer/models/vaucher_model.dart';
import 'package:app_cashback_soamer/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class VaucherScreen extends StatefulWidget {
  final VaucherModel vaucherModel;

  const VaucherScreen({super.key, required this.vaucherModel});

  @override
  State<VaucherScreen> createState() => _VaucherScreenState();
}

class _VaucherScreenState extends State<VaucherScreen> {
  @override
  Widget build(BuildContext context) {
    return scaffold(body: Container(), title: widget.vaucherModel.tituloVaucher ?? "");
  }
}
