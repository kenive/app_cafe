part of 'study_detail.dart';

class StudyLogic extends ChangeNotifier {
  late BuildContext context;
  final CafeService cafe = CafeService.client();
  int id = 0;
  StudyLogic({required this.context}) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      List id = ModalRoute.of(context)!.settings.arguments as List;
      getIdStudy(id[0]);
      setId(id[0]);
    });
  }

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtContent = TextEditingController();

  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  bool enable = true;
  String errorName = 'error';
  String errorContent = 'error';

  int size = 36;
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
  double height = 100;

  Future<void> onPageFinished(
      BuildContext context, Completer<WebViewController> _controller) async {
    WebViewController controller = await _controller.future;
    height = double.parse(await controller
        // ignore: deprecated_member_use
        .evaluateJavascript("document.documentElement.scrollHeight;"));
    print(height);

    notifyListeners();
  }

  Future<void> loadHtmlString(
      Completer<WebViewController> controller1, BuildContext context) async {
    WebViewController controller = await controller1.future;

    try {
      await controller.loadHtmlString(content(data1.noi_dung, size));

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  String content(String a, int size) => '''
     <!DOCTYPE html>
     <html lang="en">
     <head>
     <style>

body {
  font-size: ${size}px;
}
</style>
   
     </head>
     <body>
     $a
    </body>
    </html>
    ''';

  void getIdStudy(int id) async {
    try {
      var data = await cafe.getIdStudy(id);
      stt = id;
      data1 = data.data!;
      var categories = await cafe.getIdCategories(data1.danh_muc_id);

      dataCategories = categories.data;

      var document = parse(data1.noi_dung);

      //onPageFinished(context, controller);

      document.getElementsByTagName('h2').forEach((element) {
        listH2conTent.add(element.innerHtml);
      });
      if (listH2conTent.isEmpty) {
        checkMucLuc = false;
      }

      var comment = await cafe.getComment(id);
      dataComment = comment.data!;

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
      var document = parse(data1.noi_dung);
      listH2conTent = [];

      document.getElementsByTagName('h2').forEach((element) {
        listH2conTent.add(element.innerHtml);
      });
      size = 36;
      notifyListeners();
      loadHtmlString(controller, context);

      if (listH2conTent.isEmpty) {
        checkMucLuc = false;
      } else {
        checkMucLuc = true;
      }
      var comment = await cafe.getComment(id);
      dataComment = comment.data!;

      notifyListeners();
    } catch (e) {
      dataComment = [];
      debugPrint('$e');
    }
  }

  void tang() {
    try {
      if (enable) {
        if (size == 60) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đã đạt độ phóng to nhất'),
          ));
          enable = false;
          notifyListeners();
        } else {
          loadHtmlString(controller, context);
          size += 1;
          notifyListeners();
        }
      }
      if (size == 20) {
        enable = true;
        size += 1;
        loadHtmlString(controller, context);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void giam() {
    try {
      if (enable) {
        if (size == 20) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đã đạt độ thu nhỏ thấp nhất')));
          enable = false;
          notifyListeners();
        } else {
          size -= 1;
          loadHtmlString(controller, context);
          notifyListeners();
        }
      }
      if (size == 60) {
        enable = true;
        size -= 1;
        loadHtmlString(controller, context);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }

    notifyListeners();
  }

  void setId(int value) {
    id = value;
    notifyListeners();
  }

  void validateAddComment() {
    if (txtName.text.trim().isEmpty) {
      errorName = 'error';
    } else if (txtName.text.trim().isNotEmpty) {
      errorName = '';
    }
    if (txtContent.text.trim().isEmpty) {
      errorContent = 'error';
    } else if (txtContent.text.trim().isNotEmpty) {
      errorContent = '';
    }
    notifyListeners();
  }

  void clearAllTextField() {
    txtContent.clear();
    txtEmail.clear();
    txtName.clear();
    txtPhone.clear();
    errorContent = 'error';
    errorName = 'error';
    notifyListeners();
  }

  void addComment() async {
    try {
      CommentData data = await cafe.addComment(
        id,
        txtContent.text,
        txtEmail.text,
        txtPhone.text,
        txtName.text,
      );
      if (data.success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bình luận đang chờ duyệt!')));
      }
      clearAllTextField();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
