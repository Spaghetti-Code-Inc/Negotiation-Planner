///File download from FlutterViz- Drag and drop a tools. For more details visit https://flutterviz.io/

import 'package:flutter/material.dart';


class Login extends StatelessWidget {

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Color(0xffc5c5c5),
body:
Stack(
alignment:Alignment.topLeft,
children: [
Container(
margin:EdgeInsets.symmetric(vertical: 100,horizontal:20),
padding:EdgeInsets.all(0),
width:MediaQuery.of(context).size.width,
height:MediaQuery.of(context).size.height,
decoration: BoxDecoration(
color:Color(0xffffffff),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.circular(16.0),
border:Border.all(color:Color(0x4d9e9e9e),width:1),
),
child:
Padding(
padding:EdgeInsets.all(16),
child:SingleChildScrollView(
child:
Column(
mainAxisAlignment:MainAxisAlignment.start,
crossAxisAlignment:CrossAxisAlignment.center,
mainAxisSize:MainAxisSize.max,
children: [
Padding(
padding:EdgeInsets.fromLTRB(0, 30, 0, 0),
child:Align(
alignment:Alignment.centerLeft,
child:Text(
"Login",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:22,
color:Color(0xff000000),
),
),
),
),
Padding(
padding:EdgeInsets.symmetric(vertical: 16,horizontal:0),
child:TextField(
controller:TextEditingController(),
obscureText:false,
textAlign:TextAlign.left,
maxLines:1,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
decoration:InputDecoration(
disabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
focusedBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
enabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
hintText:"Enter Email",
hintStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff494646),
),
filled:true,
fillColor:Color(0xffffffff),
isDense:false,
contentPadding:EdgeInsets.all(0),
),
),
),
TextField(
controller:TextEditingController(),
obscureText:false,
textAlign:TextAlign.start,
maxLines:1,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
decoration:InputDecoration(
disabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
focusedBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
enabledBorder:UnderlineInputBorder(
borderRadius:BorderRadius.circular(4.0),
borderSide:BorderSide(
color:Color(0xff000000),
width:1
),
),
hintText:"Enter Password",
hintStyle:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff494646),
),
filled:true,
fillColor:Color(0xffffffff),
isDense:false,
contentPadding:EdgeInsets.all(0),
),
),
Padding(
padding:EdgeInsets.fromLTRB(0, 16, 0, 30),
child:Align(
alignment:Alignment.centerRight,
child:Text(
"Forgot Password?",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff3a57e8),
),
),
),
),
MaterialButton(
onPressed:(){},
color:Color(0xff3e4b8c),
elevation:0,
shape:RoundedRectangleBorder(
borderRadius:BorderRadius.circular(16.0),
),
padding:EdgeInsets.all(16),
child:Text("Login", style: TextStyle( fontSize:16,
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
),),
textColor:Color(0xffffffff),
height:40,
minWidth:MediaQuery.of(context).size.width,
),
Padding(
padding:EdgeInsets.fromLTRB(0, 8, 0, 0),
child:Row(
mainAxisAlignment:MainAxisAlignment.center,
crossAxisAlignment:CrossAxisAlignment.start,
mainAxisSize:MainAxisSize.max,
children:[

Padding(
padding:EdgeInsets.fromLTRB(0, 0, 4, 0),
child:Text(
"Don't have an account?",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w400,
fontStyle:FontStyle.normal,
fontSize:14,
color:Color(0xff000000),
),
),
),
Text(
"SignUp",
textAlign: TextAlign.start,
overflow:TextOverflow.clip,
style:TextStyle(
fontWeight:FontWeight.w700,
fontStyle:FontStyle.normal,
fontSize:12,
color:Color(0xff000000),
),
),
],),),
],),),),
),
Container(
margin:EdgeInsets.all(0),
padding:EdgeInsets.all(0),
width:MediaQuery.of(context).size.width,
decoration: BoxDecoration(
color:Color(0xff000f31),
shape:BoxShape.rectangle,
borderRadius:BorderRadius.zero,
border:Border.all(color:Color(0x4d9e9e9e),width:1),
),
)

,
],),
)
;}
}