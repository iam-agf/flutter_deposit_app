import 'package:flutter/material.dart';
import 'package:flutter_deposit_app/components/register.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Title lol"),
        ),
        body: Web3Register());
  }
}