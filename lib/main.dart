import 'package:flutter/material.dart';
import 'package:githubjobs/core/data/GithubJob.dart';
import 'package:githubjobs/pages/JobDetails.dart';
import 'package:githubjobs/pages/Splash.dart';
import 'package:githubjobs/pages/ViewJobs.dart';
import 'package:githubjobs/providers/GithubJobsProvider.dart';
import 'package:githubjobs/services/serviceFactory.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GitHubJobsProvider>(
      create: (_) => GitHubJobsProvider(),
      child: MaterialApp(
        title: 'Github Jobs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardTheme: CardTheme(elevation: 0.5),
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            color: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardTheme: CardTheme(elevation: 0.5),
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            color: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: SplashPage.id,
        routes: {
          SplashPage.id: (_) => SplashPage(),
          ViewJobsPage.id: (_) => ViewJobsPage(),
          JobDetails.id: (ctx) {
            final _arguments = ModalRoute.of(ctx).settings.arguments;
            return JobDetails(
              job: Map<String, dynamic>.from(_arguments)['job'] as GithubJob,
            );
          },
        },
      ),
    );
  }
}
