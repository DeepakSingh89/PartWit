class ProductModel{
String? _img;
String? _date;
String? _name;
int? _id;
int? _price;

ProductModel(this._img, this._date, this._name, this._id, this._price);

  String? get img => _img;

  set img(String? value) {
    _img = value;
  }

String? get date => _date;

int? get price => _price;

  set price(int? value) {
    _price = value;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  set date(String? value) {
    _date = value;
  }
}