class FavoritesModel
{
  bool? status;
  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  int? currentPage;
  List <FavoritesData> data=[];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
      json['data'].forEach((element) {
        data.add(FavoritesData.fromJson(element));
      });
    }
}

class FavoritesData {
  int? id;
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }

  }