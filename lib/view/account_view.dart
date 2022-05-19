import 'package:flutter/material.dart';
import 'package:flutter_test_application/utils/navigator_keys.dart';
import 'package:flutter_test_application/widgets/count_down_timer_widget.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts"),
        actions: const [
          SizedBox(
            width: 100,
            child: FittedBox(
              child: CountDownTimerWidget(),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  NavigatorKeysNControllers.accountNavigatorKey.currentState
                      ?.pushNamed("activity_recognition_view");
                },
                child: const Text("Acitivity Track"))
          ],
        ),
      ),
    );
  }
}
