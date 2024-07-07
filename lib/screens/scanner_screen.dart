import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/bloc/scanner_bloc.dart';
import 'package:scanner/widgets/app_button.dart';
import 'screens.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScannerBloc, ScannerState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 200),
                Center(
                  child: Text(
                    state.result == null
                        ? 'Scanned data will appear here'
                        : state.result!.code!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CameraScreen();
                        },
                      ));
                    },
                    child: const AppButton(text: 'Scan Code'))
              ],
            ),
          ),
        );
      },
    );
  }
}
