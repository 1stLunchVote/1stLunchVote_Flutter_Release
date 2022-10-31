// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lunch_vote_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _LunchVoteService implements LunchVoteService {
  _LunchVoteService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://54.173.224.149:8080/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<UserInfo> postUserToken(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'accessToken': token};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<UserInfo>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/login/KAKAO',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserInfo.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
