
import '../../domain/entities/activity.dart';

class ActivityModel {
  final String activity;
  final String? type;
  final int? participants;
  final String? link;

  const ActivityModel({
    required this.activity,
    this.type,
    this.participants,
    this.link,
  });

  // Convert JSON into ActivityModel
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      activity: json['activity'] as String,
      type: json['type'] as String?,
      participants: json['participants'] as int?,
      link: json['link'] as String?,
    );
  }

  // Convert ActivityModel into Activity entity
  Activity toEntity() {
    return Activity(
      activity: activity,
      type: type,
      participants: participants,
      link: link,
    );
  }
}
