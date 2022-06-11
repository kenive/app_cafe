import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:app_cafe/models/comment/comment_admin.dart';
import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/widget/drawer_widget.dart';
import 'package:app_cafe/widget/footer_loading/footer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:html/parser.dart' show parse;

part 'categories_title_logic.dart';

class CategoriesTitle extends StatefulWidget {
  const CategoriesTitle({Key? key}) : super(key: key);

  @override
  State<CategoriesTitle> createState() => _CategoriesTitleState();
}

class _CategoriesTitleState extends State<CategoriesTitle> {
  late CategoriesTitleLogic title;
  //late StudyLogic study;

  @override
  void initState() {
    title = CategoriesTitleLogic(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: title,
      child: Scaffold(
        endDrawer: DrawerWidget(
          detailData: title.dataCategories,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.shade300, Colors.green.shade200],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.5, 0.0),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green.shade700, Colors.green.shade500],
                      begin: const FractionalOffset(0.0, 5.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.mirror),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context)),
                  title: Selector<CategoriesTitleLogic, CategoryDetailData>(
                    selector: (_, state) => state.data1,
                    builder: (context, value, child) {
                      if (value.tieu_de.isEmpty) {
                        return const Center(
                            child: FooterLoading(
                          isLoading: true,
                        ));
                      }
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.tieu_de,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  trailing: Builder(builder: (context) {
                    return IconButton(
                        icon: const Icon(Icons.menu,
                            size: 28, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openEndDrawer());
                  }),
                ),
              ),
              Flexible(
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Selector<CategoriesTitleLogic,
                        List<CategoryDetailData>>(
                      selector: (p0, p1) => p1.dataCategories,
                      builder: (context, value, child) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: title.tieuDe.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'study_detail',
                                    arguments: [
                                      value[index].id,
                                      title.tieuDe[index]
                                    ]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(title.tieuDe[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w700,
                                        )),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
