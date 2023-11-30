import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/util/network/http.dart';

class BookRepository {
  Future<ApiResponse> getBooks() async {
    ApiResponse response = ApiResponse();
    List books = [];
    try {
      final request = HttpHelper.get('/book/all/complete');

      await request.then((result) {
        var objects = result.data["data"];

        for (var book in objects) {
          var bookObject = Book.fromMap(book);
          books.add(bookObject);
        }

        response.status = result.data["status"];
        if (response.status == true) {
          response.data = books;
        } else {
          response.error = result.data["error"];
        }
      }).catchError((e) {
        response.status = false;
        response.error = HttpHelper.getError(e);
        // ignore: avoid_print
        print(e);
      });

      return response;
    } catch (error) {
      print(error);
      return response;
    }
  }
}
