import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:async';

import 'package:web3auth_flutter/web3auth_flutter.dart';


class Web3Register extends StatefulWidget {
  @override
  State<Web3Register> createState() => _Web3Register();
}

class _Web3Register extends State<Web3Register> {
  String _result = '<empty>';
  bool logoutVisible = false;
  
   @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    HashMap themeMap = HashMap<String, String>();
    themeMap['primary'] = "#fff000";

    await Web3AuthFlutter.init(
      clientId:
          'BJvlvI4od8kZAoUoZXFCQYXcXV8K9q42p36ZlWmmzBI79fTDeAgjLs8Ig9aFWE33mS71qf8EVWMEZ9DGRTllvOw',
      network: Network.mainnet,
      redirectUri: 'org.torusresearch.flutter.web3authexample://auth',
      whiteLabelData: WhiteLabelData(
          dark: true, name: "flutter_deposit_app", theme: themeMap),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Login with'),
            ),
            ElevatedButton(
                onPressed: _login(_withGoogle), child: const Text('Google')),
            ElevatedButton(
                onPressed: _login(_withFacebook), child: const Text('Facebook')),
            ElevatedButton(
                onPressed: _login(_withReddit), child: const Text('Reddit ')),
            ElevatedButton(
                onPressed: _login(_withDiscord), child: const Text('Discord')),
            Visibility(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red // This is what you need!
                      ),
                  onPressed: _logout(),
                  child: const Text('Logout')),
              visible: logoutVisible,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Result: $_result'),
            )
          ],
        )),
    );
  }

  // Functions to log in/out
  VoidCallback _login(Future<Web3AuthResponse> Function() method) {
    return () async {
      try {
        final Web3AuthResponse response = await method();
        setState(() {
          _result = response.toString();
          logoutVisible = true;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

  VoidCallback _logout() {
    return () async {
      try {
        await Web3AuthFlutter.logout();
        setState(() {
          _result = '<empty>';
          logoutVisible = false;
        });
      } on UserCancelledException {
        print("User cancelled.");
      } on UnKnownException {
        print("Unknown exception occurred");
      }
    };
  }

    Future<Web3AuthResponse> _withGoogle() {
    return Web3AuthFlutter.login(
        provider: Provider.google, mfaLevel: MFALevel.MANDATORY);
  }

  Future<Web3AuthResponse> _withFacebook() {
    return Web3AuthFlutter.login(
        provider: Provider.facebook, mfaLevel: MFALevel.MANDATORY);
  }

  Future<Web3AuthResponse> _withReddit() {
    return Web3AuthFlutter.login(
        provider: Provider.email_passwordless, mfaLevel: MFALevel.NONE, extraLoginOptions: ExtraLoginOptions(login_hint: "sosid94742@abincol.com"));
  }

  Future<Web3AuthResponse> _withDiscord() {
    return Web3AuthFlutter.login(provider: Provider.discord);
  }

}
