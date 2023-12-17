import 'package:flutter/material.dart';
import 'package:flutter_utsmobile/category.dart';
import 'package:flutter_utsmobile/fooditem.dart';
import 'package:flutter_utsmobile/home_page.dart';
import 'package:flutter_utsmobile/item_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_utsmobile/itemscreen2.dart';

class HomeScreen extends StatelessWidget {
  List<String> food = [
    "Burger",
    "Pizza",
    "Snacks",
    "Water",
  ];

  List<String> foods2 = [
    "Chicken Burger",
    "Cheese Pizza",
  ];

  List<Color> bgColors = [
    Color(0xFFFFDCDA),
    Color(0xFFD4EEF3),
    Color(0xFFFAE6D5),
    Color(0xFFEFCFE7),
  ];

  List<String> carouselImages = [
    "images/banner1.jpg",
    "images/banner2.jpg",
    "images/banner3.jpg",
    // Add more images as needed
  ];

  void navigateToItemScreen(BuildContext context, String foodName) {
    switch (foodName) {
      case "Chicken Burger":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemScreen(
              itemName: "Chicken Burger",
              // Tambahkan parameter lain jika diperlukan
            ),
          ),
        );
        break;
      case "Cheese Pizza":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => itemscreen2(
              itemName: "Cheese Pizza",
              // Tambahkan parameter lain jika diperlukan
            ),
          ),
        );
        break;
      // Tambahkan case untuk produk makanan lainnya
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Antar Ke",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFFFF2F08),
                          ),
                          Text(
                            "Dinoyo, Malang",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFFFF2F08),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage("images/profile.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            color: Color(0xFFFFF2F08),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Cari Makanan Favoritmu...",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF2F08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  // Handle page change if needed
                },
              ),
              items: carouselImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Kategori",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage2()),
                      );
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(
                        color: Color(0xFFFF2F08),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                itemCount: food.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigasi ke halaman sesuai kategori makanan
                      switch (food[index]) {
                        case "Burger":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                category: "Burger",
                                foods: [
                                  FoodItem(
                                    name: "Beef Burger",
                                    image: "images/Burger1.jpg",
                                    price: "Rp 50,000",
                                    rating:
                                        5.0, // Masukkan nilai rating sesuai kebutuhan
                                  ),
                                  FoodItem(
                                    name: "Veggie Burger",
                                    price: "RP. 65,000",
                                    image: "images/Burger2.jpg",
                                    rating: 4.0,
                                  ),
                                  FoodItem(
                                    name: "Fish Burger",
                                    price: "RP. 70.000",
                                    image: "images/Burger3.jpg",
                                    rating: 3.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                          break;
                        case "Pizza":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                category: "Pizza",
                                foods: [
                                  FoodItem(
                                    name: "Margherita Pizza",
                                    price: "RP. 105.000",
                                    image: "images/pizza1.jpg",
                                    rating: 5.0,
                                  ),
                                  FoodItem(
                                    name: "Pepperoni Pizza",
                                    price: "RP. 120.000",
                                    image: "images/pizza2.jpg",
                                    rating: 4.0,
                                  ),
                                  FoodItem(
                                    name: "Vegetarian Pizza",
                                    price: "RP. 200.000",
                                    image: "images/pizza3.jpg",
                                    rating: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                          break;
                        case "Snacks":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                category: "Snacks",
                                foods: [
                                  FoodItem(
                                    name: "Chips",
                                    price: "RP. 25.000",
                                    image: "images/snack1.jpg",
                                    rating: 4.0,
                                  ),
                                  FoodItem(
                                    name: "Tachos",
                                    price: "RP. 45.000",
                                    image: "images/snack2.jpg",
                                    rating: 4.0,
                                  ),
                                  FoodItem(
                                    name: "Popcorn",
                                    price: "RP. 60.000",
                                    image: "images/snack3.jpg",
                                    rating: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                          break;
                        case "Water":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(
                                category: "Water",
                                foods: [
                                  FoodItem(
                                    name: "Float",
                                    price: "RP. 46.000",
                                    image: "images/water1.jpg",
                                    rating: 4.0,
                                  ),
                                  FoodItem(
                                    name: "Sparkling Water",
                                    price: "RP. 75.000",
                                    image: "images/water2.jpg",
                                    rating: 4.0,
                                  ),
                                  FoodItem(
                                    name: "Flavored Water",
                                    price: "RP. 86.000",
                                    image: "images/water3.jpg",
                                    rating: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 15),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: bgColors[index],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "images/${food[index]}.png",
                            height: 80,
                            width: 80,
                          ),
                          Text(
                            food[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Populer",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "See All",
                      style: TextStyle(
                        color: Color(0xFFFF2F08),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                itemCount: foods2.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      navigateToItemScreen(context, foods2[index]);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      margin: EdgeInsets.only(
                          left: 15, top: 5, bottom: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              "images/${foods2[index]}.jpg",
                              height: 120,
                              width: MediaQuery.of(context).size.width / 1.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      foods2[index],
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Fast Food",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFFFF2F08),
                                          size: 20,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "4.5",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "(941 ratings)",
                                          style: TextStyle(
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Color(0xFFFF2F08),
                                            size: 20,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "2,5 KM",
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF2F08),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        "\45K",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
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
                  );
                },
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
