import 'package:bookclub/view/admin/admin.dart';
import 'package:bookclub/view/home/newhome/bookstore.dart';
import 'package:bookclub/view/home/newhome/constants.dart';
import 'package:bookclub/view/home/newhome/data.dart';
import 'package:bookclub/view/home/principal.dart';
import 'package:bookclub/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'collection_folder/collection.dart';
import 'collection_folder/collection_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pageOptions = <Widget>[
    const CollectionPage(),
    const AdminPage(),
    const ProfilePage(),
  ];

  List<NavigationItem> navigationItems = getNavigationItemList();
  NavigationItem? selectedItem;

    @override
  void initState() {
    super.initState();
    setState(() {
      selectedItem = navigationItems[0];
    });
  }

  void _onItemTapped(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        body: _body(),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 8,
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buildNavigationItems(),
        ),
      ),
      ),
    );
  }

  _body() {
    return _pageOptions[_currentIndex];
  }

  List<Widget> buildNavigationItems() {
    List<Widget> list = [];
    for (var navigationItem in navigationItems) {
      list.add(buildNavigationItem(navigationItem));
    }
    return list;
  }

  Widget buildNavigationItem(NavigationItem item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = item;
        });
      },
      child: Container(
        width: 50,
        child: Center(
          child: Icon(
            item.iconData,
            color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
            size: 28,
          ),
        ),
      ),
    );
  }
}
