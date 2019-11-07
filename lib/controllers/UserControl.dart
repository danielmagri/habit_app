import 'package:habit/objects/Person.dart';
import 'package:habit/services/FireAuth.dart';
import 'package:habit/services/FireFunctions.dart';
import 'package:habit/services/SharedPref.dart';

class UserControl {
  Future<bool> isLogged() async {
    return await FireAuth().isLogged();
  }

  Future<String> getName() async {
    String name = await FireAuth().getName();
    return name != "" ? name : SharedPref().getName();
  }

  Future<bool> setName(String name) async {
    if (await FireAuth().isLogged()) {
      await SharedPref().setName(name);
      await FireAuth().setName(name);
      return await FireFunctions().updateUser(name: name);
    } else {
      return await SharedPref().setName(name);
    }
  }

  Future<String> getEmail() async {
    return await FireAuth().getEmail();
  }

  Future<String> getPhotoUrl() async {
    return await FireAuth().getPhotoUrl();
  }

  Future<List<Person>> getFriends() async {
    return await FireFunctions().getFriends();
  }

  Future<List<Person>> getPendingFriends() async {
    return await FireFunctions().getPendingFriends();
  }

  Future<bool> getPendingFriendsStatus() async {
    return await SharedPref().getPendingFriends();
  }

  Future<void> setPendingFriendsStatus(bool value) async {
    return await SharedPref().setPendingFriends(value);
  }

  Future<List<Person>> searchEmail(String email) async {
    if (email != await getEmail())
      return await FireFunctions().searchEmail(email);
    else
      return List();
  }

  Future<void> friendRequest(String uid) async {
    return await FireFunctions().friendRequest(uid);
  }

  Future<void> acceptRequest(String uid) async {
    return await FireFunctions().acceptRequest(uid);
  }

  Future<void> declineRequest(String uid) async {
    return await FireFunctions().declineRequest(uid);
  }

  Future<void> cancelFriendRequest(String uid) async {
    return await FireFunctions().cancelFriendRequest(uid);
  }

  Future<void> removeFriend(String uid) async {
    return await FireFunctions().removeFriend(uid);
  }

  Future<void> logout() async {
    await FireAuth().logout();
  }
}
