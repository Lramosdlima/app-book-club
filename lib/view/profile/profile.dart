import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _icon(),
            const SizedBox(width: 10),
            const Text('Perfil'),
          ],
        ),
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
        ],
      ),
    );
  }

  Widget _icon() {
    return const Icon(Icons.person, color: Colors.white, size: 30);
  }
}
