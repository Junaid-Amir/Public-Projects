import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImageSliderModel {
  final String image;
  ImageSliderModel({
    required this.image,
  });

  ImageSliderModel copyWith({
    String? image,
  }) {
    return ImageSliderModel(
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
    };
  }

  factory ImageSliderModel.fromMap(Map<String, dynamic> map) {
    return ImageSliderModel(
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageSliderModel.fromJson(String source) =>
      ImageSliderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageSliderModel(image: $image)';

  @override
  bool operator ==(covariant ImageSliderModel other) {
    if (identical(this, other)) return true;

    return other.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}
