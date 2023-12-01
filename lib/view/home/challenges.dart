import 'package:flutter/material.dart';

class Challenge {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isCompleted;

  Challenge(this.title, this.subtitle, this.imageUrl,
      [this.isCompleted = false]);
}

class ChallengeList extends StatelessWidget {
  final List<Challenge> challenge = [
    Challenge(
        "Mundo Literário Além das Fronteiras",
        " Escolha um livro de um autor de um país diferente do seu e mergulhe na experiência literária de uma cultura totalmente nova. Explore não apenas a trama, mas também as nuances culturais e os estilos de escrita distintos.",
        "https://example.com/dom_casmurro.jpg"),
    Challenge(
        "A Jornada do Herói",
        "Escolha um livro cujo protagonista tenha uma profissão ou estilo de vida completamente diferente do seu. Tente compreender o mundo através dos olhos desse personagem e reflita sobre como essa perspectiva pode expandir seus horizontes.",
        "https://example.com/1984.jpg"),
    Challenge(
        "Leitura às Cegas",
        "Peça a um amigo ou familiar para escolher um livro para você sem revelar o título ou autor. Inicie a leitura sem saber nada sobre a história e permita-se ser surpreendido pela trama, descobrindo cada detalhe conforme avança nas páginas.",
        "https://example.com/senhor_aneis.jpg",
        true),
    Challenge(
        "Livro e Filme: Uma Dupla Perspectiva",
        "Escolha um livro que tenha uma adaptação cinematográfica e experimente consumir ambos. Compare e contraste as duas versões, analisando como a história é representada em diferentes mídias.",
        "https://example.com/harry_potter.jpg"),
    Challenge(
        "O Poder da Não-Ficção",
        "Afaste-se da ficção por um tempo e escolha um livro de não-ficção sobre um tema que desconheça. Desafie-se a aprender algo novo e a ver o mundo sob uma luz diferente através da pesquisa e dos fatos apresentados.",
        "https://example.com/cem_anos_solidao.jpg"),
    Challenge(
        "Aventura em Família",
        "Escolha um livro que você leu quando era criança e releia-o agora, décadas depois. Compare sua experiência de leitura e reflita sobre como a história e os personagens ressoam em você de maneira diferente.",
        "https://example.com/pequeno_principe.jpg",
        true),
    Challenge(
      "Caminhando com os Clássicos",
      "Escolha um livro clássico que você sempre quis ler e mergulhe na história. Explore o contexto histórico e cultural em que a obra foi escrita e reflita sobre como ela se relaciona com o mundo atual.",
      "https://example.com/dom_casmurro.jpg",
    ),
    Challenge(
      "Leitura em Outro Idioma",
      "Se você é fluente em mais de um idioma, escolha um livro em um idioma que não seja o seu nativo. Aprecie não apenas a história, mas também a arte da tradução e como diferentes línguas influenciam a expressão literária.",
      "https://example.com/pequeno_principe.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: challenge.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              const SizedBox(height: 15),
              ListTile(
                tileColor: challenge[index].isCompleted == true
                    ? const Color.fromARGB(45, 255, 193, 7)
                    : null,
                title: Text(challenge[index].title),
                subtitle: Text(challenge[index].subtitle),
                leading: Icon(
                  Icons.diamond,
                  color: challenge[index].isCompleted == true
                      ? Colors.amber
                      : Colors.grey,
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        },
      ),
    );
  }
}
