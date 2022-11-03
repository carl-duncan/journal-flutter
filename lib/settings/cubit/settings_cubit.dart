import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:key_store_repository/key_store_repository.dart';
import 'package:user_repository/user_repository.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._repository,
    this._userRepository,
    this._keyStoreRepository,
  ) : super(const SettingsInitial());

  final String _encryptionKey = 'encryption_key';

  FutureOr<void> signOut() {
    _keyStoreRepository.delete(_encryptionKey);
    _userRepository.signOut();
  }

  void copyKey() {
    final key = _keyStoreRepository.get(_encryptionKey);
    Clipboard.setData(ClipboardData(text: key));
    log('Copied key to clipboard');
  }

  // ignore: unused_field
  final JournalRepository _repository;

  final UserRepository _userRepository;

  final KeyStoreRepository _keyStoreRepository;
}
