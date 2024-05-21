import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_doctor/utils/colors/colormanager.dart';

class Drobdown extends StatefulWidget {
  final List<String> genderItems;

  final String typeText;

  Drobdown({super.key, required this.genderItems,required this.typeText});

  @override
  State<Drobdown> createState() => _DrobdownState();
}

class _DrobdownState extends State<Drobdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(

      
      
      isExpanded: true,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
            borderSide:BorderSide.none, 
          borderRadius: BorderRadius.circular(15),
        
        ),
      ),
      hint:  Text(
        widget.typeText,
        style: TextStyle(fontSize: 14,color: Colormanager.grayText),
        
      ),
      items: widget.genderItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        
        if (value == null) {
          return 'Please select gender';
        }
        return null;
      },
      onChanged: (value) {

        setState(() {
          selectedValue=value;
        });

        print(selectedValue);
        
      },
      onSaved: (value) {
        selectedValue = value.toString();
        
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
