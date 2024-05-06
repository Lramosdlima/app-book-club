// ignore_for_file: avoid_print

import 'package:bookclub/model/collection.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/store/user.dart';
import 'package:bookclub/util/network/http.dart';

class CollectionRepository {
  Future<ApiResponse> getCollections() async {
    ApiResponse response = ApiResponse();

    List collections = [];

    try {
      final request = HttpHelper.get('/collection/all');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var collection in objects) {
            collections.add(Collection.fromMap(collection));
          }

          response.data = collections;
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

  Future<ApiResponse> getMyCollections() async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var userId = userStore.user.id;

    List collections = [];

    try {
      final request = HttpHelper.get('/collection/owner/$userId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var collection in objects) {
            collections.add(Collection.fromMap(collection));
          }

          response.data = collections;
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

  Future<ApiResponse> getAddedCollections() async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var userId = userStore.user.id;

    List collections = [];

    try {
      final request = HttpHelper.get('/collection/user/$userId');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var collection in objects) {
            collections.add(Collection.fromMap(collection));
          }

          response.data = collections;
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

  Future<ApiResponse> createCollection(
      String title, String description, List<int>? books) async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var params = <String, dynamic>{};
    params["owner_id"] = userStore.user.id;
    params["title"] = title;
    params["description"] = description;
    params["books"] = books;

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

   Future<ApiResponse> removeCollection(
    int collectionId,
  ) async {
    ApiResponse response = ApiResponse();

    var params = <String, dynamic>{};
    params["collection_id"] = collectionId;

    try {
      final request = HttpHelper.delete('/collection/delete/$collectionId');

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

  Future<ApiResponse> addCollectionToUser(
    int collectionId,
  ) async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var params = <String, dynamic>{};
    params["user_id"] = userStore.user.id;
    params["collection_id"] = collectionId;

    try {
      final request = HttpHelper.post('/collection/user/add', body: params);

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

  Future<ApiResponse> removeCollectionFromUser(
    int collectionId,
  ) async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var params = <String, dynamic>{};
    params["user_id"] = userStore.user.id;
    params["collection_id"] = collectionId;

    try {
      final request = HttpHelper.delete('/collection/user/remove/$collectionId');

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
