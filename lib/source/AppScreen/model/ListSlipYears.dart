class ListSlipYears {
  String id;
  String month;
  String year;

  ListSlipYears({this.id, this.month, this.year});

  factory ListSlipYears.fromJson(Map<String, dynamic> json) {
    return ListSlipYears(
        id: json['id'] as String,
        month: json['month'] as String,
        year: json['year'] as String);
  }
}
