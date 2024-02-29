import 'package:flutter/material.dart';
import 'package:flutter_zebra_poc/di/injection.dart';
import 'package:flutter_zebra_poc/domain/use_case/log_out_use_case.dart';
import 'package:flutter_zebra_poc/presentation/miscellaneous/context_extension.dart';
import 'package:flutter_zebra_poc/presentation/style/app_dimens.dart';
import 'package:flutter_zebra_poc/presentation/style/app_gap.dart';

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
      body: const _HomePageBody(),
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

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimens.wrapPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Scan your order barcode or enter it manually'),
          Gap.listMedium,
          const _ScannerButtonsRow(),
          Gap.listMedium,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Enter barcode',
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to order details page
              context.showUnimplementedSnackBar();
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class _ScannerButtonsRow extends StatelessWidget {
  const _ScannerButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            //TODO: Navigate to camera scan page
            context.showUnimplementedSnackBar();
          },
          child: Row(
            children: [
              const Icon(Icons.camera_alt),
              Gap.g12,
              const Text('Scan Barcode using camera'),
            ],
          ),
        ),
        Gap.listMedium,
        ElevatedButton(
          onPressed: () {
            //TODO: Navigate to scan page
            context.showUnimplementedSnackBar();
          },
          child: Row(
            children: [
              const Icon(Icons.barcode_reader),
              Gap.g12,
              const Text('Scan Barcode using scanner'),
            ],
          ),
        ),
      ],
    );
  }
}
