import 'User.dart';

class Product implements Comparable<Product>{
  String id,
      createdAt,
      updatedAt,
      itemName,
      category,
      subCategory,
      itemImage,
      requestStatus,
      itemCondition,
      expirationDate;

  User user;

  Product({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.itemName,
    this.category,
    this.subCategory,
    this.itemImage,
    this.requestStatus,
    this.itemCondition,
    this.expirationDate,
    this.user,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      itemName: json['itemName'],
      category: json['category'],
      subCategory: json['subCategory'],
      itemImage: json['itemImage'],
      requestStatus: json['requestStatus'],
      expirationDate: json['expirationDate'],
      itemCondition: json['itemCondition'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "itemName": itemName,
      "category": category,
      "subCategory": subCategory,
      "itemImage": itemImage,
      "requestStatus": requestStatus,
      "expirationDate": expirationDate,
      "itemCondition": itemCondition,
      "user": user.toJson()
    };
  }

  @override
  int compareTo(Product other) {
    // TODO: implement compareTo
    
    if (itemName == null && other.itemName != null) {
      return -1;
    } else if (itemName != null && other.itemName == null) {
      return 1;
    }

    return itemName.compareTo(other.itemName);

    throw UnimplementedError();
  }
}
