import '../data/crypto_data_source.dart';
import '../models/crypto.dart';

class CryptoRepository {
  final CryptoDataSource dataSource;

  CryptoRepository({required this.dataSource});

  Future<List<Crypto>> getCryptos({
    String symbols =
        'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO',
  }) async {
    final data = await dataSource.fetchCryptoData(symbols: symbols);
    final brlRate = await dataSource.fetchBrlRate();
    final cryptoData = data['data'] as Map<String, dynamic>;
    List<Crypto> cryptos = [];
    cryptoData.forEach((symbol, values) {
      for (var item in values) {
        cryptos.add(Crypto.fromJson(item, brlRate));
      }
    });
    return cryptos;
  }
}
