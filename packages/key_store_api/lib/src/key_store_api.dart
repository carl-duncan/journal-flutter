// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

/// {@template key_store_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class KeyStoreApi {
  /// {@macro key_store_api}
  const KeyStoreApi();

  /// Initialize the KeyStore
  Future<bool> initialize();

  /// Get the value for a given key
  String? get(String key);

  /// Set the value for a given key
  void set(String key, String value);

  /// generate a random key
  String generate(String key);

  /// delete a key
  void delete(String key);
}
