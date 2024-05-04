import 'package:flutter/material.dart';

class NavigationItem {
  IconData iconData;

  NavigationItem(this.iconData);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home),
    NavigationItem(Icons.search),
    NavigationItem(Icons.person),
  ];
}



class Author {
  String fullname;
  int books;
  String image;

  Author(this.fullname, this.books, this.image);
}

List<Author> getAuthorList() {
  return <Author>[
    Author(
      "Stepanie Land",
      134,
      "assets/authors/stepanie_land.jpg",
    ),
    Author(
      "Sophie Mackintosh",
      123,
      "assets/authors/sophie_mackintosh.jpg",
    ),
    Author(
      "Tara Conklin",
      112,
      "assets/authors/tara_conklin.jpg",
    ),
    Author(
      "Pam Jenoff",
      108,
      "assets/authors/pam_jenoff.jpg",
    ),
    Author(
      "Karen Thompson",
      99,
      "assets/authors/karen_thompson_walker.jpg",
    ),
    Author(
      "Greer Hendricks",
      90,
      "assets/authors/greer_hendricks.jpg",
    ),
    Author(
      "Fiona Barton",
      87,
      "assets/authors/fiona_barton.jpg",
    ),
    Author(
      "Whitney Scharer",
      77,
      "assets/authors/whitney_scharer.jpg",
    ),
    Author(
      "Andrea Bartz",
      75,
      "assets/authors/andrea_bartz.jpg",
    ),
    Author(
      "Kristen Roupenian",
      70,
      "assets/authors/kristen_roupenian.jpg",
    ),
    Author(
      "Yangsze Choo",
      65,
      "assets/authors/yangsze_choo.jpg",
    ),
  ];
}

class Comment {
  String name;
  String commentText;
  String date;
  String userImage;

  Comment(this.name, this.commentText, this.date, this.userImage);
}

List<Comment> getCommentList() {
  return <Comment>[
    Comment(
      "Maria",
      "Este livro tem uma narrativa envolvente e personagens bem desenvolvidos. No entanto, achei o final um pouco previsível.",
      "17 de abril de 2024",
      "assets/img/authors/stepanie_land.jpg",
    ),
    Comment(
      "João",
      "Achei a trama confusa e mal desenvolvida. Não recomendaria este livro.",
      "18 de abril de 2024",
      "assets/img/authors/sophie_mackintosh.jpg",
    ),
    Comment(
      "Ana",
      "Excelente livro! Aprofunda questões filosóficas de forma cativante. Recomendo a leitura para quem gosta de reflexões profundas.",
      "19 de abril de 2024",
      "assets/img/authors/tara_conklin.jpg",
    ),
    Comment(
      "Pedro",
      "O autor construiu um universo fascinante, mas o ritmo da narrativa é lento. Leitura recomendada para fãs de ficção científica.",
      "20 de abril de 2024",
      "assets/img/authors/pam_jenoff.jpg",
    ),
    Comment(
      "Carla",
      "Uma história emocionante que aborda temas complexos com sensibilidade. Terminei o livro com lágrimas nos olhos.",
      "21 de abril de 2024",
      "assets/img/authors/karen_thompson_walker.jpg",
    ),
    Comment(
      "Lucas",
      "Achei a protagonista pouco cativante e a trama bastante previsível. Não consegui me envolver com a história.",
      "22 de abril de 2024",
      "assets/img/authors/greer_hendricks.jpg",
    ),
    Comment(
      "Mariana",
      "Um livro instigante que nos faz questionar a natureza da realidade. Recomendo para quem gosta de histórias que desafiam o pensamento.",
      "23 de abril de 2024",
      "assets/img/authors/fiona_barton.jpg",
    ),
    Comment(
      "Paulo",
      "A narrativa é fluida e os personagens são bem desenvolvidos. No entanto, achei o desfecho um pouco abrupto.",
      "24 de abril de 2024",
      "assets/img/authors/whitney_scharer.jpg",
    ),
    Comment(
      "Juliana",
      "Este livro me surpreendeu do início ao fim! Uma trama cheia de reviravoltas e personagens complexos.",
      "25 de abril de 2024",
      "assets/img/authors/andrea_bartz.jpg",
    ),
    Comment(
      "Fernando",
      "O autor criou um mundo rico em detalhes e mitologia. Amei cada página deste livro!",
      "26 de abril de 2024",
      "assets/img/authors/kristen_roupenian.jpg",
    ),
    Comment(
      "Raquel",
      "Não consegui me conectar emocionalmente com os personagens e achei a trama pouco original. Não foi uma leitura marcante para mim.",
      "27 de abril de 2024",
      "assets/img/authors/yangsze_choo.jpg",
    ),
    Comment(
      "Gustavo",
      "Um livro que nos faz refletir sobre a complexidade das relações humanas. Recomendo para quem busca uma leitura instigante.",
      "28 de abril de 2024",
      "assets/img/authors/stepanie_land.jpg",
    ),
    Comment(
      "Luiza",
      "O autor utiliza uma linguagem poética para abordar questões existenciais. Uma leitura que toca a alma.",
      "29 de abril de 2024",
      "assets/img/authors/sophie_mackintosh.jpg",
    ),
    Comment(
      "Sandra",
      "Achei o enredo intrigante e imprevisível. Não consegui parar de ler até chegar ao final!",
      "30 de abril de 2024",
      "assets/img/authors/tara_conklin.jpg",
    ),
    Comment(
      "Ricardo",
      "Um livro que nos transporta para outra época e nos faz refletir sobre os valores humanos. Uma leitura enriquecedora.",
      "1 de maio de 2024",
      "assets/img/authors/pam_jenoff.jpg",
    ),
    Comment(
      "Camila",
      "A trama é repleta de suspense e reviravoltas. Recomendo para quem gosta de um bom thriller psicológico.",
      "2 de maio de 2024",
      "assets/img/authors/karen_thompson_walker.jpg",
    ),
  ];
}







class Filter {
  String name;

  Filter(this.name);
}

List<Filter> getFilterList() {
  return <Filter>[
    Filter("LIVROS"),
    Filter("REVIEWS"),
    Filter("LISTAS"),
  ];
}
