// To parse this JSON data, do
//
//     final result = resultFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
    Result({
        required this.type,
        required this.date,
        required this.time,
        required this.download,
        required this.upload,
    });

    String type;
    String date;
    String time;
    double download;
    double upload;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json["type"],
        date: json["date"],
        time: json["time"],
        download: json["download"].toDouble(),
        upload: json["upload"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
        "time": time,
        "download": download,
        "upload": upload,
    };
}
