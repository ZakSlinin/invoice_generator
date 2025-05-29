import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice Generator')),
      body: const Center(child: Text('Welcome to Invoice Generator')),
    );
  }
}
