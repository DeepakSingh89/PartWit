class Model{
  int? _id;
  int? _product_id;
  int? _user_id;
  String? _product_name;
  int? _price;
  DateTime? _date;
  String? _featured_image;


  Model(this._id, this._product_id, this._user_id, this._product_name,
      this._price, this._date, this._featured_image);

  int get id => _id!;

  set id(int? value) {
    _id = value;
  }

  int get product_id => _product_id!;

  String get featured_image => _featured_image!;

  set featured_image(String value) {
    _featured_image = value;
  }


  DateTime get date => _date!;

  set date(DateTime value) {
    _date = value;
  }

  int get price => _price!;

  set price(int value) {
    _price = value;
  }

  String get product_name => _product_name!;

  set product_name(String value) {
    _product_name = value;
  }

  int get user_id => _user_id!;

  set user_id(int value) {
    _user_id = value;
  }

  set product_id(int value) {
    _product_id = value;
  }
}