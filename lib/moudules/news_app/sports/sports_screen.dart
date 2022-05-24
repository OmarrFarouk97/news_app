import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../compomats/shared_componat/componat.dart';
import '../../../layout/news_app/cubit.dart';
import '../../../layout/news_app/states.dart';


class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder:(context,state){
        var list =NewsCubit.get(context).sports ;
        return articleBuilder(list,context);
      } ,
    );

  }
}