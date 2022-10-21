// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:amplify_flutter/amplify_flutter.dart';

/// {@template user_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository();

  /// A description for getUserId
  Future<String> getUserId() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user.userId;
  }

  /// A description for getEncryptionKey
  Future<String> getEncryptionKey() async {
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final encryptionKey = attributes.firstWhere(
      (attribute) => attribute.userAttributeKey.key == 'custom:encryption_key',
    );

    return encryptionKey.value;
  }
}
