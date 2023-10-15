// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrendingModel {
  final String name;
  final String file;
  final String timestamp;
  TrendingModel({
    required this.name,
    required this.file,
    required this.timestamp,
  });

  TrendingModel copyWith({
    String? name,
    String? file,
    String? timestamp,
  }) {
    return TrendingModel(
      name: name ?? this.name,
      file: file ?? this.file,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'file': file,
      'timestamp': timestamp,
    };
  }

  factory TrendingModel.fromMap(Map<String, dynamic> map) {
    return TrendingModel(
      name: map['name'] as String,
      file: map['file'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrendingModel.fromJson(String source) =>
      TrendingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TrendingModel(name: $name, file: $file, timestamp: $timestamp)';

  @override
  bool operator ==(covariant TrendingModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.file == file &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => name.hashCode ^ file.hashCode ^ timestamp.hashCode;
}
