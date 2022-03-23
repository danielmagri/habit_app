import 'package:altitude/common/domain/usecases/user/get_user_data_usecase.dart';
import 'package:altitude/common/model/Person.dart';
import 'package:altitude/core/base/base_usecase.dart';
import 'package:altitude/core/di/get_it_config.dart';
import 'package:altitude/core/services/interfaces/i_fire_auth.dart';
import 'package:altitude/core/services/interfaces/i_fire_database.dart';
import 'package:injectable/injectable.dart';

@usecase
@Injectable()
class SearchEmailUsecase extends BaseUsecase<String, List<Person>> {
  final IFireDatabase _fireDatabase;
  final IFireAuth _fireAuth;
  final GetUserDataUsecase _getUserDataUsecase;

  SearchEmailUsecase(
      this._fireDatabase, this._getUserDataUsecase, this._fireAuth);

  @override
  Future<List<Person>> getRawFuture(String params) async {
    if (params != _fireAuth.getEmail()) {
      List<String?> myPendingFriends =
          (await _getUserDataUsecase(false)).absoluteResult().pendingFriends ??
              [];
      return await _fireDatabase.searchEmail(params, myPendingFriends);
    } else {
      return [];
    }
  }
}
