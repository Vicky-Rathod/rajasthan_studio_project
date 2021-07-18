class CoachModel{
  String name;
  String timezone;
  String week_day;
  String available_at;
  String available_until;

  CoachModel({
    required this.name,
    required this.timezone,
    required this.week_day,
    required this.available_at,
    required this.available_until,

  });

  factory CoachModel.fromJson(Map<String,  dynamic> json){
    return CoachModel(
        name: json['name'],
        timezone: json['timezone'],
        week_day: json['day_of_week'],
        available_at: json['available_at'],
        available_until: json['available_until'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['timezone'] = this.timezone;
    data['day_of_week'] = this.week_day;
    data['available_at'] = this.available_at;
    data['available_until'] = this.available_until;
    return data;
  }
}