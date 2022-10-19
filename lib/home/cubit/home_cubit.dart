import 'dart:async';

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

  final JournalRepository _repository;
}
