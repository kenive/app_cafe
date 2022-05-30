part of 'categories_detail.dart';

class CategoriesDetailLogic extends ChangeNotifier {
  late BuildContext context;
  final CafeService cafe = CafeService.client();

  CategoriesDetailLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      List id = ModalRoute.of(context)!.settings.arguments as List;
      getIdCategories(id[0]);
    });
  }

  List<CategoryDetailData> data = [];

  void getIdCategories(int id) async {
    try {
      var a = await cafe.getIdCategories(id);
      data = a.data;

      notifyListeners();
    } catch (e) {
      data = [];
      notifyListeners();
      debugPrint('$e');
    }
  }
}
