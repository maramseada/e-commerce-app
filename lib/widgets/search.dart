import 'package:flutter/material.dart';
import 'package:task1/widgets/product_card.dart';

import '../Screens/product_page.dart';
import '../models/product_model.dart';
import '../services/get_all_products.dart';
import 'package:flutter/material.dart';

class SearchData extends SearchDelegate<String> {
  late int indx;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder<List<ProductModel>>(
        future: AllProductsService().getAllProducts(query: query),
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
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .9,
              ),
              itemBuilder: (context, index) {
                var product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ProductPage.id,
                        arguments: ScreenArguments(
                          product: product,
                          index: index,
                        ));
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
              child: Text('No results found'),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(child: Text('Search')); // Placeholder, modify as needed
  }
}
