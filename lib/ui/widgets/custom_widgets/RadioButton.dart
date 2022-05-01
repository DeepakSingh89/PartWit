import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:part_wit/model/FilterModel.dart';
import 'package:part_wit/ui/styles/my_app_theme.dart';
import 'package:part_wit/ui/widgets/text/light_text_body_futura_book16.dart';


class MyListItem extends StatefulWidget {

  List<Brand>? brand;
    MyListItem(this.brand );

  @override
  State<MyListItem> createState() => _MyListItemState(brand);
}

class _MyListItemState extends State<MyListItem> {

  late bool isSelected;
  List<Brand>? brand;
  _MyListItemState(this.brand);

  @override
  void initState() {
    super.initState();
    isSelected = false;
  }
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        if (isSelected) {
          setState(() {
            isSelected = false;
          });
        } else {
          setState(() {
            isSelected = true;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5,  0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children:  [

            LightTextBodyFuturaPTBook16(
              data: 'itemBrandName'.tr,
            ),

            isSelected ?  const Icon(
              Icons.radio_button_off,
              color: MyAppTheme.textPrimary,
            ) :  const Icon(
              Icons.radio_button_checked,
              color: MyAppTheme.textPrimary,
            ),

          ],
        ),
      ),
    );
  }
}


