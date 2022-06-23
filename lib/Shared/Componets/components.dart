import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget textField(
    {Color ?color,
      required String text,
  double fontSize = 22}) =>
    Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color
      ),
    );

Widget reportContainer({String? title,
  String? subTitle,
  String? whichReport1,
  String? whichReport2,
  context,
  required Function() onTap}) =>
    Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white.withOpacity(1),
          Colors.white.withOpacity(0.5)
          // Colors.blue.shade200
        ], begin: Alignment.bottomLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textField(
              text: '$title',
              fontSize: 18,
            ),
            SizedBox(
              height: 20,
            ),
            textField(text: '$whichReport1', fontSize: 22),
            textField(text: '$whichReport2', fontSize: 22),
            textField(text: '$subTitle', fontSize: 16),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 280,
                ),
                Container(
                  child: IconButton(
                    onPressed: () {
                      onTap();
                    },
                    icon: Icon(Icons.play_circle_fill),
                    color: Colors.black,
                    iconSize: 60,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(55),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(5, 5),
                            blurRadius: 25,
                            color: Colors.white.withOpacity(0.5))
                      ]),
                )
              ],
            )
          ],
        ),
      ),
    );

void navigateTo(context, {required widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget defaultFormText({
  bool readOnly = false,
  required TextEditingController control,
  required TextInputType type,
  required dynamic validator,
  Function? onSubmit,
  Function? onChanged,
  Function()? onTap,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixClicked,
  Color borderColor = Colors.limeAccent,
  Color labelColor = Colors.white,
  Color textColor = Colors.white,
  Color backgroundColor = Colors.blueGrey,
  Color prefixIconColor = Colors.limeAccent,
  String ? textInputFormat,
}) =>
    TextFormField(
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('$textInputFormat')),],
      readOnly: readOnly,
      controller: control,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onTap: () {
        onTap!();
      },
      obscureText: isPassword,
      onChanged: (value) {
        onChanged!(value);
      },
      style: TextStyle(color: textColor,
          fontSize: 18),
      decoration: InputDecoration(
        errorStyle: TextStyle(
            fontSize: 12,
            color: Colors.red),
        fillColor: backgroundColor.withOpacity(0.5),
        filled: true,
        labelText: label,
        labelStyle: TextStyle(color: labelColor, fontSize: 14),
        prefixIcon: Icon(prefix, color: prefixIconColor,),
        suffixIcon: suffix != null ? IconButton(
          onPressed: () {
            suffixClicked!();
          },
          icon: Icon(suffix),
        ) : null,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 3),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 6),
            borderRadius: BorderRadius.circular(20)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 6),
            borderRadius: BorderRadius.circular(10)
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 6),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );

Widget defaultButton({
  Color backgroundColor = Colors.blueGrey,
  Color borderColor = Colors.limeAccent,
  required String buttonName,
  required Function() ? onTap,}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      backgroundColor: backgroundColor.withOpacity(0.8),
      padding: EdgeInsets.all(20),
      side: BorderSide(
          style: BorderStyle.solid,
          color: borderColor,
          width: 5
      ),
      shape: StadiumBorder(),
    ),
    onPressed: () {
      onTap!()
      ;
    },
    child: Text('$buttonName',
        style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold
        )),
  );
}

Widget circleDefaultButton({
  double width = 50,
  Color backGroundColor = Colors.blue,
  Color textColor = Colors.white,
  Color buttonBackGroundColor = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required void Function() onTap,
  required String text,
}) => Container(
    width: width,
    decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(radius)),
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        decoration: BoxDecoration(
            color: buttonBackGroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
          onPressed: onTap,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: TextStyle(
                fontSize: 16, color:textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));

Widget myDropDownMenu<listName>({
  required String label,
      className,
        listName,
   myDropDownValue,
  required myDropDownItems,
  required validator,
  required Function? onChange,
  Color borderColor = Colors.limeAccent,
  Color labelColor = Colors.white,

}) {
  return DropdownButtonFormField(
      validator: validator,
      decoration: InputDecoration(
        errorStyle:  TextStyle(
            fontSize: 16,
            color: Colors.red),
        labelText: label,
        labelStyle: TextStyle(color: labelColor,
            fontSize: 18
        ),
       errorBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
         borderSide: BorderSide(
           width: 6,color: Colors.red
         )
       ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 3,color: borderColor
            ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                width: 3,color: borderColor
            )
        ),
      ),
      dropdownColor: Colors.blueGrey.withOpacity(0.7),
      style: TextStyle(
          fontSize: 24,
          color: Colors.white
      ),
      iconEnabledColor: Colors.white,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 30,
      menuMaxHeight: 200,
      focusColor: Colors.limeAccent,
      value: myDropDownValue,
      onChanged: (value) {
        onChange!(value);
      },
      items: myDropDownItems);
}

Widget myGestureDetectorWithImage(context, {
  required String image,
  required String name,
  required Function()? onTap
}) {
  return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Image.asset('$image',
                width: 90, height: 90,
              ),
              Text(
                '$name',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 2)
            )
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      )
  );
}

Widget myGestureDetectorWithIcon(context, {
  required Icon icon,
  required String name,
  required Color shadowColor,
  required Color containerColor,
  required Color iconColor,
  required Function()? onTap
}) {
  return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              IconButton(
                onPressed: () {
                  onTap!();
                },
                icon: icon,
                iconSize: 100,
                color: iconColor,
              ),
              Text(
                '$name',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(
                color: shadowColor,
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 2)
            )
            ],
            borderRadius: BorderRadius.circular(8.0),
            color: containerColor,
          ),
        ),
      )
  );
}


Widget newReportContainer({
  required String title,
  required String subTitle,
  required Icon myIcon,
  context,
  required Function() onTap}) =>
    Container(
      padding: const EdgeInsets.only(top: 10, left: 10),
      width: 100,
      height: 155,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.9)
              // Colors.blue.shade200
            ],),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(5, 5),
                blurRadius: 50,
                color: Colors.white.withOpacity(0.8))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                textField(text: '$title', fontSize: 18),
                SizedBox(height: 5,),
                textField(text: '$subTitle', fontSize: 14),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(iconSize: 30,
                    color: Colors.amber,
                    onPressed: () {
                      onTap();
                    },
                    icon: myIcon,),
                ),
              ],),
          ),

        ],
      ),
    );

Widget mainWidgetHomeScreen({
  required String imageName,
  required String title,
  context,
  required Function() onTap}) =>
    InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.white.withOpacity(0.2)
              ],),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            // boxShadow: [
            //   // BoxShadow(
            //   //     offset: Offset(5, 5),
            //   //     blurRadius: 50,
            //   //     color: Colors.white.withOpacity(0.0))
            // ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              textField(text: '$title', fontSize: 18,color: Colors.white),
               SvgPicture.asset(imageName,fit: BoxFit.fitWidth,height: 120,),
            ],
          ),
        ),
      ),
    );

Widget umbrellaContainer({
  context,
  required String title,
  required Color color,
}) {
  return Container(
    height: 60,
    width: MediaQuery
        .of(context)
        .size
        .width,
    child: Center(child: textField(text: '$title',
        fontSize: 28)),
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
            color.withOpacity(1),
            color.withOpacity(0.5)
          ]
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(80),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
        topRight: Radius.circular(80),
      ),
    ),
  );
}

Widget dividerWidget() =>
    Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );


void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Widget),
            (route) => false);

Widget defaultTextButton({
  required void Function() onTap,
  required String text,
  Color textColor = Colors.blue
}) =>
    TextButton(
        style: TextButton.styleFrom(
            primary: textColor
        ),
        onPressed: () {
          onTap();
        },
        child: Text(text.toUpperCase())
    );

void showToast({
  required String text,
  required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastState { Success, Error, Warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.Success:
      color = Colors.green;
      break;
    case ToastState.Error:
      color = Colors.red;
      break;
    case ToastState.Warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget profileCircleAvatar({
  ImageProvider ?imageProvider,
  double radius = 20,
  Color ?backgroundColor,String ?image}) =>
    Padding(
      padding: const EdgeInsets.all(3.0),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        backgroundImage: imageProvider
        // NetworkImage(
        //     image!
        // ),
      ),
    );

Widget defaultAppBar({
  required BuildContext context,
  Color?backGroundColor,
  Function()? onTap,
  String ?title,
  List<Widget>? actions,
  bool centerTitle=false,
  double elevation=0.5,
  Widget ?navigateToWidget,
  Widget ?navigateAndFinishWidget,
})=>AppBar(
  elevation:elevation ,
  centerTitle:centerTitle ,
  backgroundColor: backGroundColor,
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios),
    onPressed: (){
      Navigator.pop(context);
       // navigateTo(context, widget: navigateToWidget);
    },
  ),
  title: Text(
      title!
  ),
  titleSpacing: 5.0,
  actions: actions,
);