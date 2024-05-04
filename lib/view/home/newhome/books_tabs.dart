import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/view/home/collection/collection.dart';
import 'package:bookclub/view/home/newhome/book_popular.dart';
import 'package:bookclub/view/home/newhome/book_recent.dart';
import 'package:flutter/material.dart';

class BookTabs extends StatelessWidget {
  const BookTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                _miniLogo(),
                const SizedBox(width: 10),
                const Text('Book Club'),
              ],
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Populares",
              ),
              Tab(
                text: "Recentes",
              ),
              Tab(
                text: "Coleções",
              )
            ]),
          ),
          body: Container(
            color: StyleManager.instance.backgroundColor,
            child: const TabBarView(children: [
              BookPopular(),
              BookRecent(),
              CollectionPage(),
            ]),
          )),
    );
  }

  Widget _miniLogo() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
          border:
              Border.all(color: StyleManager.instance.primaryText, width: 1),
          shape: BoxShape.circle),
      child: Icon(Icons.auto_stories,
          color: StyleManager.instance.primaryText, size: 20),
    );
  }
}
