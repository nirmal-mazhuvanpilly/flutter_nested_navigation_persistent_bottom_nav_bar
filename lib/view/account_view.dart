import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: PaddingConsts.padding10,
            child: ElevatedButton(
                onPressed: () {
                  NavigatorKeysNControllers.accountNavigatorKey.currentState
                      ?.pushNamed("accelerometer_view");
                },
                child: const Text("Accelerometer")),
          )
        ],
      ),
    );
  }
}
