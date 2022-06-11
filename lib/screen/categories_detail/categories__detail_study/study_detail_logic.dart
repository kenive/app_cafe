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
  late ScrollController controller1 = ScrollController();

  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtContent = TextEditingController();

  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  bool enable = true;
  String errorName = 'error';
  String errorContent = 'error';

  int size = 30;
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

  Future<void> loadHtmlString(
      Completer<WebViewController> controller1, BuildContext context) async {
    List id = ModalRoute.of(context)!.settings.arguments as List;
    WebViewController controller = await controller1.future;

    try {
      await controller.loadHtmlString(content(id[1].toString(), size));

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
     p{
       margin-left:0cm;
       font-size: ${size}px;
       margin-top:0cm;
       margin-bottom:0cm;
     }
    
     figure{
       margin-top:0cm;
       margin-bottom: 0cm;
       margin-left: 0cm;
       scrollbar-width: auto;
       overflow-x: scroll;
       scrollbar-height: auto;
       overflow-y: scroll;

     }
     *{
       font-size: ${size}px;

     }
</style>
   
     </head>
     <body>
     $a
    </body>
  
    </html>
    ''';
  List<String> lst = [];
  void getIdStudy(int id) async {
    try {
      var data = await cafe.getIdStudy(id);
      stt = id;
      data1 = data.data!;
      var categories = await cafe.getIdCategories(data1.danh_muc_id);

      dataCategories = categories.data!;

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
      listH2conTent = [];
      lst = [];

      size = 18;
      notifyListeners();
      loadHtmlString(controller, context);

      if (listH2conTent.isEmpty) {
        checkMucLuc = false;
      } else {
        checkMucLuc = true;
      }
      var comment = await cafe.getComment(id);
      if (comment.success) {
        dataComment = comment.data!;
      } else {
        dataComment = [];
      }

      notifyListeners();
    } catch (e) {
      dataComment = [];
      debugPrint('$e');
    }
  }

  void tang() {
    try {
      if (enable) {
        if (size == 50) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đã đạt độ phóng to nhất'),
          ));
          enable = false;
          notifyListeners();
        } else {
          size += 1;
          loadHtmlString(controller, context);
          notifyListeners();
        }
      }
      if (size == 10) {
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
        if (size == 10) {
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
      if (size == 50) {
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
