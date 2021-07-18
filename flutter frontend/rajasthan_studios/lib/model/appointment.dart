class AppointmentModel{
  String name;
  String timezone;
  String week_day;
  String time_interval;


  AppointmentModel({
    required this.name,
    required this.timezone,
    required this.week_day,
    required this.time_interval,


  });

  factory AppointmentModel.fromJson(Map<String,  dynamic> json){
    return AppointmentModel(
      name: json['coach'],
      timezone: json['timezone'],
      week_day: json['day_of_week'],
      time_interval: json['time_interval'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coach'] = this.name;
    data['timezone'] = this.timezone;
    data['day_of_week'] = this.week_day;
    data['time_interval'] = this.time_interval;
    return data;
  }
}