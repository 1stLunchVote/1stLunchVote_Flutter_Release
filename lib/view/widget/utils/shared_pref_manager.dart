import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager{
  void setUserToken(String token) async{
    final spf = await SharedPreferences.getInstance();
    spf.setString('userToken', token);
  }

  Future<String?> getUserToken() async{
    final spf = await SharedPreferences.getInstance();
    try{
      return spf.getString('userToken');
    } catch (e){  }
    return null;
  }

  void clearUserToken() async{
    final spf = await SharedPreferences.getInstance();
    spf.remove('userToken');
  }

  void setFCMToken(String? token) async{
    final spf = await SharedPreferences.getInstance();
    spf.setString('fcmToken', token!);
  }

  Future<String?> getFCMToken() async{
    final spf = await SharedPreferences.getInstance();
    try{
      return spf.getString('fcmToken');
    } catch (e){
      return null;
    }
  }
}