import 'package:dio/dio.dart';
import 'package:lunch_vote/model/menu/menu_info.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/repository/lunch_vote_service.dart';
import 'package:lunch_vote/view/widget/utils/shared_pref_manager.dart';

class TemplateController{
  final dio = Dio();
  late LunchVoteService _lunchVoteService;
  final SharedPrefManager _spfManager = SharedPrefManager();

  TemplateController() {
    dio.options.headers["Content-Type"] = "application/json";
  }

  Future<List<MenuInfo>?> getMenuInfo() async{
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);

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
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);

    var res = await _lunchVoteService.getAllTemplateInfo();
    if (res.success){
      return res.data.lunchTemplates;
    }
    return null;
  }

  Future<List<Menu>?> getOneTemplateInfo(String lunchTemplateId) async {
    dio.options.headers["Authorization"] = await _spfManager.getUserToken();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _lunchVoteService = LunchVoteService(dio);

    var res = await _lunchVoteService.getOneTemplateInfo(lunchTemplateId);
    if (res.success){
      return res.data.menu;
    }
    return null;
  }
}