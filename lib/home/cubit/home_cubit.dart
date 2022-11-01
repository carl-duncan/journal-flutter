import 'dart:async';
import 'dart:developer';

import 'package:authentication_helper/authentication_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal/home/widgets/home_category_selector.dart';
import 'package:journal/l10n/l10n.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._repository,
    this._userRepository,
    this._keyStoreRepository,
    this._localizations,
    this._authenticationHelper,
  ) : super(const HomeInitial()) {
    init();
  }

  Future<void> init() async {
    await _keyStoreRepository.initialize();
    await setUpNewUser();
    await getEntries();
  }

  String? get encryptionKey =>
      state.isLocked ? null : _keyStoreRepository.get(_encryptionKey);

  bool keyExists() {
    try {
      return _keyStoreRepository.get(_encryptionKey) != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> setUpNewUser() async {
    final doesKeyExist = keyExists();
    final userId = await _userRepository.getUserId();
    final entries = await _repository.getEntries(userId);
    if (!doesKeyExist && entries.isEmpty) {
      final key = await _keyStoreRepository.generate(_encryptionKey);
      await _repository.createEntry(
        Entry(
          title: _localizations.thankYouForTheSupport,
          body: _localizations.thankYouForTheSupportDescription,
          userId: userId,
        ),
        key: key,
      );
    }
  }

  Future<void> getEntries() async {
    final userId = await _userRepository.getUserId();

    emit(
      state.copyWith(
        entries: await _repository.getEntries(
          userId,
          key: encryptionKey,
        ),
        isLoading: false,
      ),
    );
  }

  Future<void> toggleSearchBar() async {
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

  Future<void> toggleLock() async {
    if (state.isLocked) {
      final entries = await _repository.getEntries(
        await _userRepository.getUserId(),
        key: _keyStoreRepository.get(_encryptionKey),
      );

      final isAuthenticated = await _authenticationHelper
          .authenticated(_localizations.unlockYourJournal);

      if (!isAuthenticated) {
        return;
      }

      emit(
        state.copyWith(
          isLocked: false,
          entries: entries,
          showSearchBar: false,
          searchEntries: [],
        ),
      );
    } else {
      emit(
        state.copyWith(
          isLocked: true,
          entries: await _repository.getEntries(
            await _userRepository.getUserId(),
          ),
          showSearchBar: false,
          searchEntries: [],
        ),
      );
    }
  }

  Future<void> createEntry(String title, String body) async {
    isLoading(isLoading: true);

    final userId = await _userRepository.getUserId();

    if (encryptionKey == null) {
      isLoading(isLoading: false);
      return;
    }

    final entry = Entry(
      title: title,
      body: body,
      userId: userId,
    );

    await _repository.createEntry(entry, key: encryptionKey!);

    await getEntries();
  }

  Future<List<Entry>> searchEntries(String query) async {
    final userId = await _userRepository.getUserId();
    emit(
      state.copyWith(
        searchEntries: await _repository.searchEntries(
          query,
          userId,
          key: encryptionKey,
        ),
        isLoading: false,
      ),
    );
    return state.entries;
  }

  void setKeyAndRefresh(String key) {
    isLoading(isLoading: true);
    log('setKeyAndRefresh $key');
    _keyStoreRepository.set(_encryptionKey, key);
    getEntries();
  }

  final JournalRepository _repository;

  final UserRepository _userRepository;

  final KeyStoreRepository _keyStoreRepository;

  final AppLocalizations _localizations;

  final AuthenticationHelper _authenticationHelper;

  final String _encryptionKey = 'encryption_key';

  Future<void> updateEntry(Entry entry, String title, String body) async {
    isLoading(isLoading: true);

    final updatedEntry = Entry(
      id: entry.id,
      title: title,
      body: body,
      userId: entry.userId,
    );

    if (encryptionKey == null) {
      isLoading(isLoading: false);
      return;
    }

    await _repository.updateEntry(updatedEntry, key: encryptionKey!);

    await getEntries();
  }

  void signOut() {
    _keyStoreRepository.delete(_encryptionKey);
    _userRepository.signOut();
  }

  void deleteEntry(Entry entry) {
    isLoading(isLoading: true);

    if (encryptionKey == null) {
      isLoading(isLoading: false);
      return;
    }

    _repository.deleteEntry(entry);
    getEntries();
  }
}
