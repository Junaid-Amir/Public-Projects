import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CountryModel {
  final String name;
  final String file;
  final String flag;
  CountryModel({
    required this.name,
    required this.file,
    required this.flag,
  });

  CountryModel copyWith({
    String? name,
    String? file,
    String? flag,
  }) {
    return CountryModel(
      name: name ?? this.name,
      file: file ?? this.file,
      flag: flag ?? this.flag,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'file': file,
      'flag': flag,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      name: map['name'] as String,
      file: map['file'] as String,
      flag: map['flag'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CountryModel(name: $name, file: $file, flag: $flag)';

  @override
  bool operator ==(covariant CountryModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.file == file && other.flag == flag;
  }

  @override
  int get hashCode => name.hashCode ^ file.hashCode ^ flag.hashCode;
}
