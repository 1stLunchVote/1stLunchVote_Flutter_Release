import 'dart:async';
import 'package:get/get.dart';
import 'package:lunch_vote/controller/nickname_controller.dart';
import 'package:lunch_vote/model/vote/first_vote_result.dart';
import 'package:lunch_vote/model/vote/second_vote.dart';
import 'package:lunch_vote/repository/second_vote_repository.dart';

import '../model/vote/second_vote_state.dart';
import '../routes/app_pages.dart';

class SecondVoteController extends GetxController{
  final SecondVoteRepository repository;
  final NicknameController nicknameController;

  // 투표 남은 시간 타이머
  late Timer _voteRemainTimer;
  // 투표 상태 타이머
  Timer? _voteStateTimer;
  late String groupId;

  final RxString _selectedId = "".obs;
  final RxInt _timeCount = 60.obs;
  String get selectedId => _selectedId.value;
  int get timeCount => _timeCount.value;

  final RxBool _voteCompleted = false.obs;
  bool get voteCompleted => _voteCompleted.value;

  final _voteItems = RxList<MenuInfo>();
  List get voteItems => _voteItems;

  SecondVoteController({required this.repository, required this.nicknameController}){
    _voteRemainTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (_timeCount.value > 0){
        _timeCount.value -= 1;
      } else{
        _voteRemainTimer.cancel();
      }
    });
  }

  @override
  void dispose(){
    super.dispose();
    _voteRemainTimer.cancel();
    _voteStateTimer?.cancel();
  }

  void setVotedId(String menuId){
    _selectedId.value = menuId;
  }

  void clearVotedId(){
    _selectedId.value = "";
  }

  bool checkVoted(String menuId){
    return _selectedId.value == menuId;
  }

  getFirstVoteInfo(String groupId) {
    this.groupId = groupId;
    repository.getFirstVoteResult(groupId).then((value) {
      _voteItems.value = value.data.menuInfos;
    }, onError: (e){
      _voteItems.value = List.empty();
    });
  }

  voteItem() async{
    _voteCompleted.value = true;
    repository.secondVoteItem(groupId, selectedId).then((value){
      _getSecondVoteState();
    }, onError: (e){

    });
  }

  _getSecondVoteState(){
    repository.fetchSecondVoteState(groupId).then((value) {
      if (value.success){
        Get.offNamed(Routes.result, arguments: groupId);
      } else if (_voteStateTimer != null){
        _setStateTimer();
      }
    }, onError: (e){

    });
  }
  _setStateTimer(){
    _voteStateTimer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      _getSecondVoteState();
    });
  }
}