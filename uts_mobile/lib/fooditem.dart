class FoodItem {
  String name;
  String image;
  String price;
  double rating; // Tambahkan properti rating

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    required this.rating, // Tambahkan parameter rating pada konstruktor
  });

  // Metode getter untuk rating
  double getRating() {
    return rating;
  }
}

// Contoh penggunaan:
// var food = FoodItem(
//   name: "Nama Produk",
//   image: "path/to/image.jpg",
//   price: "Rp 50,000",
//   rating: 4.5, // Masukkan nilai rating sesuai kebutuhan
// );
