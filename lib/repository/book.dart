import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/util/network/http.dart';

class BookRepository {
  Future<ApiResponse> getBooks() async {
    ApiResponse response = ApiResponse();
    List books = [];

    final request = HttpHelper.get('/book/all/complete');

    await request.then((result) {
      var objects = result.data;

      for (var book in objects) {
        var bookObject = Book.fromJson(book);
        books.add(bookObject);
      }

      response.status = result.data["status"];
      response.data = books;
      response.error = result.data["error"];
    }).catchError((e) {
      response.status = false;
      response.error = HttpHelper.getError(e);
      // ignore: avoid_print
      print(e);
    });

    return response;
  }
}
