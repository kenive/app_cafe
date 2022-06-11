import 'package:app_cafe/screen/categories_detail/categories__detail_study/study_detail.dart';
import 'package:app_cafe/screen/categories_detail/categories_title/categories_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerTitle extends StatefulWidget {
  const DrawerTitle({Key? key}) : super(key: key);

  @override
  State<DrawerTitle> createState() => _DrawerTitleState();
}

class _DrawerTitleState extends State<DrawerTitle> {
  late StudyLogic title;
  @override
  void initState() {
    title = context.read<StudyLogic>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: title,
      child: Selector<StudyLogic, List<String>>(
        selector: (p0, p1) => p1.tieuDe,
        builder: (context, value, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green.shade900, Colors.green.shade500],
                  begin: const FractionalOffset(0.0, 5.0),
                  end: const FractionalOffset(0.5, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.mirror),
            ),
            child: Drawer(
              backgroundColor: Colors.green.shade300,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // setState(() {
                            //   title.loadDataStudy(value[index].id);
                            // });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              // color: value.item2 == value.item1[index].id
                              //     ? Colors.grey
                              //     : Colors.white,
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
                                value[index],
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
