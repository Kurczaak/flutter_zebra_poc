import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_zebra_poc/di/injection.dart';
import 'package:flutter_zebra_poc/domain/use_case/log_out_use_case.dart';
import 'package:flutter_zebra_poc/presentation/features/home/bloc/scanner_bloc.dart';
import 'package:flutter_zebra_poc/presentation/miscellaneous/context_extension.dart';
import 'package:flutter_zebra_poc/presentation/style/app_dimens.dart';
import 'package:flutter_zebra_poc/presentation/style/app_gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ScannerBloc>()..add(const ScannerEvent.init()),
      child: Scaffold(
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

class _HomePageBody extends HookWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController();
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (scanData) {
            textController.text = scanData.barcode;
          },
        );
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: AppDimens.wrapPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Scan your order barcode or enter it manually'),
              Gap.listMedium,
              const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _ScannerButtonsColumn()),
              Gap.listMedium,
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: 'Enter barcode',
                ),
              ),
              Gap.listMedium,
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to order details page
                  context.showUnimplementedSnackBar();
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScannerButtonsColumn extends StatelessWidget {
  const _ScannerButtonsColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            context
                .read<ScannerBloc>()
                .add(const ScannerEvent.scanWithCamera());
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
            context
                .read<ScannerBloc>()
                .add(const ScannerEvent.toggleDeviceScanner(turnOn: true));
          },
          child: Row(
            children: [
              const Icon(Icons.barcode_reader),
              Gap.g12,
              const Text('Scan Barcode using scanner'),
            ],
          ),
        ),
        Gap.listMedium,
        ElevatedButton(
          onPressed: () {
            context
                .read<ScannerBloc>()
                .add(const ScannerEvent.toggleDeviceScanner(turnOn: false));
          },
          child: Row(
            children: [
              const Icon(Icons.stop),
              Gap.g12,
              const Text('Stop scanning using scanner'),
            ],
          ),
        ),
      ],
    );
  }
}
