import 'package:lunch_vote/model/menu/menu_info.dart';
import 'package:lunch_vote/model/template/all_template_info.dart';
import 'package:lunch_vote/model/template/template_info.dart';
import 'package:lunch_vote/provider/lunch_vote_service.dart';

class TemplateRepository {
  final LunchVoteService lunchVoteService;

  TemplateRepository({required this.lunchVoteService});

  // 메뉴 정보 가져오기
  Future<MenuInfoResponse> getMenuInfo() =>
      lunchVoteService.getMenuInfo();

  // 전체 템플릿 조회
  Future<AllTemplateResponse> getAllTemplateInfo() =>
      lunchVoteService.getAllTemplateInfo();

  // 템플릿 하나 조회
  Future<OneTemplateResponse> getOneTemplateInfo(String lunchTemplateId) =>
      lunchVoteService.getOneTemplateInfo(lunchTemplateId);

  // 템플릿 생성
  Future<TemplateInfoResponse> createTemplate(TemplateInfo templateInfo) =>
      lunchVoteService.createTemplate(templateInfo);

  // 템플릿 수정
  Future<TemplateInfoResponse> modifyTemplate(String lunchTemplateId, TemplateInfo templateInfo) =>
      lunchVoteService.modifyTemplate(lunchTemplateId, templateInfo);

  // 템플릿 삭제
  Future<TemplateDeleteResponse> deleteTemplate(String lunchTemplateId) =>
      lunchVoteService.deleteTemplate(lunchTemplateId);
}