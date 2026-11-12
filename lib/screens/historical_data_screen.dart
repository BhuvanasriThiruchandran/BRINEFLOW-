import 'package:flutter/material.dart';

class HistoricalDataScreen extends StatelessWidget {
  const HistoricalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historical Data')),
      body: const Center(child: Text('Historical Salinity & Water Level Logs')),
    );
  }
}