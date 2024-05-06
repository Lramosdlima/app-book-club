// ignore_for_file: avoid_print

import 'package:bookclub/model/response.dart';
import 'package:bookclub/model/user_book_rate.dart';
import 'package:bookclub/store/user.dart';
import 'package:bookclub/util/network/http.dart';

class RateRepository {
  Future<ApiResponse> getRateByBookId(
    int bookId,
  ) async {
    ApiResponse response = ApiResponse();

    List rates = [];

    try {
      final request = HttpHelper.get('/rate/by/book/$bookId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var userBookRate in objects) {
            rates.add(UserBookRate.fromMap(userBookRate));
          }

          response.data = rates;
        } else {
          response.error = result.data["error"];
        }
      }).catchError((e) {
        response.status = false;
        response.error = HttpHelper.getError(e);
        print(e);
      });

      return response;
    } catch (error) {
      print(error);
      return response;
    }
  }

  Future<ApiResponse> getRateByUserId() async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var userId = userStore.user.id;

    List rates = [];

    try {
      final request = HttpHelper.get('/rate/by/user/$userId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var userBookRate in objects) {
            rates.add(UserBookRate.fromMap(userBookRate));
          }

          response.data = rates;
        } else {
          response.error = result.data["error"];
        }
      }).catchError((e) {
        response.status = false;
        response.error = HttpHelper.getError(e);
        print(e);
      });

      return response;
    } catch (error) {
      print(error);
      return response;
    }
  }

    Future<ApiResponse> createRate(
      int bookId, int rate, String? comment) async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var params = <String, dynamic>{};
    params["user_id"] = userStore.user.id;
    params["book_id"] = bookId;
    params["rate"] = rate;
    params["comment"] = comment;

    try {
      final request = HttpHelper.post('/collection/create', body: params);

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          response.data = result.data["data"];
        } else {
          response.error = result.data["error"];
        }
      }).catchError((e) {
        response.status = false;
        response.error = HttpHelper.getError(e);
        print(e);
      });

      return response;
    } catch (error) {
      print(error);
      return response;
    }
  }

   Future<ApiResponse> removeRate(
    int rateId,
  ) async {
    ApiResponse response = ApiResponse();

    try {
      final request = HttpHelper.delete('/collection/delete/$rateId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          response.data = result.data["data"];
        } else {
          response.error = result.data["error"];
        }
      }).catchError((e) {
        response.status = false;
        response.error = HttpHelper.getError(e);
        print(e);
      });

      return response;
    } catch (error) {
      print(error);
      return response;
    }
  }

}
