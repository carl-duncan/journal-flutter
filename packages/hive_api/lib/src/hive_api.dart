// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:hive_flutter/hive_flutter.dart';
import 'package:key_store_api/key_store_api.dart';
import 'package:uuid/uuid.dart';

/// {@template hive_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class HiveApi implements KeyStoreApi {
  /// {@macro hive_api}
  const HiveApi(this.appName);

  /// The name of the hive box
  final String appName;

  Box<dynamic> _getHiveBox() => Hive.box<String>(appName);

  @override
  Future<bool> initialize() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox<String>(appName);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  String? get(String key) {
    final box = _getHiveBox();
    return box.get(key) as String?;
  }

  @override
  void set(String key, String value) {
    _getHiveBox().put(key, value);
  }

  @override
  void delete(String key) {
    _getHiveBox().delete(key);
  }

  @override
  String generate(String key) {
    set(key, const Uuid().v4());
    return get(key)!;
  }
}
