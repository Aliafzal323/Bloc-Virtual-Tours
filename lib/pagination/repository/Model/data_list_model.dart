import 'package:common/common.dart';

class ListingsModel {
  final List<DataListModel>? listings;
  final int? total;
  final int? skip;
  final int? limit;

  ListingsModel({
    this.listings,
    this.total,
    this.skip,
    this.limit,
  });

  factory ListingsModel.fromJson(JsonObject json) {
    return ListingsModel(
      total: $cast(json['total']),
      skip: $cast(json['skip']),
      limit: $cast(json['limit']),
      listings: $mapList(
        json['products'],
        (it) => DataListModel.fromJson(it as JsonObject),
      ),
    );
  }
}

class DataListModel {
  final int? id;
  final String? title;
  final double? price;
  final String? thumbnail;

  DataListModel({
    this.id,
    this.title,
    this.price,
    this.thumbnail,
  });

  factory DataListModel.fromJson(JsonObject json) {
    return DataListModel(
      id: $cast(json['id']),
      title: $cast(json['title']),
      price: $cast(json['price']),
      thumbnail: $cast(json['thumbnail']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
    };
  }
}
