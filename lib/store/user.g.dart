// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$userAtom = Atom(name: '_UserStore.user', context: context);

  @override
  User get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  dynamic setUserData(dynamic data) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setUserData');
    try {
      return super.setUserData(data);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }

  @override
  dynamic clearUserData() {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.clearUserData');
    try {
      return super.clearUserData();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }
}
