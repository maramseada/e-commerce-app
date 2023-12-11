import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/Screens/product_page.dart';
import 'package:task1/services/get_all_products.dart';

import '../models/product_model.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatefulWidget {
  List<ProductModel> Favorites;
  FavoritesScreen({super.key, required this.Favorites});
  static String id = 'FavoritesScreen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late int indx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF195D81),
        title: const Text('Favorites'),
        centerTitle: true,

      ),
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child:
     GridView.builder(
        itemCount: widget.Favorites.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .9,
        ),
        itemBuilder: (context, index) {
          var product =  widget.Favorites[index];
          List<bool> favoriteStatus =
          List.generate( widget.Favorites.length, (index) => false);

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductPage.id,
                  arguments: ScreenArguments(
                      product: product, index: index));
            },
            child: Container(
              child: Card(
                color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 180,
                        color: Colors.white,
                        child: Image.network(
                          product.image,
                          height: 90,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        product.name.substring(0, 10),
                        style:
                        TextStyle(color: Colors.grey.shade600),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${product.price}' r' LE'),
                          IconButton(
                            icon: Icon(
                              Icons.restore_from_trash_rounded,

                            ),
                            onPressed: () {
                              setState(() {

                                  print('Product to be removed: $product');
                                  print('List contents before removal: ${widget.Favorites}');

                                  // Find and remove the specific product instance
                                  final productToRemove =     widget.Favorites.firstWhere(
                                        (item) => item.id == product.id, // Assuming 'id' is a unique identifier
                                  );

                                  if (productToRemove != null) {
                                    widget.Favorites.remove(productToRemove);
                                    print('Removed: $productToRemove');
                                  } else {
                                    print('Product not found in the list');
                                  }

                                  print('List contents after removal: ${widget.Favorites}');
                                }

                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
        ),
      ),
    );
  }
}
