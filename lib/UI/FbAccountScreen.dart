import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class fbscreen extends StatefulWidget {
  const fbscreen({Key? key}) : super(key: key);
  @override
  State<fbscreen> createState() => _fbscreenState();
}

class _fbscreenState extends State<fbscreen> {
  Map<String, dynamic>? _userData;
  AccessToken? accessToken;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkIfisLoggedIn();
  }

  _checkIfisLoggedIn() async {
    final accessTokens = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessTokens != null) {
      print(accessTokens.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      accessToken = accessTokens;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    _userData = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(),
    );
  }
}
