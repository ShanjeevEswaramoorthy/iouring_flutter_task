class WatchlistGroup {
  final String groupName;
  final List<StockSymbol> symbols;

  WatchlistGroup({required this.groupName, required this.symbols});
}

class StockSymbol {
  final String name;
  final String exchange;
  final int buyQty;
  final double buyPrice;
  final int sellQty;
  final double sellPrice;
  final double lastTradedPrice;
  final double change;
  final double changePercent;
  final bool is52WeekLow;

  StockSymbol({
    required this.name,
    required this.exchange,
    required this.buyQty,
    required this.buyPrice,
    required this.sellQty,
    required this.sellPrice,
    required this.lastTradedPrice,
    required this.change,
    required this.changePercent,
    this.is52WeekLow = false,
  });

  factory StockSymbol.fromJson(Map<String, dynamic> json) {
    return StockSymbol(
      name: json['name'],
      exchange: json['exchange'],
      buyQty: json['buyQty'],
      buyPrice: (json['buyPrice'] as num).toDouble(),
      sellQty: json['sellQty'],
      sellPrice: (json['sellPrice'] as num).toDouble(),
      lastTradedPrice: (json['lastTradedPrice'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      is52WeekLow: json['is52WeekLow'] ?? false,
    );
  }
}
