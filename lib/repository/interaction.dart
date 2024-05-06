// ignore_for_file: avoid_print

import 'package:bookclub/model/interaction.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/store/user.dart';
import 'package:bookclub/util/network/http.dart';

class InteractionRepository {
  Future<ApiResponse> getAllInteractionsByBookId(
    int bookId,
  ) async {
    ApiResponse response = ApiResponse();

    List interactions = [];

    try {
      final request = HttpHelper.get('/interaction/book/$bookId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var interaction in objects) {
            interactions.add(Interaction.fromMap(interaction));
          }

          response.data = interactions;
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

  Future<ApiResponse> getAllInteractionsByUserId() async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var userId = userStore.user.id;

    List interactions = [];

    try {
      final request = HttpHelper.get('/interaction/user/$userId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var interaction in objects) {
            interactions.add(Interaction.fromMap(interaction));
          }

          response.data = interactions;
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

  Future<ApiResponse> addInteraction(
      int bookId, bool? alreadyRead, bool? wantToRead, bool? liked) async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var params = <String, dynamic>{};
    params["already_read"] = alreadyRead;
    params["want_to_read"] = wantToRead;
    params["liked"] = liked;
    params["book_id"] = bookId;
    params["user_id"] = userStore.user.id;

    try {
      final request = HttpHelper.post('/interaction/add', body: params);

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

  Future<ApiResponse> updateIteraction(
      int interactionId, bool alreadyRead, bool wantToRead, bool liked) async {
    ApiResponse response = ApiResponse();

    var params = <String, dynamic>{};
    params["already_read"] = alreadyRead;
    params["want_to_read"] = wantToRead;
    params["liked"] = liked;

    try {
      final request = HttpHelper.put('/interaction/update/$interactionId', body: params);

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
