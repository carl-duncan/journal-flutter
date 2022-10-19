part of 'home_cubit.dart';

/// {@template home}
/// HomeState description
/// {@endtemplate}
class HomeState extends Equatable {
  /// {@macro home}
  const HomeState({
    this.isLoading = true,
    this.entries = const [],
    this.showSearchBar = false,
    this.category = HomeCategory.entries,
  });

  /// A description for isLoading
  final bool isLoading;

  /// A description for entries
  final List<Entry> entries;

  /// A description for showSearchBar
  final bool showSearchBar;

  final HomeCategory category;

  @override
  List<Object> get props => [isLoading, entries, showSearchBar, category];

  /// Creates a copy of the current HomeState with property changes
  HomeState copyWith({
    bool? isLoading,
    List<Entry>? entries,
    bool? showSearchBar,
    HomeCategory? category,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      entries: entries ?? this.entries,
      showSearchBar: showSearchBar ?? this.showSearchBar,
      category: category ?? this.category,
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
