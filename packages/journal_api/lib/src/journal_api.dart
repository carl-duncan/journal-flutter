// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:journal_api/src/models/models.dart';

/// {@template journal_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class JournalApi {
  /// {@macro journal_api}
  const JournalApi();

  /// get All Entries from a Journal
  Future<List<Entry>> getEntries({String? key});

  /// search for an Entry by query
  Future<List<Entry>> searchEntries(String query, {String? key});

  /// create an Entry
  Future<void> createEntry(Entry entry, {required String key});

  /// update an Entry
  Future<void> updateEntry(Entry entry, {required String key});

  /// delete an Entry
  Future<void> deleteEntry(Entry entry);
}
