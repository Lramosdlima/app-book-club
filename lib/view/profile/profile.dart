import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
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
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
