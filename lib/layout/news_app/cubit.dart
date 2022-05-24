
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/layout/news_app/states.dart';

import '../../moudules/news_app/business/buisniss_screen.dart';
import '../../moudules/news_app/science/science_screen.dart';
import '../../moudules/news_app/sports/sports_screen.dart';
import '../../network/local/shared_preferences.dart';
import '../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{


  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex =0;

List<BottomNavigationBarItem> bottomItems= [
  BottomNavigationBarItem(
     icon: Icon(
       Icons.business,
     ),
   label: 'Business'

 ),
  BottomNavigationBarItem(
      icon: Icon(
          Icons.sports,
      ),
      label: 'Sports'
  ),
  BottomNavigationBarItem(
      icon: Icon(
          Icons.science,
      ),
      label: 'Science'
  ),

];

List<Widget> screens=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
];


void changeBottomNavBar(int index)
{
  currentIndex=index;
  if (index==1) getSports();
  if (index==2) getScience();


  emit(NewsBottomNavState());
}


List <dynamic> business = [];

void getBusiness ()
{
  emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'07927204d7c44b0bb87eff653e18e862'
      }
  ).then((value) {
    // print(value.data['articles'][0]['title']);
    business= value.data['articles'];
    // print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}



  List <dynamic> sports = [];

  void getSports ()
  {
    emit(NewsGetSportsLoadingState());
    if (sports.length==0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'sports',
            'apiKey':'07927204d7c44b0bb87eff653e18e862'
          }
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        sports= value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else
      {
        emit(NewsGetSportsSuccessState());

      }

  }


  List <dynamic> science = [];


  void getScience ()
  {
    emit(NewsGetScienceLoadingState());
    if (science.length==0)
    {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'us',
            'category':'science',
            'apiKey':'07927204d7c44b0bb87eff653e18e862'
          }
      ).then((value) {
        // print(value.data['articles'][0]['title']);
        science= value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else
      {
        emit(NewsGetScienceSuccessState());

      }

  }


  List <dynamic> search = [];


  void getSearch (String value)
  {
    emit(NewsGetSearchLoadingState());
      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q': '$value',
            'apiKey': '07927204d7c44b0bb87eff653e18e862'
          }
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSearchErrorState(error.toString()));
      });

  }

  bool isDark= false;
  void changeAppMode({ bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeAppMode());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeAppMode());
      });
    }
  }
}

