import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/bloc/bloc_observer.dart';
import 'package:number_trivia_clean_architecture/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

void main() async {
  //! The dependencies have to be registered before building the UI
  WidgetsFlutterBinding
      .ensureInitialized(); // instance of the WidgetsBinding needed initializing before calling runApp
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocOverrides.runZoned(() {
        return NumberTriviaPage();
      }, blocObserver: MyBlocObserver()),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // ignore: deprecated_member_use
        accentColor: Colors.pinkAccent.shade400,
      ),
    );
  }
}
