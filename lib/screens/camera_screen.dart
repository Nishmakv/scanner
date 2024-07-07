import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner/bloc/scanner_bloc.dart';
import 'screens.dart';

class CameraScreen extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScannerBloc, ScannerState>(
      listener: (context, state) {
        if (state.result != null) {
          if (state.url!) {
            context.read<ScannerBloc>().add(UrlEvent(url: state.result!.code!));
          } else {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ScannerScreen();
              },
            ));
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                flex: 1,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController qrController) {
                    context.read<ScannerBloc>().add(QrViewControllerEvent(
                          qrViewController: qrController,
                        ));
                  },
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.red,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                  ),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
