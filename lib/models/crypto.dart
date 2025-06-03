import 'package:intl/intl.dart';

class Crypto {
  final String id;
  final String name;
  final String symbol;
  final DateTime dateAdded;
  final double priceUsd;
  final double priceBrl;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.dateAdded,
    required this.priceUsd,
    required this.priceBrl,
  });

  factory Crypto.fromJson(Map<String, dynamic> json, double brlRate) {
    final data = json['quote']['USD'];
    return Crypto(
      id: json['id'].toString(),
      name: json['name'],
      symbol: json['symbol'],
      dateAdded: DateTime.parse(json['date_added']),
      priceUsd: double.parse(data['price']),
      priceBrl: double.parse(data['price']) * brlRate,
    );
  }
}
