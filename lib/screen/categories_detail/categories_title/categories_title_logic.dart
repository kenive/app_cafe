part of 'categories_title.dart';

class CategoriesTitleLogic extends ChangeNotifier {
  late BuildContext context;
  final CafeService cafe = CafeService.client();

  CategoriesTitleLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      List id = ModalRoute.of(context)!.settings.arguments as List;

      getIdStudy(id[0]);
    });
  }
  int size = 18;
  bool checkMucLuc = true;

  List<CategoryDetailData> dataCategories = [];
  List<CommentAdmin> dataComment = [];

  int stt = 0;

  CategoryDetailData data1 = CategoryDetailData(
      id: 1,
      danh_muc_id: 1,
      tieu_de: '',
      slug: '',
      hinh_anh: '',
      noi_dung: '',
      nguoi_dang: 1);

  List<String> listH2conTent = [];

  List<String> tieuDe = [
    'Tiêu đề 1',
    'Tiêu đề 2',
    'Tiêu đề 3',
    'Tiêu đề 4',
    'Tiêu đề 5',
    'Tiêu đề 6',
    'Tiêu đề 7',
  ];
  void getIdStudy(int id) async {
    try {
      var data = await cafe.getIdStudy(id);
      stt = id;
      data1 = data.data!;

      var categories = await cafe.getIdCategories(data1.danh_muc_id);

      dataCategories = categories.data!;

      notifyListeners();
    } catch (e) {
      dataComment = [];
      notifyListeners();
      debugPrint('$e');
    }
  }

  void loadDataStudy(int id) async {
    try {
      Navigator.pop(context);
      var data = await cafe.getIdStudy(id);
      stt = id;
      data1 = data.data!;

      var comment = await cafe.getComment(id);
      if (comment.success) {
        dataComment = comment.data!;
      } else {
        dataComment = [];
        checkMucLuc = false;
      }

      notifyListeners();
    } catch (e) {
      dataComment = [];
      debugPrint('$e');
    }
  }
}
