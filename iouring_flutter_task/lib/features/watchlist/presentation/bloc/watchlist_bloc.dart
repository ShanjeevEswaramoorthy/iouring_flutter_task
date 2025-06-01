import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iouring_flutter_task/features/watchlist/data/repository/watchlist_repository.dart';
import 'package:iouring_flutter_task/features/watchlist/data/model/watchlist_model.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository repository;

  late List<WatchlistGroup> _watchlists;

  WatchlistBloc(this.repository) : super(WatchlistInitial()) {
    on<LoadWatchlists>(_onLoadWatchlists);
    on<SelectWatchlistGroup>(_onSelectGroup);
  }

  void _onLoadWatchlists(
    LoadWatchlists event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    try {
      _watchlists = repository.fetchAllWatchlists();
      emit(
        WatchlistLoaded(
          allGroups: _watchlists,
          selectedGroup: _watchlists.first,
        ),
      );
    } catch (e) {
      emit(WatchlistError(message: 'Failed to load watchlists: $e'));
    }
  }

  void _onSelectGroup(
    SelectWatchlistGroup event,
    Emitter<WatchlistState> emit,
  ) {
    emit(WatchlistLoading());
    try {
      final selected = _watchlists[event.index ?? 0];
      emit(WatchlistLoaded(allGroups: _watchlists, selectedGroup: selected));
    } catch (e) {
      emit(WatchlistError(message: 'Failed to select watchlist group: $e'));
    }
  }
}
