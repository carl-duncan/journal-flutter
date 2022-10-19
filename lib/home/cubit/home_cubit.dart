import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeInitial()) {
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

  void toggleSearchBar() {
    emit(
      state.copyWith(
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

  Future<void> createEntry(String input) async {
    isLoading(isLoading: true);
    final title = input.split(' ').take(3).join(' ');
    final body = input.split(' ').skip(3).join(' ');

    final user = await Amplify.Auth.getCurrentUser();

    final entry = Entry(
      title: title,
      body: body,
      userId: user.userId,
    );

    await _repository.createEntry(entry);

    await getEntries();
  }

  final JournalRepository _repository;
}
