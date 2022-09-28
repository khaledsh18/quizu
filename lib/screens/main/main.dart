import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizu/entities/userscores.dart';
import 'package:quizu/utils/constants.dart';
import 'package:quizu/screens/main/home.dart';
import 'package:quizu/screens/main/leaderboard.dart';
import 'package:quizu/screens/login/checkcode.dart';
import 'package:quizu/screens/login/login.dart';
import 'package:quizu/screens/loading.dart';
import 'package:quizu/screens/login/name.dart';
import 'package:quizu/screens/main/profile.dart';
import 'package:quizu/screens/quiz/quizpage.dart';
import 'package:quizu/screens/quiz/quizresult.dart';
import 'package:quizu/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(
      create: (context) => UserScores(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QuizU',
        initialRoute: LoadingScreen.id,
        routes: {
          MainPage.id : (context) => MainPage(),
          LoginScreen.id : (context) => LoginScreen(),
          LoadingScreen.id : (context) => LoadingScreen(),
          CheckCode.id : (context) => CheckCode(),
          NameScreen.id : (context) => NameScreen(),
          QuizPage.id : (context) => QuizPage(),
          QuizResult.id : (context) => QuizResult(),
          Test.id : (context) => Test(),
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: secondaryColor,
            centerTitle: true,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: secondaryColor,
            showUnselectedLabels: false,
            selectedItemColor: Colors.white,
          ),
          scaffoldBackgroundColor: grey
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  static String id = 'main_page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Leaderboard(),
    Profile(),
  ];
  static const List<String> _labels = <String>[
    'Home',
    'Leaderboard',
    'Profile',
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_labels[_selectedIndex]),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard,),
            label: 'Leaderboard'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          )
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body:  SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

