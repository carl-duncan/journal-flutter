import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository, this._userRepository)
      : super(const HomeInitial()) {
    getEntries();
  }

  Future<void> getEntries() async {
    final encryptionKey = await _userRepository.getEncryptionKey();
    final userId = await _userRepository.getUserId();

    emit(
      state.copyWith(
        entries: await _repository.getEntries(userId, key: encryptionKey),
        isLoading: false,
      ),
    );
  }

  Future<void> toggleSearchBar() async {
    final encryptionKey = await _userRepository.getEncryptionKey();
    final userId = await _userRepository.getUserId();
    final entries = await _repository.getEntries(userId, key: encryptionKey);

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

  Future<void> createEntry(String title, String body) async {
    final userId = await _userRepository.getUserId();

    final encryptionKey = await _userRepository.getEncryptionKey();

    final entry = Entry(
      title: title,
      body: body,
      userId: userId,
    );

    await _repository.createEntry(entry, key: encryptionKey);

    await getEntries();
  }

  Future<List<Entry>> searchEntries(String query) async {
    final encryptionKey = await _userRepository.getEncryptionKey();
    final userId = await _userRepository.getUserId();
    emit(
      state.copyWith(
        entries:
            await _repository.searchEntries(query, userId, key: encryptionKey),
        isLoading: false,
      ),
    );
    return state.entries;
  }

  final JournalRepository _repository;

  final UserRepository _userRepository;

  Future<void> updateEntry(Entry entry, String title, String body) async {
    isLoading(isLoading: true);

    final updatedEntry = Entry(
      id: entry.id,
      title: title,
      body: body,
      userId: entry.userId,
    );

    final encryptionKey = await _userRepository.getEncryptionKey();

    await _repository.updateEntry(updatedEntry, key: encryptionKey);

    await getEntries();
  }
}
