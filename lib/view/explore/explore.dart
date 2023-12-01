import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final int _selectedIndex = 1;
  static const List<String> _routesOptions = <String>[
    AppRoutes.HOME,
    AppRoutes.EXPLORE,
    AppRoutes.PROFILE,
  ];

  void _onItemTapped(int index) {
    setState(() {
      Navigator.of(context).pushReplacementNamed(_routesOptions[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 1,
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Explorar"),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: (const Icon(Icons.search)),
                          hintText: 'Pesquisar...',
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const TabBar(
                      tabs: [
                        Tab(text: 'Livros'),
                      ],
                    ),
                  ],
                ),
              )),
          body: _body(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Books',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }
}

_body() {
  return SizedBox();
}
