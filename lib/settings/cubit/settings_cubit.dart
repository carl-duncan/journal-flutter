import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  // ignore: unused_field
  final JournalRepository _repository;

  final UserRepository _userRepository;

  final KeyStoreRepository _keyStoreRepository;
}
