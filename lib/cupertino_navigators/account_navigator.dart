import 'package:flutter/material.dart';

class AccountNavigator extends StatelessWidget {
  const AccountNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts"),
      ),
      body: const Center(
        child: Text("Accounts"),
      ),
    );
  }
}
