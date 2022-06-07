import 'package:app_cafe/screen/categories_detail/categories__detail_study/study_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class DrawerBegin extends StatefulWidget {
  const DrawerBegin({Key? key}) : super(key: key);

  @override
  State<DrawerBegin> createState() => _DrawerBeginState();
}

class _DrawerBeginState extends State<DrawerBegin> {
  late StudyLogic study;
  @override
  void initState() {
    study = context.read<StudyLogic>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: study,
      child: SizedBox(
          //padding: MediaQuery.of(context).padding,
          child: Drawer(
        backgroundColor: Colors.green.shade100,
        child: ListView.builder(
          itemCount: study.listH2conTent.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
          itemBuilder: ((context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 1,
              child: InkWell(
                onTap: () async {
                  var casesensitive =
                      "self.find('${study.listH2conTent[index]}',{'CaseSensitive':true})";
                  var noncase = "self.find('${study.listH2conTent[index]}')";
                  Navigator.pop(context);
                },
                child: Html(
                  data: study.listH2conTent[index].toString(),
                  style: {
                    '*': Style(
                        fontSize: const FontSize(16),
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        padding: const EdgeInsets.all(5)),
                  },
                ),
              ),
            );
          }),
        ),
      )),
    );
  }
}
