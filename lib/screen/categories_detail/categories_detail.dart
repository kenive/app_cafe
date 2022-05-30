import 'package:app_cafe/models/categories_detail/detail_data.dart';
import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/services/contants/url.dart';
import 'package:app_cafe/widget/footer_loading/footer_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'catogories_detail_logic.dart';

class CategoriesDetail extends StatefulWidget {
  const CategoriesDetail({Key? key}) : super(key: key);

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail>
    with AutomaticKeepAliveClientMixin {
  late CategoriesDetailLogic detail;
  @override
  void initState() {
    super.initState();
    detail = CategoriesDetailLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List title = ModalRoute.of(context)!.settings.arguments as List;
    return ChangeNotifierProvider.value(
      value: detail,
      child: Scaffold(
        backgroundColor: Colors.green.shade100,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 35),
              color: const Color(0xfff09af00),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                //contentPadding: EdgeInsets.only(left: 0),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Align(
                  //alignment: Alignment.center,
                  child: Text(
                    title[1],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {},
                backgroundColor: Colors.white,
                color: Colors.green,
                child:
                    Selector<CategoriesDetailLogic, List<CategoryDetailData>>(
                  selector: (_, state) => state.data,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return const Center(
                          child: FooterLoading(
                        isLoading: true,
                      ));
                    }
                    return MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.length + 1,
                        //physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          if (index == value.length) {
                            return const SizedBox(
                              height: 30,
                            );
                          }
                          if (value.isEmpty) {
                            return const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 4));
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, 'study_detail',
                                  arguments: [
                                    value[index].id,
                                    value[index].tieu_de
                                  ]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10, bottom: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          height: 70,
                                          width: 130,
                                          child: Image.network(
                                            Constant.url +
                                                value[index].hinh_anh,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 12),
                                        child: Text(
                                          value[index].tieu_de,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
