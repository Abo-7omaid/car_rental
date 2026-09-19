import 'package:flutter/material.dart'; // 👈 Added this for BuildContext, Navigator, and SnackBars
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // 1. 👇 Added BuildContext context here
  // 2. Removed the '_' so you can access this function from outside the class
  Future<void> authenticateWithBiometrics(BuildContext context) async {
    try {
      // Check if the device even supports biometrics
      final bool canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometrics not available on this device')),
        );
        return;
      }

      // Trigger the fingerprint/face prompt
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to log in to RentRide',
        biometricOnly: true,

      );

      // If fingerprint matched, go straight to the home screen!
      if (didAuthenticate && context.mounted) { // 👈 Changed to context.mounted
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Biometric error: Your phone does not support fingerprint! '),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}