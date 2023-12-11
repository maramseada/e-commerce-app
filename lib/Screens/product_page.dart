import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task1/Screens/simple_map_screen.dart';

import '../models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenArguments {
  final ProductModel product;
  final int index;

  ScreenArguments({required this.product, required this.index});
}

class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
  });
  static String id = 'productPage';
  @override
  Widget build(BuildContext context) {
    //Size screenSize = MediaQuery.of(context).size;

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFF195D81),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height:
                            240.h, // Provide a specific height or adjust as needed
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (var imageUrl in args.product.images)
                              Center(
                                child: Container(
                                  margin: EdgeInsets.all(
                                      30.0), // Adjust margin as needed
                                  child: Image.network(
                                    imageUrl,
                                    width: 360, // Set width as needed
                                    height: 230.h, // Set height as needed
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        args.product.name,
                        style: TextStyle(fontSize: 14.sp),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    SizedBox(height: 15.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${args.product.price}' r' LE',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.sp),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h,),

                    Container(
                        height: 200.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Description',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp, color: Colors.black54),
                              ),
                            ),
                            Container(
                              height: 130.h,
                              width: double.infinity,
                              padding:  EdgeInsets.only(top: 10.h, bottom: 30.h),
                              child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),   child: Text(
                                args.product.description,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.black54),
                              )),
                            ),



                            ElevatedButton(

                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return SimpleMapScreen();
                                  }),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor: Color(0xFF195D81),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          50)))),
                              child: Text('Go to maps', style: TextStyle(fontSize: 16.sp),),
                            )
                          ],
                        )),
                  ],
                ),
              )),
        ));
  }
}
