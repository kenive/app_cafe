// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cafe_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _CafeService implements CafeService {
  _CafeService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<User> login(email, password) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('password', password));
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'dang-nhap',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = User.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoriesReponse> getCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoriesReponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'danh-muc',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoriesReponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CategoryDetailResponse> getIdCategories(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CategoryDetailResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'danh-muc/${id}/bai-hoc',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CategoryDetailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StudyDetailData> getIdStudy(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StudyDetailData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'bai-hoc/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StudyDetailData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommentResponse> getComment(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommentResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'bai-hoc/${id}/binh-luan',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Setting> getCauHinh() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Setting>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'cau-hinh/tieu_de_app',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Setting.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CommentData> addComment(
      bai_viet_id, noi_dung, email, dien_thoai, ho_ten) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('bai_viet_id', bai_viet_id.toString()));
    _data.fields.add(MapEntry('noi_dung', noi_dung));
    _data.fields.add(MapEntry('email', email));
    _data.fields.add(MapEntry('dien_thoai', dien_thoai));
    _data.fields.add(MapEntry('ho_ten', ho_ten));
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CommentData>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/binh-luan',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CommentData.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TitleDetail> getStudyTitle(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TitleDetail>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'bai-hoc-v2/${id}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TitleDetail.fromJson(_result.data!);
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
