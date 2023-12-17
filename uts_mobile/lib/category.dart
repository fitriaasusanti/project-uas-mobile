import 'package:flutter/material.dart';
import 'package:flutter_utsmobile/fooditem.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  final List<FoodItem> foods;

  CategoryPage({required this.category, required this.foods});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<FoodItem> displayedFoods;

  @override
  void initState() {
    super.initState();
    displayedFoods = widget.foods;
  }

  void _performSearch(String query) {
    setState(() {
      displayedFoods = widget.foods
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final String? query = await showSearch(
                context: context,
                delegate: FoodSearchDelegate(widget.foods),
              );

              if (query != null) {
                _performSearch(query);
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        itemCount: displayedFoods.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 30,
            color: Colors.black, // Warna latar belakang hitam
            child: InkWell(
              onTap: () {
                // Tambahkan logika jika diperlukan saat item diklik
              },
              child: Container(
                height: 100, // Sesuaikan tinggi produk
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        displayedFoods[index].image,
                        height: 50, // Sesuaikan tinggi gambar
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  displayedFoods[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Warna teks putih
                                    fontSize: 18, // Ukuran teks nama produk
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  // Tambahkan logika jika diperlukan saat tombol like/love diklik
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            displayedFoods[index].price,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16, // Ukuran teks harga
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rating: ${displayedFoods[index].rating}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14, // Ukuran teks rating
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  displayedFoods[index].rating.toInt(),
                                  (index) => Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodSearchDelegate extends SearchDelegate<String> {
  final List<FoodItem> foods;

  FoodSearchDelegate(this.foods);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = foods
        .where((food) => food.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index].name),
          onTap: () {
            close(context, results[index].name);
          },
        );
      },
    );
  }
}
