import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_application/providers/account_provider.dart';
import 'package:flutter_test_application/widgets/count_down_timer_widget.dart';
import 'package:provider/provider.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Consumer<AccountProvider>(
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: () async {
                    context.read<AccountProvider>().pickImageFromGallery();
                  },
                  child: (value.account == null ||
                          (value.account?.image?.isEmpty ?? false))
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(
                                      base64Decode((value.account?.image)!)))),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
