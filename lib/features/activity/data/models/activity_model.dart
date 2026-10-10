import '../../domain/entities/activity.dart';

class ActivityModel {
  final String activity;
  final String? type;
  final int? participants;

  const ActivityModel({required this.activity, this.type, this.participants});

  // Convert JSON to ActivityModel
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      activity: json['activity'] as String,
      type: json['type'] as String?,
      participants: json['participants'] as int?,
    );
  }

  // Convert ActivityModel to Activity Entity
  Activity toEntity() {
    return Activity(activity: activity, type: type, participants: participants);
  }
}
