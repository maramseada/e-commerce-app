import 'package:flutter/cupertino.dart';
import 'package:task1/helper/api.dart';
import 'package:task1/models/product_model.dart';
class AllProductsService{
  Future<List<ProductModel>> getAllProducts({String? query}) async {
    try {
      dynamic response = await Api().get(url: 'https://student.valuxapps.com/api/products');

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        List<dynamic> productsData = response['data']['data'];

        List<ProductModel> productList = [];
        if (query != null){
          productsData = productsData.where((element) =>
          element['name'] != null && element['name'].contains(query)).toList();        }
        for (int i = 0; i < productsData.length; i++) {
          productList.add(
            ProductModel.fromJson(productsData[i]),
          );
        }
        print(productList);
        return productList;
      }
      // If the response format is not as expected or encountered an error, throw an exception
      throw Exception('Invalid response format or missing products');
    } catch (e) {
      // Handle any exceptions here, log, or perform error handling as needed
      print('Error fetching products: $e');
      // Return an empty list or handle the error gracefully based on your application's logic
      return []; // Returning an empty list as a fallback
    }
  }


  //  List<dynamic> data = await Api().get(url: 'https://student.valuxapps.com/api/products');




  }

// class AllProductsService{
//
//   Future<List<ProductModel>> getAllProducts()async{
//     List<dynamic> data = await Api().get(url: 'https://student.valuxapps.com/api/products');
//
//     List<ProductModel> productList = [];
//     for (int i = 0; i < data.length; i++) {
//       productList.add(
//         ProductModel.fromJson(data[i]),
//       ); //decoding the values inside the list  data
//     }print(productList);
//
//     return productList;
//   }
//
// }