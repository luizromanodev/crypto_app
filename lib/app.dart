import 'package:flutter/material.dart';
import '../data/crypto_data_source.dart';
import '../repositories/crypto_repository.dart';
import '../screens/crypto_list_screen.dart';
import '../viewmodels/crypto_view_model.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataSource = CryptoDataSource();
    final repository = CryptoRepository(dataSource: dataSource);
    final viewModel = CryptoViewModel(repository);

    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CryptoListScreen(viewModel: viewModel),
    );
  }
}
