import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isObscureText;
  final String obscureCharacter;
  final String hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.obscureCharacter = '•',
    required this.hintText,
    this.contentPadding = const EdgeInsets.all(12), 
    this.validator,
     this.inputFormatter, // Default padding
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      inputFormatters: widget.inputFormatter,

      keyboardType: widget.keyboardType,
      obscureText: widget.isObscureText ? _isObscure : false,
      obscuringCharacter: widget.obscureCharacter,
      style: ralewayMedium.copyWith(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        
        constraints: BoxConstraints(maxHeight: height * 0.065, minWidth: width),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: ralewayMedium.copyWith(color: Colors.grey, fontSize: 14),
      
        
        
        suffix: widget.isObscureText
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  child: Text(
                    'Show', 
                    style: ralewayMedium.copyWith(color: Colors.blue, fontSize: 14),
                  ),
                )
              : null,
              

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}

TextStyle ralewayMedium = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");