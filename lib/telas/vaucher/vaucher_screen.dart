import 'package:app_cashback_soamer/models/vaucher_model.dart';
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
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
