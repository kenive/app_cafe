import 'package:app_cafe/models/user/user.dart';
import 'package:app_cafe/services/apis/cafe_api.dart';
import 'package:app_cafe/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
part 'auth_loading_logic.dart';

class AuthLoading extends StatefulWidget {
  const AuthLoading({Key? key}) : super(key: key);

  @override
  State<AuthLoading> createState() => _AuthLoadingState();
}

class _AuthLoadingState extends State<AuthLoading>
    with AutomaticKeepAliveClientMixin {
  late AuthLogic logic;

  @override
  void initState() {
    super.initState();
    //logic = AuthLogic(context: context);
    logic = context.read<AuthLogic>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider.value(
        value: logic,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/first_screen.jpg',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Selector<AuthLogic, bool>(
                  builder: (context, value, child) {
                    if (value) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushReplacementNamed(context, 'catagories');
                      });
                    }

                    return const CircularProgressIndicator();
                  },
                  selector: (_, state) => state.check),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Đang tải dữ liệu...',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
