import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDropDownButton extends StatefulWidget {
  ProductDropDownButton(
      {Key? key,
      required this.dropDownList,
      required this.selectedValue,
      required this.dropDownButtonTitle,
      required this.dropDownColors})
      : super(key: key);
  String? selectedValue;
  final String dropDownButtonTitle;
  final List<String> dropDownList;
  final Map<dynamic, dynamic> dropDownColors;
  @override
  State<ProductDropDownButton> createState() => _ProductDropDownButtonState();
}

class _ProductDropDownButtonState extends State<ProductDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        dropdownPadding: const EdgeInsets.all(5.0),
        buttonHeight: 40.0,
        isExpanded: true,
        iconSize: 0.0,
        value: widget.selectedValue,
        items: (widget.dropDownColors.isEmpty)
            ? widget.dropDownList.map((String value) {
                return DropdownMenuItem<String>(
                  child: value == widget.selectedValue
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.dropDownButtonTitle,
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'SFPro',
                              ),
                            ),
                            Text(value,
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'SFPro',
                                    fontWeight: FontWeight.w700))
                          ],
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w700),
                          )),
                  value: value,
                );
              }).toList()
            : widget.dropDownList.map((String value) {
                return DropdownMenuItem<String>(
                  child: value == widget.selectedValue
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text(
                                widget.dropDownButtonTitle,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: 'SFPro',
                                ),
                              ),
                              Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: widget.dropDownColors[value],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(6.0)),
                                ),
                              ),
                            ])
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: widget.dropDownColors[value],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6.0)),
                            ),
                          ),
                        ),
                  value: value,
                );
              }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedValue = newValue!;
          });
        },
        itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 15.0),
        buttonDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(color: const Color(0xFFEBEBEB), width: 1.0)),
      ),
    );
  }
}
