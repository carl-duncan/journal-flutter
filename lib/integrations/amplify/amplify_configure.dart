// ignore_for_file: uri_does_not_exist, undefined_identifier
// ignore_for_file: argument_type_not_assignable
import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:journal/amplifyconfiguration.dart';

class AmplifyConfigure {
  static Future<void> configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.addPlugin(AmplifyAPI());
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      log('Could not configure Amplify: $e');
    }
  }
}
