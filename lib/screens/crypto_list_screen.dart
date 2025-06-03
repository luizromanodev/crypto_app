import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/crypto.dart';
import '../viewmodels/crypto_view_model.dart';

class CryptoListScreen extends StatefulWidget {
  final CryptoViewModel viewModel;

  CryptoListScreen({required this.viewModel});

  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchCryptos();
  }

  void _onRefresh() async {
    await widget.viewModel.fetchCryptos(symbols: _searchController.text);
    _refreshController.refreshCompleted();
  }

  void _showDetails(BuildContext context, Crypto crypto) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${crypto.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Symbol: ${crypto.symbol}'),
            Text('Date Added: ${DateFormat.yMMMd().format(crypto.dateAdded)}'),
            Text(
              'Price USD: \$${NumberFormat.currency(symbol: '').format(crypto.priceUsd)}',
            ),
            Text(
              'Price BRL: R\$${NumberFormat.currency(symbol: '').format(crypto.priceBrl)}',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crypto List')),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Cryptos (e.g., BTC,ETH)',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => widget.viewModel.fetchCryptos(
                      symbols: _searchController.text,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: widget.viewModel,
                child: Consumer<CryptoViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (viewModel.errorMessage.isNotEmpty) {
                      return Center(child: Text(viewModel.errorMessage));
                    }
                    return ListView.builder(
                      itemCount: viewModel.cryptos.length,
                      itemBuilder: (context, index) {
                        final crypto = viewModel.cryptos[index];
                        return ListTile(
                          title: Text('${crypto.symbol} - ${crypto.name}'),
                          subtitle: Text(
                            'USD: \$${NumberFormat.currency(symbol: '').format(crypto.priceUsd)}\n'
                            'BRL: R\$${NumberFormat.currency(symbol: '').format(crypto.priceBrl)}',
                          ),
                          onTap: () => _showDetails(context, crypto),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
