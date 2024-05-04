import 'package:mobx/mobx.dart';
import 'package:bookclub/model/user.dart';
part 'user.g.dart';

class UserStore extends _UserStore with _$UserStore {
  static final UserStore _instance = UserStore._internal();

  factory UserStore() {
    return _instance;
  }

  UserStore._internal();
}

abstract class _UserStore with Store {
  @observable
  User user = User();

  @action
  setUserData(data) {
    user = User.fromMap(data);
  }

  @action
  clearUserData() {
    user = User();
  }
}
