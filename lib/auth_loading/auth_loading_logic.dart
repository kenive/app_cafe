part of 'auth_loading.dart';

class AuthLogic extends ChangeNotifier {
  late BuildContext context;
  final CafeService cafe = CafeService.client();

  AuthLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      middleWare();
    });
  }
  bool check = false;

  void middleWare() async {
    await LocalStorage.init();

    try {
      if (LocalStorage.instance.token.isEmpty) {
        login();
      } else {
        check = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void login() async {
    try {
      User user = await cafe.login('client@caytrongtaynguyen.com', 'CtTn@2021');

      if (user.success) {
        check = true;
        LocalStorage().setToken(user.access_token);
        notifyListeners();
      }
    } catch (e) {
      check = false;
      notifyListeners();
      debugPrint('$e');
    }
  }
}
