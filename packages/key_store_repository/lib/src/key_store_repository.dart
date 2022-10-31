// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:key_store_api/key_store_api.dart';

/// {@template key_store_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class KeyStoreRepository {
  /// {@macro key_store_repository}
  const KeyStoreRepository(this._api);

  final KeyStoreApi _api;

  /// A description for initialize
  Future<bool> initialize() async {
    return _api.initialize();
  }

  /// A description for get
  String? get(String key) {
    return _api.get(key);
  }

  /// A description for set
  void set(String key, String value) {
    return _api.set(key, value);
  }

  /// A description for delete
  void delete(String key) {
    return _api.delete(key);
  }
}
