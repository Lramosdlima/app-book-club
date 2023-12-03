import 'package:bookclub/model/response.dart';
import 'package:bookclub/store/user.dart';
import 'package:bookclub/util/network/http.dart';
import 'package:bookclub/util/storage/storage.dart';

class AuthRepository {
  Future<ApiResponse> login(String email, String password) async {
    ApiResponse response = ApiResponse();
    UserStore userStore = UserStore();

    var params = <String, dynamic>{};
    params["email"] = email;
    params["password"] = password;

    try {
      final request = HttpHelper.post('/auth/login', body: params);

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          response.data = result.data["data"];
          userStore.setUserData(response.data["user"]);
          StorageHelper.set('token', response.data["accessToken"]);
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
      // ignore: avoid_print
      print(error);
      return response;
    }
  }

  Future<ApiResponse> register(
      String name, String email, String password) async {
    ApiResponse response = ApiResponse();

    var params = <String, dynamic>{};
    params["name"] = name;
    params["email"] = email;
    params["password"] = password;

    try {
      final request = HttpHelper.post('/auth/register', body: params);

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
        // ignore: avoid_print
        print(e);
      });

      return response;
    } catch (error) {
      // ignore: avoid_print
      print(error);
      return response;
    }
  }
}
