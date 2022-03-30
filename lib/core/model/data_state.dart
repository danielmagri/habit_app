import 'package:flutter/material.dart' show SizedBox, Widget;
import 'package:mobx/mobx.dart';
import 'result.dart';
import 'failure.dart';

part 'data_state.g.dart';

typedef _SuccessStateCallback<T> = Widget Function(T data);
typedef _LoadingStateCallback<T> = Widget Function(T? data);
typedef _SimpleLoadingStateCallback = Widget Function();
typedef _ErrorStateCallback = Widget Function(Failure error);

typedef _LoadingReactionCallback = void Function(bool loading);
typedef _SuccessReactionCallback<T> = void Function(T data);
typedef _ErrorReactionCallback = void Function(Failure error);

enum StateType { SUCCESS, LOADING, ERROR }

/// O DataState consiste na mudança de 3 estados (`LOADING`, `SUCCESS`, `ERROR`).
/// 
/// O estado inicial padrão começa pelo `LOADING`, pensando nas situações que precisamos carregar os dados para exibir ao usuário. E com ela podemos usar um widget de loading/shimmer/skeleton.
/// Mas caso seja necessário, é possível alterar o estado inicial para o `SUCCESS` ou até mesmo `ERROR`.
/// 
/// Existem 2 metódos para lidar com os estados na renderização dos widgets, [handleState] e [handleStateLoadableWithData].
/// - O [handleState] é indicado para situações simples, onde cada estado terá sua widget.
/// - E o [handleStateLoadableWithData] é indicado para situações onde em um dado momento precise utilizar a data no estado de loading. Por exemplo ao exibir uma lista infinita, onde precisamos exibir os dados da lista juntamente com alguma indicação de loading.
/// 
/// O [handleReactionState] é utilizado para lidar com os estados por meio da `Reaction` do MobX.
class DataState<T> = _DataStateBase<T> with _$DataState;

abstract class _DataStateBase<T> with Store {
  _DataStateBase({StateType initialState = StateType.LOADING}) : _state = initialState;

  @observable
  StateType _state;

  StateType get state => _state;

  T? _data;
  T? get data => _data;

  Failure? _error;
  Failure? get error => _error;

  @action
  void setLoadingState([bool loading = true]) {
    _state = StateType.LOADING;
  }

  @action
  void setSuccessState(T data) {
    _state = StateType.SUCCESS;
    _data = data;
  }

  @action
  void setErrorState(Failure error) {
    _state = StateType.ERROR;
    _error = error;
  }

  Widget handleState(
      {required _SimpleLoadingStateCallback loading,
      required _SuccessStateCallback<T> success,
      _ErrorStateCallback? error}) {
    switch (_state) {
      case StateType.LOADING:
        return loading();
      case StateType.ERROR:
        if (error == null) {
          return const SizedBox();
        } else {
          return error(_error!);
        }
      default:
        return success(_data!);
    }
  }

  Widget handleStateLoadableWithData(
      {required _LoadingStateCallback<T> loading,
      required _SuccessStateCallback<T> success,
      _ErrorStateCallback? error}) {
    switch (_state) {
      case StateType.LOADING:
        return loading(_data);
      case StateType.ERROR:
        if (error == null) {
          return const SizedBox();
        } else {
          return error(_error!);
        }
      default:
        return success(_data!);
    }
  }

  ReactionDisposer handleReactionState(
      {_LoadingReactionCallback? loading,
      _SuccessReactionCallback<T>? success,
      _ErrorReactionCallback? error}) {
    return reaction((_) => _state, (_) {
      switch (_state) {
        case StateType.LOADING:
          if (loading != null) loading(true);
          break;
        case StateType.ERROR:
          if (loading != null) loading(false);
          if (error != null) error(_error!);
          break;
        case StateType.SUCCESS:
          if (loading != null) loading(false);
          if (success != null) success(_data!);
          break;
      }
    });
  }
}

extension FutureExtension<T> on Future<Result<T>> {
  Future<R> resultComplete<R>(
      R Function(T data) success, R Function(Failure error) error) async {
    var res = await this;
    if (res.isSuccess) {
      return success((res as SuccessResult<T>).value);
    } else {
      return error((res as FailureResult).e);
    }
  }

  Future resultCompleteState<T>(DataState<T> dataState) async {
    var res = await this;
    if (res.isSuccess) {
      dataState.setSuccessState((res as SuccessResult<T>).value);
    } else {
      dataState.setErrorState((res as FailureResult).e);
    }
  }
}
