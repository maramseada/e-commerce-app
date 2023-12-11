import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/Screens/product_page.dart';
import 'package:task1/Screens/profilepage.dart';
import 'package:task1/models/product_model.dart';
import 'package:task1/services/get_all_products.dart';

import '../widgets/product_card.dart';
import '../widgets/search.dart';
import 'favorites_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int indx;

  late List<Color> _iconColors;
  List<ProductModel> favoriteList = [];
  @override
  void initState() {
    // TODO: implement initState
    _iconColors = List.generate(21, (_) => Colors.grey);
    favoriteList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF195D81),
          title: Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FavoritesScreen(Favorites: favoriteList),
                    ),
                  );
                },
                icon: Icon(Icons.favorite)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/profile'); // Navigate to the 'ProfilePage' route
                },
                icon: Icon(Icons.person)),
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchData());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: FutureBuilder<List<ProductModel>>(
              future: AllProductsService().getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text('Error fetching data'),
                  );
                } else if (snapshot.hasData) {
                  List<ProductModel> products = snapshot.data!;

                  indx = products.length;
                  print(products);
                  return GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .9,
                    ),
                    itemBuilder: (context, index) {
                      var product = products[index];
                      List<bool> favoriteStatus =
                          List.generate(products.length, (index) => false);

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
                                          Icons.favorite,
                                          color:
                                              _iconColors[index] ?? Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (_iconColors[index] == Colors.grey) {
                                              favoriteList.add(product);
                                              _iconColors[index] = Colors.red;
                                            } else if (_iconColors[index] == Colors.red) {
                                              print('Product to be removed: $product');
                                              print('List contents before removal: $favoriteList');

                                              // Find and remove the specific product instance
                                              final productToRemove = favoriteList.firstWhere(
                                                    (item) => item.id == product.id, // Assuming 'id' is a unique identifier
                                              );

                                              if (productToRemove != null) {
                                                favoriteList.remove(productToRemove);
                                                _iconColors[index] = Colors.grey;
                                                print('Removed: $productToRemove');
                                              } else {
                                                print('Product not found in the list');
                                              }

                                              print('List contents after removal: $favoriteList');
                                            }
                                            print('Favorite List: $favoriteList');
                                          });
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
                  );
                } else {
                  return Center(
                    child: Text(''),
                  );
                }
              },
            ),
          ),
        ));
  }
}
