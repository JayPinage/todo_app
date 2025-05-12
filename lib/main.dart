
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/Bloc/todo_bloc.dart';
import 'package:todo_app_bloc/Bloc/todo_event.dart';
import 'package:todo_app_bloc/home_screen.dart';
import 'package:todo_app_bloc/theme_notifier.dart';








void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeNotifier = await ThemeNotifier.create();
  runApp(MyApp(themeNotifier: themeNotifier));
}


class MyApp extends StatelessWidget {
  final ThemeNotifier themeNotifier;
  const MyApp({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, mode, __) {
        return BlocProvider(
          create: (_) => TodoBloc()..add(Isstoring()), // Load saved todos
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: mode,
            theme: ThemeData.light(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: const ColorScheme.light(
                primary: Colors.deepPurple,
                secondary: Colors.green,
              ),
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              scaffoldBackgroundColor: Colors.blueGrey,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
              colorScheme: const ColorScheme.dark(
                primary: Color.fromARGB(255, 47, 8, 115),
                secondary: Color.fromARGB(255, 76, 8, 193),
              ),
            ),
            home: HomeScreen(themeNotifier: themeNotifier),
          ),
        );
      },
    );
  }
}





















// import 'package:flutter/material.dart';
// import 'package:todo_app_bloc/Bloc/todo_bloc.dart';
// import 'package:todo_app_bloc/Bloc/todo_state.dart';
// import 'package:todo_app_bloc/home_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main(){
//   runApp(Myapp());
// }

// class Myapp extends StatelessWidget{
//   const Myapp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return BlocProvider(
      
//       create: (_)=>TodoBloc(),
     
//         child: BlocBuilder<TodoBloc,TodoState>(builder: (context,State){
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//          theme: State.isloading==true ? ThemeData.dark(useMaterial3: true).copyWith(
//           scaffoldBackgroundColor:  Colors.blueGrey,
//             appBarTheme: const AppBarTheme(
//     backgroundColor:Colors.blueGrey, // Slightly lighter dark grey
//   ),
//   colorScheme: const ColorScheme.dark(
//     primary: Color.fromARGB(255, 47, 8, 115),
//     secondary: Color.fromARGB(255, 76, 8, 193),
//   )
//          )
         
         
//          :ThemeData.light(useMaterial3: true).copyWith(
//           scaffoldBackgroundColor: Colors.white,
//           // appBarTheme: const AppBarTheme(
//           //   backgroundColor: Colors.blue,


//           // ),
//           colorScheme: const ColorScheme.light(
//                primary: Colors.deepPurple,
//     secondary: Colors.green,

//           )
//          ),

//             home: HomeScreen(),
//           );

//         })
      
//     );
//   }
// }