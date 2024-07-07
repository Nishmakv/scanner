import 'package:flutter/material.dart';
import 'package:scanner/widgets/app_button.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 200),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ScannerScreen();
                      },
                    ));
                  },
                  child: const AppButton(text: 'Scan Qr Code'),
                ),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return  GenerateScreen();
                      },
                    ));
                  },
                  child: const AppButton(text: 'Generate Qr Code')),
            ],


            
          ),
        ),
      ),
    );
  }
}
