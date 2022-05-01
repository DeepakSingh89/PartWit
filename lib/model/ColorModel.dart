class ColorModel{
  String? _id;
  String? _color;
  List<attributes>? _list;


  ColorModel(this._id, this._color, this._list);

  List<attributes>? get list => _list;
  set list(List<attributes>? value) {
    _list = value;
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  String? get color => _color;

  set color(String? value) {
    _color = value;
  }
}

class attributes {
  String? _id;
  String? _title;
  String? _type;
  String? _color;

  String? get id => _id;

  set id(String? value) {
    _id = value;
  }

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  String? get type => _type;

  set type(String? value) {
    _type = value;
  }

  String? get color => _color;

  set color(String? value) {
    _color = value;
  }
}