part of 'scanner_bloc.dart';

abstract class ScannerEvent {
  const ScannerEvent();

  List<Object?> get props => [];
}

class QrEvent extends ScannerEvent {
  final Barcode result;
  const QrEvent({required this.result});
  @override
  List<Object?> get props => [];
}

class QrViewControllerEvent extends ScannerEvent {
  final QRViewController qrViewController;
  const QrViewControllerEvent({
    required this.qrViewController,
  });
  @override
  List<Object?> get props => [];
}

class RegenerateEvent extends ScannerEvent {
  final String data;
  const RegenerateEvent({
    required this.data,
  });
  @override
  List<Object?> get props => [];
}

class UrlEvent extends ScannerEvent {
  final String url;
  const UrlEvent({required this.url});
  @override
  List<Object?> get props => [];
}

class ShareEvent extends ScannerEvent {
   final GlobalKey qrKey;
  const ShareEvent({required this.qrKey});
}
