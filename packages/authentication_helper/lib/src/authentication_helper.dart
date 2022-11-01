// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:local_auth/local_auth.dart';

/// {@template authentication_helper}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AuthenticationHelper {
  /// {@macro authentication_helper}
  AuthenticationHelper();

  /// Returns true if the authentication was successful.
  Future<bool> authenticated(String localizedReason) async {
    final auth = LocalAuthentication();
    final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    if (canAuthenticate) {
      final result = await auth.authenticate(
        localizedReason: localizedReason,
      );
      if (!result) {
        return false;
      } else {
        return true;
      }
    }

    return false;
  }
}
