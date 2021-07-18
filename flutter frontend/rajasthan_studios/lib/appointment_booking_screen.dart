


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rajasthan_studios/model/coach_detail_model.dart';

import 'package:rajasthan_studios/model/coach_list_model.dart';
import 'package:http/http.dart' as http;
class AppointmentDetail extends StatefulWidget {

  const AppointmentDetail({Key? key}) : super(key: key);

  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  String Name = " ";
  String Day = " ";
  String TimeZone = " " ;
  String dropdownValue = " ";
  String TimeSlot = " ";
  final _FormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final _FormKey = GlobalKey<FormState>();
    final  itemHolder  =  ModalRoute.of(context)!.settings.arguments as CoachModel;
    Name = itemHolder.name;
    Day = itemHolder.week_day;
    TimeZone = itemHolder.timezone.toString();


    Future <List<CoachDetailModel>> fetchSchedule() async {
      var params = {
        "name": "$Name",
        "day": "$Day" ,
      };
      final response =
      await http.post(Uri.parse('https://rajasthanstudio.pythonanywhere.com/coach/coach/'),
          body: json.encode(params),
          headers: {

            "Content-Type": "application/json"
          });


      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        var dataid = jsonResponse[0]['time_slot'][0];
        dropdownValue = dataid;
        return jsonResponse.map((data) => new CoachDetailModel.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected error occured!');
      }
    }
    void _saveForm() async {
      final isValid = _FormKey.currentState!.validate();
      var url = Uri.parse('https://rajasthanstudio.pythonanywhere.com/coach/appointment/');
      print(TimeSlot);
      var response = await http.post(url,
          body: json.encode({
            "coach": itemHolder.name.toString(),
            "timezone": itemHolder.timezone.toString(),
            "day_of_week": itemHolder.week_day.toString(),
            "time_interval": "$TimeSlot",
            "user": 1,
          }),
          headers: {
            "Content-Type": "application/json"
          });

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (!isValid) {
        return;
      }
      _FormKey.currentState!.save();
    }

    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment"),),
      body: FutureBuilder<List<CoachDetailModel>>(
        future: fetchSchedule(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CoachDetailModel> data = snapshot.data!;

            return AnimationLimiter(
              child:  Container(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: _FormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.all( 8.0),
                          child: TextFormField(
                            // controller: _coach,
                            initialValue: itemHolder.name,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Coach",

                                alignLabelWithHint: false,
                                filled: true),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Coach';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          margin: const EdgeInsets.all( 8.0),
                          child: TextFormField(
                            // controller: _timeZone,
                            initialValue: itemHolder.timezone,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "TimeZone",
                                alignLabelWithHint: false,
                                filled: true),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'TimeZone';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 30),
                        Container(
                          margin: const EdgeInsets.all( 8.0),
                          child: TextFormField(
                            // controller: _weekDay,
                            initialValue: itemHolder.week_day,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Week Day",
                                alignLabelWithHint: false,
                                filled: true),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Week Day';
                              }
                              return null;
                            },
                          ),
                        ),
                        Center(
                          child: Text("Time Slot",style: TextStyle(fontSize: 25),),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.all( 8.0),
                            child:
                            DropdownButton<String>(
                              hint: Text('Choose Time Slot'),


                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.deepPurple),

                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  TimeSlot = newValue!;
                                  dropdownValue = newValue;
                                  print(TimeSlot);
                                });
                              },
                              value: dropdownValue,
                              items: <String>[for(var item in data[0].time_slot ) item]
                                  .map<DropdownMenuItem<String>>((String value) {

                                return DropdownMenuItem<String>(
                                  value: value,

                                  child: Text(value),

                                );

                              }).toList(),
                            ),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_FormKey.currentState!.validate()) {
                                _saveForm();
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Processing Data')));
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Submit'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),






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
