part of 'categories.dart';

class CategoriesLogic extends ChangeNotifier {
  late BuildContext context;
  final CafeService cafe = CafeService.client();

  CategoriesLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getCategories();
      getCauHinh();
    });
  }
  List<CategoriesData> data = [];
  String value = '';

  void getCategories() async {
    try {
      var a = await cafe.getCategories();

      data = a.data;
      notifyListeners();
    } catch (e) {
      data = [];
      notifyListeners();
      debugPrint('$e');
    }
  }

  void getCauHinh() async {
    try {
      var name = await cafe.getCauHinh();
      value = name.data!.value;
    } catch (e) {
      debugPrint('$e');
    }
  }
}
