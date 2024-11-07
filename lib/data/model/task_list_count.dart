import 'count_dart.dart';
class TaskListCountModel {
  String? status;
  List<Count>? countList;

  TaskListCountModel({this.status, this.countList});

  TaskListCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      countList = <Count>[];
      json['data'].forEach((v) {
        countList!.add(Count.fromJson(v));
      });
    }
  }
}