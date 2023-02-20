import 'package:draemai/screens/create/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScrollView extends StatelessWidget {
  List<Map<String, String>> Posts = [
    {"imageUrl": "assets/images/test/1.jpg", "title": ""},
    {"imageUrl": "assets/images/test/2.jpg", "title": ""},
    {"imageUrl": "assets/images/test/3.jpg", "title": ""},
    {"imageUrl": "assets/images/test/4.jpg", "title": ""},
    {"imageUrl": "assets/images/test/5.jpg", "title": ""},
    {"imageUrl": "assets/images/test/6.jpg", "title": ""},
    {"imageUrl": "assets/images/test/7.jpg", "title": ""},
    {"imageUrl": "assets/images/test/8.jpg", "title": ""},
  ];

  final posts = [
    "assets/images/test/1.jpg",
    "assets/images/test/2.jpg",
    "assets/images/test/3.jpg",
    "assets/images/test/4.jpg",
    "assets/images/test/5.jpg",
    "assets/images/test/6.jpg",
    "assets/images/test/7.jpg",
    "assets/images/test/8.jpg",
  ];

  HomeScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: MasonryView(
        listOfItem: posts,
        numberOfColumn: 2,
        //crossAxisCount: 2,
        //mainAxisSpacing: 8,
        //crossAxisSpacing: 8,
        //itemCount: posts.length,
        itemBuilder: (index) {
          return Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  index,
                  //posts[index]["imageUrl"]!,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Posts",
                    //posts[index]["title"]!,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      // showModalBottomSheet(
                      //   backgroundColor: Colors.transparent,
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return BottomPopUp(context);
                      //   },
                      // );
                      Navigator.pushNamed(context, CreateScreen.routeName,
                          arguments: index);
                    },
                    child: const Icon(Icons.more_horiz_sharp),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container BottomPopUp(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Share to",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(
            height: 17,
          ),
          SizedBox(
            height: 100.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: posts.length, //sharePosts.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 90,
                  child: Column(children: const [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 35,
                      backgroundImage: AssetImage(
                        'assets/images/test/1.jpg',
                      ),
                    ),
                    Spacer(),
                    Text(
                      //sharePosts[index].id,
                      //posts[index]["text"]!,
                      "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ]),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: Divider(
              color: Colors.grey,
              height: 5,
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "This Pin was inspired by your recent activity",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hide",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Report",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 26),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey.shade300),
              child: const Text("Close",
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          )
        ],
      ),
    );
  }
}
