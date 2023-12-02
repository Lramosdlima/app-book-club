import 'package:flutter/material.dart';

class Gender {
  final String name;
  final String description;
  final IconData icon;

  Gender(this.name, this.description, this.icon);
}

class GenderList extends StatelessWidget {
  final List<Gender> genders = [
    Gender("Ação", "Livros com muita adrenalina e lutas intensas.",
        Icons.directions_run),
    Gender("Terror", "Livros que provocam medo e suspense.",
        Icons.sentiment_very_dissatisfied_rounded),
    Gender(
        "Aventura",
        "Livros repletos de emoção, descobertas e jornadas épicas.",
        Icons.castle_rounded),
    Gender("Comédia", "Livros que buscam fazer rir e entreter.",
        Icons.sentiment_very_satisfied_outlined),
    Gender("Ficção Científica",
        "Livros que exploram o futuro e o desconhecido.", Icons.rocket_launch),
    Gender("Drama", "Livros emocionantes e envolventes.", Icons.theater_comedy),
  ];

  GenderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: genders.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(genders[index].icon),
            title: Text(genders[index].name),
            subtitle: Text(genders[index].description),
          );
        },
      ),
    );
  }
}
