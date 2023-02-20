import 'package:draemai/components/custom_surfix_icon.dart';
import 'package:flutter/material.dart';
import 'package:draemai/screens/Home/components/clipper.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size_config.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
        height: 280,
        child: ClipPath(
          clipper: BackgroundWaveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 290,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(235, 7, 2, 66),
              Color.fromARGB(210, 7, 2, 66)
            ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Home",
                        style: TextStyle(
                          fontFamily: 'krona',
                          fontSize: getProportionateScreenWidth(24),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 32.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                    ),
                    ClipOval(
                        child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: InkWell(
                        splashColor: Colors.white54, // Splash color
                        onTap: () {},
                        child: const SizedBox(
                            width: 50, height: 50, child: Icon(Icons.add)),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                )
              ],
            ),
          ),
        ));
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 139;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
