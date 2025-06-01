import 'package:iouring_flutter_task/core/mock_data.dart';
import 'package:iouring_flutter_task/features/watchlist/model/watchlist_model.dart';

class WatchlistRepository {
  List<WatchlistGroup> fetchAllWatchlists() {
    final groups = mockWatchlistResponse['groups'] as List;

    return groups.map((groupData) {
      final groupName = groupData['groupName'] as String;
      final symbolsData = groupData['symbols'] as List;
      final symbols =
          symbolsData.map((json) => StockSymbol.fromJson(json)).toList();

      return WatchlistGroup(groupName: groupName, symbols: symbols);
    }).toList();
  }
}
