import 'package:flutter/material.dart';
import 'package:flutter_test_application/services/connectivty_service.dart';
import 'package:provider/provider.dart';

class ConnectivityWidget extends StatelessWidget {
  final Widget child;
  const ConnectivityWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityStatus>(
      builder: (_, value, __) {
        if (value == ConnectivityStatus.offline) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.cloud_off,
                    size: 100,
                    color: Colors.green,
                  ),
                  const Text(
                    "Please check the Internet Connection",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.refresh,
                          color: Colors.green,
                        ),
                        Text(
                          "Retry",
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
