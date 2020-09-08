class GetAttendance {
  String date;
  String in_plan;
  String out_plan;
  String in_actual;
  String out_actual;

  GetAttendance({this.date, this.in_plan, this.out_plan,this.in_actual,this.out_actual});

  factory GetAttendance.fromJson(Map<String, dynamic> json) {
    return GetAttendance(
        date: json['date'] as String,
        in_plan: json['in_plan'] as String,
        out_plan: json['out_plan'] as String,
        in_actual: json['in_actual'] as String,
        out_actual: json['out_actual'] as String);
  }
}
