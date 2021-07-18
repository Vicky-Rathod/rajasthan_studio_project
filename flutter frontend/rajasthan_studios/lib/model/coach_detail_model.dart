class CoachDetailModel{
  String name;
  String timezone;
  String week_day;
  List time_slot;
  CoachDetailModel({
    required this.name,
    required this.timezone,
    required this.week_day,
    required this.time_slot,

  });

  factory CoachDetailModel.fromJson(Map<String,  dynamic> json){
    return CoachDetailModel(
      name: json['name'],
      timezone: json['timezone'],
      week_day: json['day_of_week'],
      time_slot: json['time_slot'],

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['timezone'] = this.timezone;
    data['day_of_week'] = this.week_day;
    data['time_slot'] = this.time_slot;
    return data;
  }
}