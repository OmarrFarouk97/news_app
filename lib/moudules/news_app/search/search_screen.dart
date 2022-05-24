import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project_udemy/compomats/shared_componat/componat.dart';
import 'package:project_udemy/layout/news_app/cubit.dart';
import 'package:project_udemy/layout/news_app/states.dart';

class SearchScreen extends StatelessWidget
{
  var searchController =TextEditingController() ;
  var omar=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context, state) {},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Search '
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validator: (value)
                    {
                      if (value.isEmpty)
                      {
                        return 'Search must not empty';
                      }
                      return null;
                    },
                    onChange: (value)
                    {
                      NewsCubit.get(context).getSearch(value);

                    },
                    label: 'Search',
                    prefix: Icons.search
                ),
              ),
              Expanded(
                child: articleBuilder(list, context,isSerach: true),

              ),
            ],
          ),
        );
      },
    );
  }
}
