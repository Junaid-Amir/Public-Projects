// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  final String name;
  final String file;
  final String timestamp;
  CategoryModel({
    required this.name,
    required this.file,
    required this.timestamp,
  });

  CategoryModel copyWith({
    String? name,
    String? file,
    String? timestamp,
  }) {
    return CategoryModel(
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

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] as String,
      file: map['file'] as String,
      timestamp: map['timestamp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(name: $name, file: $file, timestamp: $timestamp)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.file == file &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => name.hashCode ^ file.hashCode ^ timestamp.hashCode;
}
