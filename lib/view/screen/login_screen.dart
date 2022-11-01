import 'package:flutter/material.dart';
import 'package:lunch_vote/view/screen/home_screen.dart';
import 'package:lunch_vote/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginVisible = false;
  final LoginController _loginController = LoginController();

  @override
  void initState() {
    setLoginVisibility();
    super.initState();
  }

  void setLoginVisibility() async{
    var token = await getUserToken();
    if (token == null){
      setState(() {
        _isLoginVisible = true;
      });
    } else{
      print('User Token : $token');
      navigateToHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '안녕하세요 로그인 테스트',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Visibility(
                      visible: _isLoginVisible,
                      child: MaterialButton(
                        onPressed: () async {
                          String? accessToken = await _loginController.loginToken();
                          print('Access Token : $accessToken');
                          String? userToken = await _loginController.postUserToken(accessToken!);
                          print('User Token : $userToken');
                          setUserToken(userToken!);
                          navigateToHome();
                        },
                        child: Image.asset(
                          'assets/images/bg_kakao_login.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void setUserToken(String token) async{
    final spf = await SharedPreferences.getInstance();
    spf.setString('userToken', token);
  }

  Future<String?> getUserToken() async{
    final spf = await SharedPreferences.getInstance();
    try{
      return spf.getString('userToken');
    } catch (e){ }
    return null;
  }

  void navigateToHome(){
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => HomeScreen())
    );
  }
}