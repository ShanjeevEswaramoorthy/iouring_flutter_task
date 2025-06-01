abstract class WatchlistEvent {}

class LoadWatchlists extends WatchlistEvent {}

class SelectWatchlistGroup extends WatchlistEvent {
  final int? index;
  SelectWatchlistGroup({this.index});
}
