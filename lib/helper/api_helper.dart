
import 'package:flutter/material.dart';



class APIHelper extends ChangeNotifier {

  static const BASE_URL = "https://numeroscop.in/yantra/api/auth/";


/*

  Future loginUserUsingUsername({
    @required username,
    @required password,
    fbLogin = false,
    fbPicture = '',
  }) async {
    final url = Uri.https(BASE_URL, UNENCODED_PATH, {
      'action': LOGIN_URL,
      'username': username,
      'password': password,
      'fb_login': fbLogin ? '1' : '0',
    });
    final response = await http.get(url);
    print("login fb : ${response.body}");
    if (response.statusCode == 200) {
      final decodedResponse = await json.decode(response.body);
      if (decodedResponse['status'] == 'success') {
        CurrentUser.id = decodedResponse['user_id'];
        CurrentUser.name = decodedResponse['name'];
        CurrentUser.email = decodedResponse['email'];
        CurrentUser.username = decodedResponse['username'];
        if (!fbLogin) {
          CurrentUser.picture = decodedResponse['picture'];
        } else {
          CurrentUser.picture = fbPicture;
        }
        CurrentUser.isLoggedIn = true;

        await DBHelper.delete('user_info');
        await DBHelper.insert('user_info', {
          'id': CurrentUser.id,
          'isLoggedIn': '1',
          'username': CurrentUser.username,
          'name': CurrentUser.name,
          'email': CurrentUser.email,
          'picture': CurrentUser.picture,
        });
      }
    } else {
      throw Exception('Error');
    }
  }

  Future loginUserUsingEmail(
      {@required email, password = '', fbLogin = false}) async {
    final url = Uri.https(BASE_URL, UNENCODED_PATH, {
      'action': LOGIN_URL,
      'username': email,
      'password': password,
      'fb_login': fbLogin ? '1' : '0',
    });


    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedResponse = await json.decode(response.body);
      if (decodedResponse['status'] == 'success') {
        CurrentUser.id = decodedResponse['user_id'];
        CurrentUser.name = decodedResponse['name'];
        CurrentUser.email = decodedResponse['email'];
        CurrentUser.username = decodedResponse['username'];
        CurrentUser.picture = decodedResponse['picture'];
        CurrentUser.isLoggedIn = true;

        await DBHelper.delete('user_info');
        await DBHelper.insert('user_info', {
          'id': CurrentUser.id,
          'isLoggedIn': '1',
          'username': CurrentUser.username,
          'name': CurrentUser.name,
          'email': CurrentUser.email,
          'picture': CurrentUser.picture,
        });
      }
    } else {
      throw Exception('Error');
    }
  }
*/



}
