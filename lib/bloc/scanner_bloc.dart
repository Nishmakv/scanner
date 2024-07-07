import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  QRViewController? controller;
  ScannerBloc() : super(ScannerState.initial()) {
    on<QrEvent>(scanner);
    on<QrViewControllerEvent>(qrController);
    on<RegenerateEvent>(regenerate);
    on<UrlEvent>(launchUrl);
    on<ShareEvent>(share);
  }

  void scanner(
    QrEvent event,
    Emitter<ScannerState> emit,
  ) {
    emit(state.copyWith(result: event.result));
  }

  void qrController(
    QrViewControllerEvent event,
    Emitter<ScannerState> emit,
  ) async {
    final controller = event.qrViewController;
    await emit.forEach(controller.scannedDataStream, onData: (scanData) {
      if (scanData.code != null && isValidUrl(scanData.code!)) {
        if (state.result?.code != scanData.code) {
          return state.copyWith(result: scanData, url: true, result1: scanData);
        }
      } else {
        if (state.result?.code != scanData.code) { 
        return state.copyWith(result: scanData, url: false, result1: scanData);
     
        }
      }
      return state;
 });
}
  

  void regenerate(
    RegenerateEvent event,
    Emitter<ScannerState> emit,
  ) {
    emit(state.copyWith(data: event.data));
  }

  bool isValidUrl(String urlString) {
    final Uri url = Uri.parse(urlString);
    return url.scheme.isNotEmpty && url.host.isNotEmpty;
  }

  Future<void> launchUrl(
    UrlEvent event,
    Emitter<ScannerState> emit,
  ) async {
    final Uri url = Uri.parse(event.url);
    if (!await url_launcher.launchUrl(url)) {
      throw Exception('Could not launch ${event.url}');
    }
  }

  Future<void> share(
    ShareEvent event,
    Emitter<ScannerState> emit,
  ) async {
    try {
      final RenderRepaintBoundary boundary = event.qrKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/qr_code.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          text: 'Check out this QR code!');

      emit(state.copyWith());
    } catch (e) {
      emit(state.copyWith());
    }
  }
}
