import 'package:altitude/core/enums/StateType.dart';
import 'package:flutter/material.dart' show Widget;
import 'package:mobx/mobx.dart';
part 'DataState.g.dart';

typedef Widget Initial();
typedef Widget Success<T>(T data);
typedef Widget SuccessLoadable<T>(T data, bool loading);
typedef Widget Error(dynamic error);

class DataState<T> = _DataStateBase<T> with _$DataState;

abstract class _DataStateBase<T> with Store {
  @observable
  StateType state = StateType.INITIAL;

  @observable
  bool _loading = false;

  T _data;
  T get data => _data;

  dynamic _error;
  dynamic get error => _error;

  @action
  void setLoading({bool loading = true}) {
    _loading = loading;
  }

  @action
  void setData(T data) {
    state = StateType.SUCESS;
    _loading = false;
    _data = data;
  }

  @action
  void setError(dynamic error) {
    state = StateType.ERROR;
    _loading = false;
    _error = error;
  }

  Widget handleState(Initial initial, Success<T> success, Error error) {
    switch (state) {
      case StateType.INITIAL:
        return initial();
      case StateType.ERROR:
        return error(_error);
      default:
        return success(_data);
    }
  }

  Widget handleStateLoadable(Initial initial, SuccessLoadable<T> successLoadable, Error error) {
    switch (state) {
      case StateType.INITIAL:
        return initial();
      case StateType.ERROR:
        return error(_error);
      default:
        return successLoadable(_data, _loading);
    }
  }
}
