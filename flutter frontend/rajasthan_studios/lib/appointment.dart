import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:rajasthan_studios/appointment_booking_screen.dart';
import 'package:rajasthan_studios/model/appointment.dart';

import 'model/coach_list_model.dart';
class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  Future <List<AppointmentModel>> fetchData() async {
    final response =
    await http.get(Uri.parse('https://rajasthanstudio.pythonanywhere.com/coach/appointment/'), headers: {

      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new AppointmentModel.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointment List"),),
      body: FutureBuilder<List<AppointmentModel>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AppointmentModel> data = snapshot.data!;
            return AnimationLimiter(
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var name = data[index].name;
                    var timezone = data[index].timezone;
                    var weekDay = data[index].week_day;
                    var timeInterval = data[index].time_interval;
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child:  ListTile(

                            title: Text("Coach : $name",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                )),
                            subtitle: Text("Day of Week : $weekDay \n Time Slot: $timeInterval"),
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
