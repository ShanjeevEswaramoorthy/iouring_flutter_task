import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allSymbols = [
    'TCS',
    'INFY',
    'WIPRO',
    'NATIONALUM',
    'TITAN',
    'UPL',
    'ULTRACEMCO',
    'TECHM',
    'RELIANCE',
    'HDFCBANK',
    'ICICIBANK',
    'SBIN',
  ];

  List<String> _filteredSymbols = [];

  @override
  void initState() {
    super.initState();
    _filteredSymbols = _allSymbols;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSymbols =
          _allSymbols
              .where((symbol) => symbol.toLowerCase().contains(query))
              .toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(icon: const Icon(Icons.clear), onPressed: _clearSearch),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search symbols...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _filteredSymbols.isEmpty
                    ? const Center(child: Text('No results found'))
                    : ListView.builder(
                      itemCount: _filteredSymbols.length,
                      itemBuilder: (context, index) {
                        final symbol = _filteredSymbols[index];
                        return ListTile(
                          title: Text(symbol),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Do something with the selected symbol
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Tapped on $symbol')),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
