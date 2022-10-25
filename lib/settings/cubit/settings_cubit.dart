import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:user_repository/user_repository.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository, this._userRepository)
      : super(const SettingsInitial());

  FutureOr<void> signOut() {
    _userRepository.signOut();
  }

  final JournalRepository _repository;

  final UserRepository _userRepository;
}
