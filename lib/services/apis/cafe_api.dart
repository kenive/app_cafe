import 'package:app_cafe/models/categories/categories_data.dart';
import 'package:app_cafe/models/categories_detail/detail_response.dart';
import 'package:app_cafe/models/cauhinh/cau_hinh.dart';
import 'package:app_cafe/models/comment/comment_response.dart';
import 'package:app_cafe/models/commentData/comment_data.dart';
import 'package:app_cafe/models/study_detail/study_detail.dart';
import 'package:app_cafe/models/title_detail/title_detail.dart';
import 'package:app_cafe/models/user/user.dart';
import 'package:app_cafe/services/client_api.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'cafe_api.g.dart';

@RestApi()
abstract class CafeService {
  factory CafeService(Dio dio, {String baseUrl}) = _CafeService;

  factory CafeService.client() {
    return CafeService(
      ClientApi().init(),
    );
  }

  @POST('dang-nhap')
  Future<User> login(
    @Part(name: "email") String email,
    @Part(name: "password") String password,
  );

  @GET('danh-muc')
  Future<CategoriesReponse> getCategories();

  @GET('danh-muc/{id-danh-muc}/bai-hoc')
  Future<CategoryDetailResponse> getIdCategories(
    @Path('id-danh-muc') int id,
  );

  @GET('bai-hoc/{id-bai-hoc}')
  Future<StudyDetailData> getIdStudy(
    @Path('id-bai-hoc') int id,
  );
  @GET('bai-hoc/{id-bai-hoc}/binh-luan')
  Future<CommentResponse> getComment(
    @Path('id-bai-hoc') int id,
  );

  @GET('cau-hinh/tieu_de_app')
  Future<Setting> getCauHinh();

  @POST('/binh-luan')
  Future<CommentData> addComment(
    @Part(name: 'bai_viet_id') int bai_viet_id,
    @Part(name: 'noi_dung') String noi_dung,
    @Part(name: 'email') String email,
    @Part(name: 'dien_thoai') String dien_thoai,
    @Part(name: 'ho_ten') String ho_ten,
  );

  @GET('bai-hoc-v2/{id-bai-hoc}')
  Future<TitleDetail> getStudyTitle(
    @Path('id-bai-hoc') int id,
  );
}
