import 'package:flutter/material.dart';
import 'package:flutter_utsmobile/modles/categories_modle.dart';
import 'package:flutter_utsmobile/provider/my_provider.dart';
import 'package:provider/provider.dart';

class Homepage2 extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage2> {
  final MyProvider myProvider = MyProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
        child: FutureBuilder(
          future: myProvider.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Ketika data masih dimuat, tampilkan indikator loading
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Jika terjadi kesalahan, tampilkan pesan kesalahan
              return Text('Error: ${snapshot.error}');
            } else {
              // Jika data sudah dimuat, tampilkan daftar produk
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: myProvider.categoriesList.length,
                itemBuilder: (context, index) {
                  CategoriesModle product = myProvider.categoriesList[index];
                  return ProductCard(
                    productName: product.name,
                    productImage: product.image,
                    productPrice: product.price,
                    productId: product.id,
                    myProvider: myProvider,
                    // Anda dapat menyesuaikan widget ProductCard sesuai kebutuhan
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  final MyProvider myProvider = MyProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
        child: FutureBuilder(
          future: myProvider.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: myProvider.categoriesList.length,
                itemBuilder: (context, index) {
                  CategoriesModle product = myProvider.categoriesList[index];
                  return ProductCard(
                    productName: product.name,
                    productImage: product.image,
                    productPrice: product.price,
                    productId: product.id,
                    myProvider: myProvider,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productId;
  final String productName;
  final String productImage;
  final int productPrice;
  final MyProvider myProvider;

  const ProductCard({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.myProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2.0,
        color: Colors.black, // Tambahkan properti color di sini
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              // Gunakan Flexible untuk gambar agar menghindari overflow
              child: Image.network(
                productImage,
                height: 100.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                // Gunakan Expanded untuk widget teks agar mengambil ruang yang tersedia
                child: Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                // Gunakan Expanded untuk widget teks agar mengambil ruang yang tersedia
                child: Text(
                  '\$$productPrice',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showEditDialog(context, productId, myProvider);
                  },
                  child: Text('Edit'),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    _showDeleteConfirmationDialog(
                        context, productId, myProvider);
                  },
                  child: Text('Hapus'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String productId, MyProvider myProvider) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Anda yakin ingin menghapus produk ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () async {
                await myProvider.deleteProduct(productId);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Homepage2()),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(
      BuildContext context, String productId, MyProvider myProvider) async {
    String editedName =
        ''; // You can initialize this with the current name for editing
    double editedPrice =
        0.0; // You can initialize this with the current price for editing

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Produk'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Nama Produk'),
                  onChanged: (value) {
                    editedName = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    editedPrice = double.parse(value);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Simpan'),
              onPressed: () async {
                // Call the editProduct function to save changes
                await myProvider.editProduct(
                    productId, editedName, editedPrice);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Homepage2()),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}