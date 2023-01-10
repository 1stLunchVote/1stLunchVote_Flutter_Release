import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class TemplateController extends GetxController {
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  TemplateController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<void> initController() async {
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio, baseUrl: dotenv.get('BASE_URL'));
  }

  Future<List<MenuInfo>?> getMenuInfo() async{
    var res = await _lunchVoteService.getMenuInfo();
    if (res.success){
      return res.data;
    }
    return null;
  }

  Future<String?> createTemplate(TemplateInfo templateInfo) async{
    var res = await _lunchVoteService.createTemplate(templateInfo);
    if (res.success){
      return res.message;
    }
    return null;
  }

  Future<String?> modifyTemplate(String lunchTemplateId, TemplateInfo templateInfo) async{
    var res = await _lunchVoteService.modifyTemplate(lunchTemplateId, templateInfo);
    if (res.success){
      return res.message;
    }
    return null;
  }

  Future<String?> deleteTemplate(String lunchTemplateId) async{
    var res = await _lunchVoteService.deleteTemplate(lunchTemplateId);
    if (res.success){
      return res.message;
    }
    return null;
  }

  Future<List<AllTemplateInfo>?> getAllTemplateInfo ()async{
    var res = await _lunchVoteService.getAllTemplateInfo();
    if (res.success){
      return res.data.lunchTemplates;
    }
    return null;
  }

  Future<List<Menu>?> getOneTemplateInfo(String lunchTemplateId) async {
    var res = await _lunchVoteService.getOneTemplateInfo(lunchTemplateId);
    if (res.success){
      return res.data.menu;
    }
    return null;
  }

  final _templateId = "".obs;
  final _templateName = "".obs;
  final _menus = [].obs;

  void setTemplateId(String id) {
    _templateId.value = id;
  }

  void setTemplateName(String name) {
    _templateName.value = name;
  }

  void addList(MenuInfo menuInfo) {
    _menus.add(MenuStatus(menuInfo: menuInfo, status: 0,));
  }

  void addListWithStatus(Menu menu) {
    int status = -1;
    if (menu.likesAndDislikes == "NORMAL") {
      status = 0;
    } else if (menu.likesAndDislikes == "LIKES") {
      status = 1;
    } else {
      status = 2;
    }
    _menus.add(MenuStatus(menuInfo: MenuInfo(
      menuId: menu.menuId,
      menuName: menu.menuName,
      image: menu.image,
    ), status: status,));
  }

  void clearList() {
    _menus.clear();
  }

  void updateStatus(int menuIdx) {
    _menus[menuIdx].status = (_menus[menuIdx].status + 1) % 3;
  }

  String get templateId => _templateId.value;
  String get templateName => _templateName.value;
  int get length => _menus.length;
  bool get visibility {
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status != 0) {
        return true;
      }
    }
    return false;
  }

  String getName(int menuIdx) => _menus[menuIdx].menuInfo.menuName;
  String getImg(int menuIdx) => _menus[menuIdx].menuInfo.image;
  double getWidth(int menuIdx) => (_menus[menuIdx].status == 0) ? 1.0 : 2.0;
  Color getColor(int menuIdx) {
    if (_menus[menuIdx].status == 0) {
      return Colors.black;
    } else if (_menus[menuIdx].status == 1) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  List<String> getLikeMenu() {
    List<String> res = [];
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status == 1) {
        res.add(_menus[i].menuInfo.menuId);
      }
    }
    return res;
  }

  List<String> getDislikeMenu() {
    List<String> res = [];
    for (int i = 0; i < _menus.length; i++) {
      if (_menus[i].status == 2) {
        res.add(_menus[i].menuInfo.menuId);
      }
    }
    return res;
  }
}

class MenuStatus {
  final MenuInfo menuInfo;
  int status;

  MenuStatus({required this.menuInfo, required this.status});
}