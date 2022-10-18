import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:journal_api/journal_api.dart';
import 'package:journal_repository/journal_repository.dart';
import 'package:single_store_api/single_store_api.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial()) {
    getEntries();
  }

  Future<void> getEntries() async {
    emit(state.copyWith(entries: await _repository.getEntries()));
  }

  JournalApi get _api => SingleStoreApi(
        dio: Dio(),
      );

  JournalRepository get _repository => JournalRepository(_api);
}
