import 'package:flutter/foundation.dart';
import '../models/crypto.dart';
import '../repositories/crypto_repository.dart';

class CryptoViewModel extends ChangeNotifier {
  final CryptoRepository repository;
  List<Crypto> cryptos = [];
  bool isLoading = false;
  String errorMessage = '';

  CryptoViewModel(this.repository);

  Future<void> fetchCryptos({String? symbols}) async {
    isLoading = true;
    notifyListeners();

    try {
      cryptos = await repository.getCryptos(
        symbols:
            symbols ??
            'BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO',
      );
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
