import 'package:flutter/material.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel de Médico')),
      body: const Center(
        child: Text(
          'Bienvenido, Doctor(a)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
