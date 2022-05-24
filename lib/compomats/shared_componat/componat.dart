

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_udemy/styles/icon_broken.dart';

import '../../moudules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 10.0,
  required String text,
  required Function function,
}) =>
    Container(
      height: 40,
      width: width,
      child: MaterialButton(
        onPressed:(){
          function();
        } ,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   onSubmit,
   onChange,
  required validator,
  required String label,
  required IconData prefix,
   IconData? suffix,
  bool isPassword =false,
  suffixPressed,
  onTab,

})=> TextFormField(
  controller:controller ,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  onTap:onTab,
  validator: validator,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix != null? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),
);





 Widget myDivider ()=> Padding(
   padding: const EdgeInsets.all(8.0),
   child: Container(
     width: double.infinity,
     height: 2,
     color: Colors.grey,
   ),
 );



 Widget articleBuilder(list,context, {isSerach =false})=> ConditionalBuilder(
   condition: list.length>0,
   builder: (context) => ListView.separated(
     // btshel l scroll l azr2 we bt5leh ynot
     physics: BouncingScrollPhysics(),
     itemBuilder: (context, index) => buildArticleItem(list[index],context),
     separatorBuilder: (context, index) => myDivider (),
     itemCount:list.length,
   ),
   fallback: (context)=> isSerach ? Container() : Center(child: CircularProgressIndicator()),
 );

Widget buildArticleItem (article, context)=> InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                      "${article['title']}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1
                  ),
                ),
                Text("${article['publishedAt']}",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),

              ],
            ),
          ),
        )
      ],
    ),
  ),
);


void navigateTo(context,widget) => Navigator.push(
     context,
     MaterialPageRoute(
         builder: (context)=> widget,
     )
 );

void navigateAndFinish (context,widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context)=> widget,
    ),
      (Route<dynamic>route) => false,
);

Widget defaultTextBottom ({
  required Function function,
  required String text,
})=> TextButton( onPressed: (){function();}, child: Text(text.toUpperCase(),),);


void showToast({
  required String? text,
  required ToastStates state,
})=> Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor (state),
    textColor: Colors.white,
    fontSize: 16.0
);
//enum 3bara 3n 7aga so8ira b5tar meno we bona2an 3ale ha5taro hy3ml 7aga

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor (ToastStates state)
{
  Color color ;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.yellow;
      break;
  }
  return color;
}




Widget defaultAppBar ({
  required BuildContext context,
  String? title,
  List<Widget>? action ,
})=> AppBar(
  toolbarHeight: 20,
  leading: IconButton(onPressed: ()
  {
    Navigator.pop(context);
  },
      icon: Icon(
        IconBroken.Arrow___Left_2
      )),

  title: Text(
    title!,
  ),
  actions: action,
);