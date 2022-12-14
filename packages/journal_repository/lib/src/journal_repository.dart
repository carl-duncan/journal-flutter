// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:journal_api/journal_api.dart';

/// {@template journal_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class JournalRepository {
  /// {@macro journal_repository}
  const JournalRepository(this._api);

  final JournalApi _api;

  /// A description for getEntries
  Future<List<Entry>> getEntries(String userId, {String? key}) async {
    return _api.getEntries(userId, key: key);
  }

  /// A description for createEntry
  Future<void> createEntry(Entry entry, {required String key}) async {
    return _api.createEntry(entry, key: key);
  }

  /// A description for searchEntries
  Future<List<Entry>> searchEntries(
    String query,
    String userId, {
    String? key,
  }) async {
    return _api.searchEntries(query, userId, key: key);
  }

  /// A description for updateEntry
  Future<void> updateEntry(Entry entry, {required String key}) async {
    return _api.updateEntry(entry, key: key);
  }

  /// A description for deleteEntry
  Future<void> deleteEntry(Entry entry) async {
    return _api.deleteEntry(entry);
  }
}
