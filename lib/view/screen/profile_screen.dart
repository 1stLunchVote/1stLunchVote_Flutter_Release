import 'package:flutter/material.dart';
import 'package:lunch_vote/controller/profile_controller.dart';
import 'package:lunch_vote/styles.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/utils/custom_clip_path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = ProfileController();
  bool _hasProfileImage = false;
  bool _nicknameChange = false;
  String _nickname = "이동건";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "마이페이지",
        isTitleCenter: true,
        context: context,
        trailingList: null,
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Stack(
                        children: [
                          const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                'assets/images/profile_default.png',
                              ),
                              radius: 100,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(156, 156, 4, 4),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                child: IconButton(
                                    onPressed: (){},
                                    icon: const Icon(Icons.mode_edit,
                                      color: Colors.white,
                                    ),
                                ),
                              ),
                            ),
                          )
                      ]
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(_nickname,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    ),
                    Visibility(
                      visible: !_nicknameChange,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              _nicknameChange = !_nicknameChange;
                            });
                          },
                          child: const Text('닉네임 수정',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: textHintColor,
                              decoration: TextDecoration.underline
                            ),
                          )),
                    ),
                    Visibility(
                        visible: _nicknameChange,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: '변경할 닉네임을 입력하세요.',
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      _nicknameChange = false;
                                    });
                                  },
                                  icon: Icon(Icons.close,
                                    color: Theme.of(context).colorScheme.primary,))
                            ),
                            validator: (value){
                              if (value == null || value.isEmpty){
                                return '닉네임을 입력해주세요.';
                              } else if (value.length < 2 || value.length > 8){
                                return '닉네임 길이를 2~8로 해주세요.';
                              }
                              return null;
                            },
                            onSaved: (value){
                              setState(() {
                                _nickname = value!;
                              });
                            },
                          ),
                        )
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _nicknameChange,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 90),
                    child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          _profileController.changeNickname(_nickname).then((value) {
                            String complete = value != null ? '성공' : '실패';
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('닉네임 변경에 $complete 하였습니다.'))
                            );
                          }
                          );
                          setState(() {
                            _nicknameChange = false;
                          });
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10)
                      ),
                      child: Text('설정 완료',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}