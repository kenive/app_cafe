import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:app_cafe/models/comment/comment_admin.dart';

import 'package:app_cafe/models/commentData/comment_data.dart';

import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/widget/drawer_widget.dart';
import 'package:app_cafe/widget/drawer_wiget_begin.dart';
import 'package:app_cafe/widget/footer_loading/footer_loading.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
part 'study_detail_logic.dart';

class StudyDetail extends StatefulWidget {
  const StudyDetail({Key? key}) : super(key: key);

  @override
  State<StudyDetail> createState() => _StudyDetailState();
}

class _StudyDetailState extends State<StudyDetail>
    with AutomaticKeepAliveClientMixin {
  late StudyLogic study;
  late ScrollController controller;

  @override
  void initState() {
    study = StudyLogic(context: context);
    controller = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ChangeNotifierProvider.value(
      value: study,
      child: Scaffold(
        drawer: const DrawerBegin(),
        endDrawer: DrawerWidget(
          detailData: study.dataCategories,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 35),
              color: const Color(0xfff09af00),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context)),
                title: Selector<StudyLogic, CategoryDetailData>(
                  selector: (_, state) => state.data1,
                  builder: (context, value, child) {
                    if (value.tieu_de.isEmpty) {
                      return const SizedBox();
                    }
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        study.data1.tieu_de,
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
                      icon:
                          const Icon(Icons.menu, size: 28, color: Colors.white),
                      onPressed: () => Scaffold.of(context).openEndDrawer());
                }),
              ),
            ),
            Flexible(
              child: Stack(children: [
                Selector<StudyLogic, CategoryDetailData>(
                  selector: (_, state) => state.data1,
                  builder: (context, value1, child) {
                    if (value1.noi_dung.isEmpty) {
                      return const Center(
                          child: FooterLoading(isLoading: true));
                    }
                    return SingleChildScrollView(
                        controller: controller,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Selector<StudyLogic, double>(
                              builder: (context, value, child) {
                                return Html(
                                  data: value1.noi_dung,
                                  style: {
                                    '*': Style(fontSize: FontSize(value)),
                                    'figure': Style(
                                      width: 400,
                                      height: 200,
                                    ),
                                  },
                                );
                              },
                              selector: (_, state) => state.size,
                            ),
                            const Divider(
                              height: 5,
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                            Selector<StudyLogic, List<CommentAdmin>>(
                              selector: (_, state) => state.dataComment,
                              builder: (context, value, child) {
                                if (value.isEmpty) {
                                  return const SizedBox();
                                }
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Hỏi đáp, góp ý kiến',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      color: Colors.green.shade100,
                                      elevation: 2,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade100,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(value[0].ho_ten,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                    DateFormat(
                                                            'dd-MM-yyyy  kk:mm')
                                                        .format(DateTime.parse(
                                                            value[0]
                                                                .created_at)),
                                                    style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                ],
                                              ),
                                              Html(
                                                data: value[0].noi_dung,
                                                style: {
                                                  '*': Style(
                                                      fontSize:
                                                          const FontSize(17)),
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Card(
                                      color: Colors.white,
                                      elevation: 2,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(value[1].ho_ten,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                    DateFormat(
                                                            'dd-MM-yyyy  kk:mm')
                                                        .format(DateTime.parse(
                                                            value[1]
                                                                .created_at)),
                                                    style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Text(value[1].noi_dung,
                                                  textScaleFactor: 1.2,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    height: 1.222,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 70,
                            )
                          ],
                        ));
                  },
                ),
                Positioned(
                  right: 13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          study.tang();
                        },
                        child: const Text('Tăng'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          study.giam();
                        },
                        child: const Text('Giảm'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: Builder(builder: (context) {
          return Container(
            padding: const EdgeInsets.only(left: 30),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Selector<StudyLogic, bool>(
                  selector: (_, state) => state.checkMucLuc,
                  builder: (_, value, __) {
                    if (value) {
                      return ElevatedButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                          //controller.jumpTo(1000);
                        },
                        child: const Text('Mục lục'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 4, 63, 111),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ChangeNotifierProvider.value(
                            value: study,
                            builder: (_, value) {
                              return GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                },
                                child: AlertDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  backgroundColor: Colors.white,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Góp ý, đặt câu hỏi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 20)),
                                      IconButton(
                                        icon: const Icon(Icons.close,
                                            color: Colors.black),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                  content: Selector<StudyLogic,
                                      Tuple2<String, String>>(
                                    selector: (_, state) => Tuple2(
                                        state.errorName, state.errorContent),
                                    builder: (_, value, __) {
                                      return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              TextField(
                                                onChanged: (value) {
                                                  study.validateAddComment();
                                                },
                                                controller: study.txtName,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  iconColor: Colors.green,
                                                  focusedBorder: value
                                                          .item1.isNotEmpty
                                                      ? const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2),
                                                        )
                                                      : const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 2),
                                                        ),
                                                  prefixIcon: const Icon(
                                                    Icons.person,
                                                  ),
                                                  labelText: 'Họ và tên',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                controller: study.txtEmail,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                  prefixIcon: const Icon(
                                                    Icons.email,
                                                  ),
                                                  labelText: 'Nhập Email',
                                                  border: OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  //study.validateEmail();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                controller: study.txtPhone,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                  prefixIcon:
                                                      const Icon(Icons.call),
                                                  labelText:
                                                      'Nhập số điện thoại',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  //study.validatePhone();
                                                },
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                onChanged: (value) {
                                                  study.validateAddComment();
                                                },
                                                controller: study.txtContent,
                                                textAlign: TextAlign.left,
                                                keyboardType:
                                                    TextInputType.text,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                decoration: InputDecoration(
                                                  focusedBorder: value
                                                          .item2.isNotEmpty
                                                      ? const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 2),
                                                        )
                                                      : const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 2),
                                                        ),
                                                  contentPadding:
                                                      EdgeInsets.all(10),
                                                  hintText: 'Nhập Nội dung',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                maxLines: 4,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  child: Row(
                                                    children: const [
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Icon(Icons.send,
                                                          color: Colors.white),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 120),
                                                        child: Text('GỬI'),
                                                      )
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    if (value.item1.isEmpty &&
                                                        value.item2.isEmpty) {
                                                      study.addComment();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    primary: value.item1
                                                                .isEmpty &&
                                                            value.item2.isEmpty
                                                        ? Colors.green
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  },
                  child: const Text('Góp ý'),
                  style: ElevatedButton.styleFrom(primary: Colors.purple),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
