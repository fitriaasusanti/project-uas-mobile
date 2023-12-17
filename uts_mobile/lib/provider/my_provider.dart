import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utsmobile/home_page.dart';
import 'package:flutter_utsmobile/modles/categories_modle.dart'; // Import ini untuk ChangeNotifier


class ProductService {
  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .delete();
  }
}


class MyProvider extends ChangeNotifier {
  List<CategoriesModle> categoriesList = [];

  Future<void> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('categories')
              .doc('PppoEw7lbTCSLU1lflWt')
              .collection('burger')
              .get();

      categoriesList = querySnapshot.docs.map((doc) {
        return CategoriesModle(
          image: doc.data()['image'],
          name: doc.data()['name'],
          price: doc.data()['price'],
          id: doc.id,
        );
      }).toList();

      notifyListeners(); // Memberi tahu pendengar setelah memperbarui daftar
    } catch (e) {
      print('Error fetching categories: $e');
      // Tangani kesalahan, lempar atau catat sesuai kebutuhan
    }
  }


  Future<void> deleteProduct(String productId) async {
   try {
      // Adjust the collection path and document ID as needed
      await FirebaseFirestore.instance
          .collection('categories')
          .doc('PppoEw7lbTCSLU1lflWt')
          .collection('burger')
          .doc(productId)
          .delete();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }


  Future<void> editProduct(String productId, String newName, double newPrice) async {
    try {
      // Adjust the collection path and document ID as needed
      await FirebaseFirestore.instance
          .collection('categories')
          .doc('PppoEw7lbTCSLU1lflWt')
          .collection('burger')
          .doc(productId)
          .update({
        'name': newName,
        'price': newPrice,
      });
      // Notify listeners after updating the product
      notifyListeners();
    } catch (e) {
      print('Error editing product: $e');
    }
  }

}



