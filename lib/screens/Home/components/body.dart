import 'package:draemai/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:draemai/screens/Home/components/CustomAppBar.dart';
import 'package:draemai/screens/Home/components/masonaryView.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ignore: prefer_const_constructors
          SliverPersistentHeader(
            delegate: SliverSearchAppBar(),
            // Set this param so that it won't go off the screen when scrolling
            pinned: true,
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return HomeScrollView();
          }, childCount: 1))
        ],
      ),
    );
  }
}
