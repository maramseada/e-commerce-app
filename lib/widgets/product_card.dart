
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/product_page.dart';
import '../models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final int index;
  final int indxlength;

  ProductCard({
    required this.product,
    required this.index,
    required this.indxlength,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState(
    product: product,
    index: index,
    indxlength: indxlength,
  );
}

class _ProductCardState extends State<ProductCard> {
  late List<Color> _iconColors;
  final ProductModel product;
  final int index;
  final int indxlength;

  _ProductCardState({
    required this.product,
    required this.index,
    required this.indxlength,
  });

  @override
  void initState() {
    super.initState();
    _iconColors = List.generate(indxlength, (_) => Colors.grey);
    // Initialize _iconColors list
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){  Navigator.pushNamed(context, ProductPage.id, arguments: ScreenArguments(
          product: product, index: index
      ));
      },


      child: Container(
        child: Card(
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  width: 180,
                  color: Colors.white,
                  child:  Image.network(
                    product.image,
                    height: 90,
                  ),
                ),

                SizedBox(height: 12,),
                Text(
                  product.name.substring(0, 10),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 Text('${product.price}'r' LE'),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: _iconColors[index] ?? Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_iconColors[index] == Colors.red) {
                            _iconColors[index] = Colors.grey;
                          } else {
                            _iconColors[index] = Colors.red;
                          }
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
  }
}
