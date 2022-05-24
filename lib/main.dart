import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/compomats/shared_componat/bloc_observer.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/news_app/states.dart';
import 'package:project_udemy/styles/themes.dart';
import 'layout/news_app/cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'network/local/shared_preferences.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dah lazm 3sahan ana 3amlt await ll cachehelper we tlama 3mlt await lazm a3ml async lle main
  // fa lazm a3ml eli fo2 deh 3shan 3shan dah byt2ked en kul 7aga hena fel method 5last
  // we b3den y3ml run ll app
  await Firebase.initializeApp();

  DioHelper.init();
  await CacheHelper.init();
// Bloc.observer =MyBlocObserver();

  //deh 3shan lw 3yaz a5leh yb3t ll user eli da5l dah
  var token  = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'onMessage', state: ToastStates.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'Opened app', state: ToastStates.SUCCESS);

  });

  BlocOverrides.runZoned(
        () {
      // CounterCubit();

      bool? isDark = CacheHelper.getData(key: 'isDark');

      Widget? widget;


      runApp(MyApp(
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({ this.isDark});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getScience()
              ..getSports()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
              // ThemeMode.light,
              NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: NewsLayout()
            //SocialLoginScreen(),
            // startWidget,
          );
        },
      ),
    );
  }
}
