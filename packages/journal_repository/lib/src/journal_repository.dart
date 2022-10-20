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
  Future<List<Entry>> getEntries() async {
    return _api.getEntries();
  }

  /// A description for createEntry
  Future<void> createEntry(Entry entry) async {
    return _api.createEntry(entry);
  }

  /// A description for searchEntries
  Future<List<Entry>> searchEntries(String query) async {
    return _api.searchEntries(query);
  }
}
