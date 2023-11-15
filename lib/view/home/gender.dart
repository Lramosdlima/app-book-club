import 'package:flutter/material.dart';

class Gender {
  final String name;
  final String description;

  Gender(this.name, this.description);
}

class GenderList extends StatelessWidget {
  final List<Gender> genders = [
    Gender("Ação", "Filmes com muita adrenalina e lutas intensas."),
    Gender("Terror", "Filmes que provocam medo e suspense."),
    Gender("Comédia", "Filmes que buscam fazer rir e entreter."),
    Gender("Drama", "Filmes emocionantes e envolventes."),
    Gender("Aventura",
        "Filmes repletos de emoção, descobertas e jornadas épicas."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: genders.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(genders[index].name),
            subtitle: Text(genders[index].description),
          );
        },
      ),
    );
  }
}
