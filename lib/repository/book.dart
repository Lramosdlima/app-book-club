import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/util/network/http.dart';

class BookRepository {
  Future<ApiResponse> getBooks() async {
    ApiResponse response = ApiResponse();
    List books = [];

    final request = HttpHelper.get('/book/all');

    await request.then((result) {
      var objects = result.data["books"];

      for (var book in objects) {
        var bookObject = Book.fromJson(book);
        books.add(bookObject);
      }

      response.status = true;
      response.data = books;
      response.message = result.data["error"];
    }).catchError((e) {
      response = ApiResponse.fromJson(e.response.data);
      // ignore: avoid_print
      print(e);
    });

    return response;
  }
}
