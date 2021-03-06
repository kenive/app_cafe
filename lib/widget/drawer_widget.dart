import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:app_cafe/screen/categories_detail/categories__detail_study/study_detail.dart';
import 'package:app_cafe/screen/categories_detail/categories_title/categories_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class DrawerWidget extends StatefulWidget {
  List<CategoryDetailData> detailData;

  DrawerWidget({Key? key, required this.detailData}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late CategoriesTitleLogic title;
  @override
  void initState() {
    title = context.read<CategoriesTitleLogic>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: title,
      child:
          Selector<CategoriesTitleLogic, Tuple2<List<CategoryDetailData>, int>>(
        selector: (_, state) => Tuple2(state.dataCategories, state.stt),
        builder: (context, value, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green, Colors.green.shade400],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: const [0.0, 0.5],
                  tileMode: TileMode.clamp),
            ),
            child: Drawer(
              backgroundColor: Colors.green.shade300,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  itemCount: value.item1.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              title.loadDataStudy(value.item1[index].id);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: value.item2 == value.item1[index].id
                                  ? Colors.grey
                                  : Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                value.item1[index].tieu_de,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    );
                  }),
            ),
          );
        },
      ),
    );
  }
}
