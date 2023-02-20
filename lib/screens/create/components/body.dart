import 'dart:async';
import 'dart:ui' as ui;
import 'package:draemai/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  final image;
  const Body({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final posts = ["assets/images/test/1.jpg"];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create",
                    style: TextStyle(
                      fontFamily: 'krona',
                      fontSize: getProportionateScreenWidth(24),
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ClipOval(
                      child: Card(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: InkWell(
                      splashColor: Colors.white54, // Splash color
                      onTap: () {},
                      child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                    ),
                  ))
                ]),
          ),
          MasonryView(
            listOfItem: posts,
            numberOfColumn: 1,
            //crossAxisCount: 2,
            //mainAxisSpacing: 8,
            //crossAxisSpacing: 8,
            //itemCount: posts.length,
            itemBuilder: (index) {
              Image pic = Image.asset(index);
              Completer<ui.Image> completer = Completer<ui.Image>();
              pic.image.resolve(const ImageConfiguration()).addListener(
                  ImageStreamListener((ImageInfo info, bool synchronousCall) {
                completer.complete(info.image);
                print("completer: w ${info.image}");
              }));
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      image,
                      //posts[index]["imageUrl"]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
