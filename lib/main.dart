import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF121212),
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  // Demo data - tumi nijer data diye replace korte paro
  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Mango',
    'Orange',
    'Pineapple',
    'Grapes',
    'Watermelon',
    'Strawberry',
    'Papaya',
    'Guava',
  ];

  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_allItems);
  }

  void _onSearch(String query) {
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Search bar
              TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _onSearch('');
                          },
                        ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.08),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Results list
              Expanded(
                child: _filteredItems.isEmpty
                    ? const Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(color: Colors.white38),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.star_border),
                              title: Text(_filteredItems[index]),
                              onTap: () {},
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}