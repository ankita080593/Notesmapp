import 'dart:convert';

class Note {
  String? Title;
  String? Subtitle;
  String? Date;
  String? Time;

  Note({
    required this.Title,
    required this.Subtitle,
    required this.Date,
    required this.Time,
  });

  Note.fromMap(Map map) // This Function helps to convert our Map into our User Object
      : this.Title = map["Title"],
        this.Subtitle = map["Subtitle"],
        this.Date = map["Date"],
        this.Time = map["Time"];

  Map toMap() {
    // This Function helps to convert our User Object into a Map.
    return {
      "Title": this.Title,
      "Subtitle": this.Subtitle,
      "Date": this.Date,
      "Time": this.Time
    };
  }

  String toJson() => jsonEncode(toMap());
 // factory Note.fromJson(String source) => Note.fromMap(jsonDecode(source) as Map<String, dynamic>);

}
