import 'package:altitude/core/base/base_usecase.dart';
import 'package:altitude/core/di/get_it_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';


@usecase
@Injectable()
class AuthGoogleUsecase extends BaseUsecase<NoParams, String?> {
  @override
  Future<String?> getRawFuture(NoParams params) async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? result = await googleSignIn.signIn();
    if (result != null) {
      GoogleSignInAuthentication googleAuth = await result.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential fireResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return fireResult.user!.uid;
    } else {
      return null;
    }
  }
}
