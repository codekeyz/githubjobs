import 'package:flutter/material.dart';
import 'package:githubjobs/pages/ViewJobs.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'Splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed(ViewJobsPage.id);
  }

  @override
  Widget build(BuildContext context) {
    final _themeData = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          SizedBox(width: double.infinity),
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/img/github.png',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Github Jobs',
            style: _themeData.textTheme.bodyText1.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Spacer(),
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(strokeWidth: 1),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
