import 'package:app_cafe/models/categories/categories.dart';
import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/services/contants/url.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'categories_logic.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with AutomaticKeepAliveClientMixin {
  late CategoriesLogic logic;
  @override
  void initState() {
    logic = context.read<CategoriesLogic>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xfff09af00),
      body: Column(
        children: [
          Selector<CategoriesLogic, String>(
            selector: (_, state) => state.value,
            builder: (context, value, child) {
              return SizedBox(
                height: 250,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Quy trình kĩ thuật sản xuất',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 250,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                  )),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 35),
                physics: const BouncingScrollPhysics(),
                child: Selector<CategoriesLogic, List<CategoriesData>>(
                  selector: (_, state) => state.data,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return const Center(
                          child: CircularProgressIndicator(strokeWidth: 4));
                    }
                    return Column(
                      children: [
                        Wrap(
                          children: List.generate(value.length, (index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, 'catagories_detail', arguments: [
                                  value[index].id,
                                  value[index].ten_day_du
                                ]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                213, 33, 240, 78)
                                            .withOpacity(0.2),
                                        offset: const Offset(1, 1),
                                      )
                                    ],
                                    color:
                                        const Color.fromARGB(213, 33, 240, 78)
                                            .withOpacity(0.2),
                                  ),
                                  width: MediaQuery.of(context).size.width / 2 -
                                      15,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(150),
                                          child: Image.network(
                                            Constant.url +
                                                value[index].hinh_anh,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                          value[index].ten,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
