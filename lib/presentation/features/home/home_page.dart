import 'package:flutter/material.dart';
import 'package:flutter_zebra_poc/di/injection.dart';
import 'package:flutter_zebra_poc/domain/use_case/log_out_use_case.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          _LogoutButton(),
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO extract to BLOC
        getIt<LogOutUseCase>().call();
      },
      icon: const Icon(Icons.logout),
    );
  }
}
