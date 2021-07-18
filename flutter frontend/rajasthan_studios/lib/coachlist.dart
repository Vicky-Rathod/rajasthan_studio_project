 import 'dart:convert';

import 'package:flutter/material.dart';
 import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
 import 'package:http/http.dart' as http;
import 'package:rajasthan_studios/appointment_booking_screen.dart';

import 'model/coach_list_model.dart';
class CoachList extends StatefulWidget {
   const CoachList({Key? key}) : super(key: key);

   @override
   _CoachListState createState() => _CoachListState();
 }

 class _CoachListState extends State<CoachList> {
   Future <List<CoachModel>> fetchData() async {
     final response =
     await http.get(Uri.parse('https://rajasthanstudio.pythonanywhere.com/coach/coach-list/'), headers: {

       "Content-Type": "application/json"
     });

     if (response.statusCode == 200) {
       List jsonResponse = json.decode(response.body);
       return jsonResponse.map((data) => new CoachModel.fromJson(data)).toList();
     } else {
       throw Exception('Unexpected error occured!');
     }
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("CoachList"),),
       body: FutureBuilder<List<CoachModel>>(
         future: fetchData(),
         builder: (context, snapshot) {
           if (snapshot.hasData) {
             List<CoachModel> data = snapshot.data!;
             return AnimationLimiter(
               child: ListView.builder(
                   itemCount: data.length,
                   itemBuilder: (context, index) {
                     var name = data[index].name;
                     var timezone = data[index].timezone;
                     var weekDay = data[index].week_day;
                     var availableAt = data[index].available_at;
                     var availableUntil = data[index].available_until;
                     return AnimationConfiguration.staggeredList(
                       position: index,
                       duration: const Duration(milliseconds: 375),
                       child: SlideAnimation(
                         verticalOffset: 50.0,
                         child: FadeInAnimation(
                           child:  ListTile(

                             title: Text("$name",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w500,
                                   fontSize: 20,
                                 )),
                             subtitle: Text("Day of Week : $weekDay \n, Available from : $availableAt \n Available Until: $availableUntil"),
                             leading: Icon(
                               Icons.account_circle,
                               color: Colors.blue[500],
                             ),
                             onTap: () async {

                               Navigator.push(
                                 context,

                                 MaterialPageRoute(

                                   builder: (context) => AppointmentDetail(),
                                   // Pass the arguments as part of the RouteSettings. The
                                   // DetailScreen reads the arguments from these settings.
                                   settings: RouteSettings(
                                     arguments: data[index],
                                   ),
                                 ),
                               );

                             },

                           ),
                         ),
                       ),
                     );
                   }),
             );
           } else if (snapshot.hasError) {
             return Text("${snapshot.error}");
           }
           return Center(child: CircularProgressIndicator());
         },
       ),
     );
   }
 }
