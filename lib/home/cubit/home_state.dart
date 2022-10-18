part of 'home_cubit.dart';

/// {@template home}
/// HomeState description
/// {@endtemplate}
class HomeState extends Equatable {
  /// {@macro home}
  const HomeState({
    this.isLoading = true,
    this.entries = const [],
  });

  /// A description for isLoading
  final bool isLoading;

  /// A description for entries
  final List<Entry> entries;

  @override
  List<Object> get props => [isLoading, entries];

  /// Creates a copy of the current HomeState with property changes
  HomeState copyWith({
    bool? isLoading,
    List<Entry>? entries,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      entries: entries ?? this.entries,
    );
  }
}

/// {@template home_initial}
/// The initial state of HomeState
/// {@endtemplate}
class HomeInitial extends HomeState {
  /// {@macro home_initial}
  const HomeInitial() : super();
}
