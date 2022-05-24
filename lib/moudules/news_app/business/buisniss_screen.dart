import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_udemy/layout/news_app/cubit.dart';
import 'package:project_udemy/layout/news_app/states.dart';

import '../../../compomats/shared_componat/componat.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder:(context,state){
        var list =NewsCubit.get(context).business ;
        return articleBuilder(list,context);
      } ,
    );

  }
}
