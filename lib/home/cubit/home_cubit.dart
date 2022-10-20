import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository, this._category) : super(const HomeInitial()) {
    getEntries();
  }

  Future<void> getEntries() async {
    emit(
      state.copyWith(
        entries: await _repository.getEntries(),
        isLoading: false,
      ),
    );
  }

  Future<void> toggleSearchBar() async {
    final entries = await _repository.getEntries();

    emit(
      state.copyWith(
        entries: entries,
        showSearchBar: !state.showSearchBar,
      ),
    );
  }

  void toggleCategory(HomeCategory category) {
    emit(
      state.copyWith(
        category: category,
      ),
    );
  }

  void isLoading({required bool isLoading}) {
    emit(
      state.copyWith(
        isLoading: isLoading,
      ),
    );
  }

  Future<String> _getUserId() async {
    final user = await _category.getCurrentUser();
    return user.userId;
  }

  Future<void> createEntry(String input) async {
    isLoading(isLoading: true);
    final title = input.split(' ').take(3).join(' ');
    final body = input.split(' ').skip(3).join(' ');

    final userId = await _getUserId();

    final entry = Entry(
      title: title,
      body: body,
      userId: userId,
    );

    await _repository.createEntry(entry);

    await getEntries();
  }

  Future<List<Entry>> searchEntries(String query) async {
    emit(
      state.copyWith(
        entries: await _repository.searchEntries(query),
        isLoading: false,
      ),
    );
    return state.entries;
  }

  final JournalRepository _repository;

  final AuthCategory _category;

  Future<void> updateEntry(Entry entry, String input) async {
    isLoading(isLoading: true);

    final title = input.split(' ').take(3).join(' ');

    final body = input.split(' ').skip(3).join(' ');

    final updatedEntry = Entry(
      id: entry.id,
      title: title,
      body: body,
      userId: entry.userId,
    );

    await _repository.updateEntry(updatedEntry);

    await getEntries();
  }
}
