import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner/bloc/scanner_bloc.dart';
import 'package:scanner/widgets/app_button.dart';

class GenerateScreen extends StatelessWidget {
  GenerateScreen({super.key});
  final GlobalKey qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TextEditingController dataController = TextEditingController();
    return BlocConsumer<ScannerBloc, ScannerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: dataController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(14),
                        hintText: 'Enter the data',
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) {
                        context
                            .read<ScannerBloc>()
                            .add(RegenerateEvent(data: value));
                      },
                    ),
                    const SizedBox(height: 20),
                    if (dataController.text.isNotEmpty)
                      RepaintBoundary(
                        key: qrKey,
                        child: QrImageView(
                          backgroundColor: Colors.white,
                          data: dataController.text,
                          version: QrVersions.auto,
                          size: 200,
                          gapless: true,
                        ),
                      ),
                    if (dataController.text.isNotEmpty) const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.read<ScannerBloc>().add(
                              ShareEvent(qrKey: qrKey),
                            );
                      },
                      child: const AppButton(
                        text: 'Share QR Code',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
