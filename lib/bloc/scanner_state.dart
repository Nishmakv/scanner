part of 'scanner_bloc.dart';

enum ScannerStatus {
  initial,
  loading;
}

class ScannerState {
  final ScannerStatus? status;
  final Barcode? result;
  final QRViewController? qrViewController;
  final String? data;
  final bool? url;
 

  ScannerState({
    this.status,
    this.result,
    this.qrViewController,
    this.data,
    this.url,
  
  });

  factory ScannerState.initial() {
    return ScannerState(status: ScannerStatus.initial);
  }
  ScannerState copyWith({
    ScannerStatus? status,
    Barcode? result,
    QRViewController? qrViewController,
    String? data,
    bool? url,
    Barcode?result1,
  }) {
    return ScannerState(
      status: status,
      result: result ?? this.result,
      qrViewController: qrViewController ?? this.qrViewController,
      data: data ?? this.data,
      url: url ?? this.url,
    
    );
  }
}
