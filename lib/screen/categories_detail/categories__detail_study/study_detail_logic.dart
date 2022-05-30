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
  bool enable = true;
  String errorName = '';
  String errorContent = '';

  double size = 21;

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

  void getIdStudy(int id) async {
    try {
      var data = await cafe.getIdStudy(id);
      stt = id;
      data1 = data.data!;
      var categories = await cafe.getIdCategories(data1.danh_muc_id);

      dataCategories = categories.data;

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

      notifyListeners();
    } catch (e) {
      debugPrint('$e');
    }
  }

  void tang() {
    try {
      if (enable) {
        if (size == 30) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Đã đạt độ phóng to nhất'),
          ));
          enable = false;
          notifyListeners();
        } else {
          size += 1;
          notifyListeners();
        }
      }
      if (size == 10) {
        enable = true;
        size += 1;
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
          notifyListeners();
        }
      }
      if (size == 30) {
        enable = true;
        size -= 1;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('$e');
    }

    notifyListeners();
  }

  bool _phoneNumberValidator(String value) {
    String pattern = r'((^(\+84|84|0|0084){1})(3|5|7|8|9))+([0-9]{8})$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    }
    if (!regex.hasMatch(value)) {
      return false;
    }

    return true;
  }

  bool _emailValidator(String value) {
    final RegExp PATTERN_EMAIL_FIRST = RegExp(r'^[a-zA-Z0-9]\S+$');
    final RegExp PATTERN_EMAIL =
        RegExp(r'^[^\W][a-zA-Z0-9-_\.]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
    final RegExp PATTERN_EMAIL_STRONG = RegExp(
        r'^(([^<>()\[\]\\.,;:\s@\"]+(\.[^<>()\[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!PATTERN_EMAIL_FIRST.hasMatch(value)) {
      return false;
    }
    if (!PATTERN_EMAIL.hasMatch(value)) {
      return false;
    }
    if (!PATTERN_EMAIL_STRONG.hasMatch(value)) {
      return false;
    }

    return true;
  }

  void validatePhone() {
    bool a = _phoneNumberValidator(txtPhone.text);
    print(a);
    notifyListeners();
  }

  void validateEmail() {
    bool a = _emailValidator(txtEmail.text);
    print(a);
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
    print(txtName.text);
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
      clearAllTextField();
      CommentData data = await cafe.addComment(
        id,
        txtContent.text,
        txtEmail.text,
        txtPhone.text,
        txtName.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bình luận đang chờ duyệt!')));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
