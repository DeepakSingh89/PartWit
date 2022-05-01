import 'package:flutter/material.dart';
import 'package:part_wit/ui/styles/my_images.dart';
import 'package:part_wit/utils/Helpers.dart';


class CustomCheckbox extends StatefulWidget {
  bool value = false;
  CustomCheckbox(this.value);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState(value);
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool value = false;

  _CustomCheckboxState(bool this.value);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      ///CHECKBOX
        onTap: () {
          setState(() {
            value = !value;
          });
        },
        child: Container(
         // decoration: const BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
          child: value
              ? Container(
              padding: const EdgeInsets.all(2.0),
             // decoration: const BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
              child: Image.asset(MyImages.ic_checked,height: 15,
                  fit:BoxFit.fill),
          )
              : Container(
            // decoration: const BoxDecoration(shape: BoxShape.rectangle, color: Colors.white,),
            padding: const EdgeInsets.all(0.0),
            child:  Image.asset(MyImages.ic_unchecked,height: 20,
                fit:BoxFit.fill),
          ),
        ));
  }
}