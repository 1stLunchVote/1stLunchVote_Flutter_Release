import 'package:flutter/material.dart';
import 'package:lunch_vote/view/widget/appbar_widget.dart';
import 'package:lunch_vote/view/widget/custom_clip_path.dart';

import '../../../controller/group_controller.dart';
import '../../widget/group_user.dart';

class GroupInviteScreen extends StatefulWidget {
  const GroupInviteScreen({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<GroupInviteScreen> createState() => _GroupInviteScreenState();
}

class _GroupInviteScreenState extends State<GroupInviteScreen> {
  final _formKey = GlobalKey<FormState>();

  final GroupController _groupController = GroupController();

  final TextEditingController _emailController = TextEditingController();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BasicAppbar(
        backVisible: true,
        appbarTitle: "방 생성하기",
        isTitleCenter: true,
        context: context,
        trailingList: [
          IconButton(
            onPressed: () {
              // TODO: 방 상세 설정화면으로 이동
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const GroupSettingScreen()));
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: '변경할 닉네임을 입력하세요.',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_emailController.text.isNotEmpty){
                                _emailController.text = '';
                              }
                            });
                          },
                          icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary,),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '닉네임을 입력해주세요.';
                        } return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _email = value!;
                        });
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 90),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _groupController
                                .searchUser(widget.groupId, _email)
                                .then((value) {
                              String complete = value != null ? '성공' : '실패';
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('닉네임 변경에 $complete 하였습니다.')));
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.fromLTRB(24, 10, 24, 10)),
                        child: Text(
                          '설정 완료',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}