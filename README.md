<h1 align="center">
    <a href="#" alt="Api Book Club 📚"> 📚 App Book Club </a>
</h1>

<h3 align="center">
    Aplicativo responsável pela interface de usuário do projeto Book Club.
</h3>

<p align="center">
  Feito por Leonardo R., Felipe R. e Rafael C.
</p>

# Sobre o projeto 🤔

Esse aplicativo é um projeto de graduação no CEUB de Análise e Desenvolvimento de Sistemas para o Projeto Integrador. Ela foi desenvolvida com o intuito de praticar conhecimentos adquiridos no decorrer do curso. Esse aplicativo utiliza das funções fornecidas pela [API Book Club](https://github.com/Lramosdlima/api-book-club).

# Sobre o BookClub 📚

![image](https://github.com/user-attachments/assets/d64847ce-b03b-441f-beff-cd3f9c19ff48)

O projeto nasceu com a necessidade de unir pessoas que gostam de livros e seus universos, além de incentivar a leitura explorando, comentando e avaliando livros. Você pode favoritar livros e até mesmo criar uma coleção de livros. Coleção essa que você pode agrupar livros com alguma ideia como "Livros com melhores PLOTs!" ou "Livros perfeitos para fim de semana!".

# Funcionalidades do App 📲
![image](https://github.com/user-attachments/assets/e206a205-5506-43b7-8b69-7dcab6c8e014)

### Início do APP
- Onboarding (1ª vez no app mostrará um pouco sobre ele);
- Login e Cadastro de Usuário;
- É possível entrar sem Login (isso fará com que algumas funcionalidades estejam bloqueadas como Favoritos/Criar Coleções);

### Home
- Na Home existe uma TabBar com 2 itens, sendo eles: "Livros" e "Coleções" na parte superior e na parte inferior temos um NavigationBar com "Principal", "Minhas Coleções" e "Perfil";
- Na Tab de Livros tem uma listagem dos livros avaliados pelos usuários e os mais bem avaliados;
- Na Tab de Coleção você vê todas as coleções feita pelo usuário, e se você arrastar o card para lado (pressionando e arrastando para esquerda), aparecerá um botão que permitirá você adicionar para as "Coleções Adicionadas". Essas poderão ser vistas posteriomente na aba Perfil;

### Tela do Livro
- Ao clicar na imagem ou card de qualquer Livro nas listagens, será redirecionado àquele livro clicado. Verá o título, imagem da capa e as informações do mesmo. Embaixo terá uma lista de comentários de outros usuários;
- Tem um FloatingActionButton que tem 4 opções ao clicar nele. Sendo elas: Favoritar, Já Lido (terminou o livro e marcou como lido), Quero Ler (marcar como quer ler depois) e Comentário/Avaliação;
- Ao clicar no botão "Comentário/Avaliação" aparecerá um modal na tela para que você possa escrever um texto com 100 caracteres e avaliar de 0-5 estrelas o livro;
![image](https://github.com/user-attachments/assets/63a1b5b4-64d9-417d-8a4e-be0a0831cf4b)

### O que são Coleções?
- Coleção nada mais é do que um agrupamento de livros, por meio dela é possível destacar um texto que motive essa junção. O usuário pode adicionar quantos livros queira na coleção;

### Aba: Suas Coleções
- Voltando para Home você tem a aba "Suas Coleções" na NavigationBar. Ela só estará disponível para usuários logados. Quando estiver logado, aparecerão uma lista das Coleções já criadas por você. Casa não tenha nenhuma, você pode clicar no FloatingActionButton com "+" e fazer o fluxo de criar nova coleção;
![image](https://github.com/user-attachments/assets/d30bfed8-c34f-4fdb-966c-33d50bb3d882)

### Aba: Perfil
- Aqui você você pode ver suas informações de usuário e todas as interações feitas anteriormente no livro ou na coleção.
![image](https://github.com/user-attachments/assets/b67ab214-f1ab-4637-bc43-f46583de0dee)


## 🛠 Conhecimentos Aplicados

- Flutter + Dart
- dio: utilizado para fazer requisições para [API Book Club](https://github.com/Lramosdlima/api-book-club).
- ndialog: utilizado para poder expor uma modal para os erros de requisição da API.

## Anexos
![image](https://github.com/user-attachments/assets/df73543a-11c8-492d-9692-6640bb08fac4)
![image](https://github.com/user-attachments/assets/1d37422d-b02e-40c1-9d11-2a5efe6f53ef)
![image](https://github.com/user-attachments/assets/7ba14a12-34d2-4ed7-b678-947c0e838db6)

