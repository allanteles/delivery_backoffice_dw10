// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on LoginControllerBase, Store {
  late final _$_loginStatusAtom =
      Atom(name: 'LoginControllerBase._loginStatus', context: context);

  LoginStateStatus get loginStatus {
    _$_loginStatusAtom.reportRead();
    return super._loginStatus;
  }

  @override
  LoginStateStatus get _loginStatus => loginStatus;

  @override
  set _loginStatus(LoginStateStatus value) {
    _$_loginStatusAtom.reportWrite(value, super._loginStatus, () {
      super._loginStatus = value;
    });
  }

  late final _$_erroMessageAtom =
      Atom(name: 'LoginControllerBase._erroMessage', context: context);

  String? get erroMessage {
    _$_erroMessageAtom.reportRead();
    return super._erroMessage;
  }

  @override
  String? get _erroMessage => erroMessage;

  @override
  set _erroMessage(String? value) {
    _$_erroMessageAtom.reportWrite(value, super._erroMessage, () {
      super._erroMessage = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
