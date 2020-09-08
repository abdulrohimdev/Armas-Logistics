class ListMonth{
  String title;
  ListMonth(this.title);

  static List<ListMonth> fetch(){
    return [
      ListMonth('Jan'),
      ListMonth('Jan'),
      ListMonth('Feb'),
      ListMonth('Mar'),
      ListMonth('Apr'),
      ListMonth('Mei'),
      ListMonth('Jun'),
      ListMonth('Jul'),
      ListMonth('Agt'),
      ListMonth('Sep'),
      ListMonth('Oct'),
      ListMonth('Nov'),
      ListMonth('Dec'),
    ];
  }

}