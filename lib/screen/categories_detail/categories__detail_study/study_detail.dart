import 'dart:async';

import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:app_cafe/models/comment/comment_admin.dart';

import 'package:app_cafe/models/commentData/comment_data.dart';
import 'package:app_cafe/widget/drawer_detail_study.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/widget/drawer_widget.dart';
import 'package:app_cafe/widget/drawer_wiget_begin.dart';
import 'package:app_cafe/widget/footer_loading/footer_loading.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
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

  @override
  void initState() {
    study = StudyLogic(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List id = ModalRoute.of(context)!.settings.arguments as List;

    return ChangeNotifierProvider.value(
      value: study,
      child: Scaffold(
        //drawer: const DrawerBegin(),
        // endDrawer: DrawerWidget(
        //   detailData: study.dataCategories,
        // ),
        endDrawer: const DrawerTitle(),
        body: Column(
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
                // title: Selector<StudyLogic, CategoryDetailData>(
                //   selector: (_, state) => state.data1,
                //   builder: (context, value, child) {
                //     if (value.tieu_de.isEmpty) {
                //       return const SizedBox();
                //     }
                //     return
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Html(data: id[2], style: {
                    '*': Style(
                        color: Colors.white,
                        fontSize: const FontSize(21),
                        fontWeight: FontWeight.bold)
                  }),
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
                Selector<StudyLogic,
                    Tuple2<CategoryDetailData, List<CommentAdmin>>>(
                  selector: (_, state) =>
                      Tuple2(state.data1, state.dataComment),
                  builder: (context, value1, child) {
                    if (value1.item1.noi_dung.isEmpty) {
                      return const Center(
                          child: FooterLoading(isLoading: true));
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: WebView(
                        debuggingEnabled: true,
                        zoomEnabled: false,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) async {
                          study.controller.complete(webViewController);
                          study.loadHtmlString(study.controller, context);
                        },
                      ),
                    );
                  },
                ),
                Positioned(
                  right: 13,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: study.tang,
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
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        backgroundColor: Colors.white,
                                        content:
                                            Selector<StudyLogic,
                                                    List<CommentAdmin>>(
                                                selector: (p0, p1) =>
                                                    p1.dataComment,
                                                builder:
                                                    (context, value1, child) {
                                                  return SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 500,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  'Hỏi đáp, góp ý kiến',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .black),
                                                                  onPressed: () =>
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop(),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Scrollbar(
                                                            child: ListView(
                                                              shrinkWrap: true,
                                                              children: [
                                                                Card(
                                                                  color: Colors
                                                                      .green
                                                                      .shade100,
                                                                  elevation: 3,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green
                                                                            .shade100,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8)),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(value1[0].ho_ten, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(
                                                                                DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.parse(value1[0].created_at)),
                                                                                style: const TextStyle(fontStyle: FontStyle.italic),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Html(
                                                                            data:
                                                                                value1[0].noi_dung,
                                                                            style: {
                                                                              '*': Style(fontSize: const FontSize(17)),
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
                                                                  color: Colors
                                                                      .white,
                                                                  elevation: 2,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              15),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(value1[1].ho_ten, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                                              Text(
                                                                                DateFormat('dd-MM-yyyy  kk:mm').format(DateTime.parse(value1[1].created_at)),
                                                                                style: const TextStyle(fontStyle: FontStyle.italic),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                15,
                                                                          ),
                                                                          Text(
                                                                              value1[1].noi_dung,
                                                                              textScaleFactor: 1.2,
                                                                              style: const TextStyle(
                                                                                fontSize: 13,
                                                                                height: 1.222,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: const Text('Xem bình luận'),
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
