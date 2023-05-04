// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:stock_management/models/sold_product_model.dart';

enum SaleStatus { pernding, unpaid, completed }

class Sale {
  String name;
  List<SoldProductModel> products;
  late SaleStatus? status;
  String total;
  DateTime dateTimeAdded;
  Sale({
    required this.name,
    required this.products,
    status,
    required this.total,
    required this.dateTimeAdded,
  }) : status = status ?? SaleStatus.pernding;

  Sale copyWith({
    String? name,
    List<SoldProductModel>? products,
    String? total,
    DateTime? dateTimeAdded,
  }) {
    return Sale(
      name: name ?? this.name,
      products: products ?? this.products,
      total: total ?? this.total,
      dateTimeAdded: dateTimeAdded ?? this.dateTimeAdded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'dateTimeAdded': dateTimeAdded.millisecondsSinceEpoch,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map) {
    return Sale(
      name: map['name'] as String,
      products: List<SoldProductModel>.from((map['products'] as List<int>).map<SoldProductModel>((x) => SoldProductModel.fromMap(x as Map<String,dynamic>),),),
      total: map['total'] as String,
      dateTimeAdded: DateTime.fromMillisecondsSinceEpoch(map['dateTimeAdded'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Sale.fromJson(String source) =>
      Sale.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Sale(name: $name, products: $products, total: $total, dateTimeAdded: $dateTimeAdded)';
  }

  @override
  bool operator ==(covariant Sale other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.name == name &&
      listEquals(other.products, products) &&
      other.total == total &&
      other.dateTimeAdded == dateTimeAdded;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      products.hashCode ^
      total.hashCode ^
      dateTimeAdded.hashCode;
  }
}
