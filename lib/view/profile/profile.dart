import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _selectedIndex = 2;
  static const List<String> _routesOptions = <String>[
    AppRoutes.HOME,
    AppRoutes.ADMIN,
    AppRoutes.PROFILE,
  ];

  void _onItemTapped(int index) {
    setState(() {
      Navigator.of(context).pushReplacementNamed(_routesOptions[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Perfil'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Nome'),
            subtitle: Text('John Doe'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('johndoe31@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Telefone'),
            subtitle: Text('(11) 99999-9999'),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Endereço'),
            subtitle: Text('Rua dos Bobos, 0'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Birth Date'),
            subtitle: Text('01/01/2000'),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Favorite Book'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Livros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Administrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
