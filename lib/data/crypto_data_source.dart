import 'dart:convert';
import 'package:http/http.dart' as http;

class CryptoDataSource {
  final String apiKey = 'e1009cce-a973-47ac-963d-c13224359646';
  final String baseUrl =
      'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

  Future<Map<String, dynamic>> fetchCryptoData({
    String symbols =
        'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO',
  }) async {
    final response = await http.get(
      Uri.parse('$baseUrl?symbol=$symbols'),
      headers: {'Accepts': 'application/json', 'X-CMC_PRO_API_KEY': apiKey},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load crypto data: ${response.statusCode}');
    }
  }

  Future<double> fetchBrlRate() async {
    return 5.5;
  }
}
