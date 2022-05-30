import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DrawerBegin extends StatefulWidget {
  List<String> detailData;

  DrawerBegin({Key? key, required this.detailData}) : super(key: key);

  @override
  State<DrawerBegin> createState() => _DrawerBeginState();
}

class _DrawerBeginState extends State<DrawerBegin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: MediaQuery.of(context).padding,
        child: Drawer(
          backgroundColor: Colors.green.shade100,
          child: ListView.builder(
            itemCount: widget.detailData.length,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: ((context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 1,
                child: InkWell(
                  onTap: () {
                    //print('nguyen');
                  },
                  child: Html(
                    data: widget.detailData[index].toString(),
                    style: {
                      '*': Style(
                          fontSize: const FontSize(16),
                          color: Colors.black,
                          padding: const EdgeInsets.all(5)),
                    },
                  ),
                ),
              );
            }),
          ),
        ));
  }
}
