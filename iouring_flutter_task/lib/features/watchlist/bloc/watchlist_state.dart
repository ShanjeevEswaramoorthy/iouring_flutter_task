import 'package:iouring_flutter_task/features/watchlist/model/watchlist_model.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<WatchlistGroup> allGroups;
  final WatchlistGroup selectedGroup;

  WatchlistLoaded({required this.allGroups, required this.selectedGroup});
}
