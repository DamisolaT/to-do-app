import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_text.dart';

class CustomBorderedTextFormField extends StatefulWidget {
  final String title;
  final String? subTitle;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool enablePaste;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool readOnly;
  final Color focusedBorder;
  final Color subtitleColor;
  final Color enabledBorder;
  final Color borderColor;
  final Color backgroundColor;
  final GestureTapCallback? onTap;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final int? minLength;
  final TextStyle? hintStyle;
  final bool editableHintText;
  final bool hasSubstitle;
  final bool isEditFeature;
  final List<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool autofocus;

  const CustomBorderedTextFormField({
    super.key,
    required this.title,
    this.subTitle,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
    this.enablePaste = true,
    this.focusedBorder = Colors.transparent,
    this.enabledBorder = Colors.transparent,
    this.borderColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.subtitleColor = Colors.blue,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.validator,
    this.errorText,
    this.initialValue,
    this.maxLines = 1,
    this.maxLength,
    this.minLength,
    this.onSubmitted,
    this.hintStyle,
    this.editableHintText = false,
    this.hasSubstitle = false,
    this.isEditFeature = false,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.autofocus = false,
  });

  @override
  State<CustomBorderedTextFormField> createState() =>
      _CustomBorderedTextFormFieldState();
}

class _CustomBorderedTextFormFieldState
    extends State<CustomBorderedTextFormField> {
  bool _isObscured = true;
  int _characterCount = 0;
  late TextEditingController _controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
      _characterCount = widget.initialValue!.length;
    } else if (widget.editableHintText && widget.hintText != null) {
      _controller.text = widget.hintText!;
    }
  }

  void validateInput(String value) {
    String? errorMessage;
    if (widget.validator != null) {
      errorMessage = widget.validator!(value);
    }
    if (widget.minLength != null && value.length < widget.minLength!) {
      errorMessage = 'Please enter at least ${widget.minLength} characters';
    }
    setState(() {
      errorText = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDescription = widget.title == 'Description';
    final maxLines = isDescription ? 5 : widget.maxLines;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title.isNotEmpty,
            child: CustomText(
              text: widget.title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Visibility(
            visible: widget.hasSubstitle,
            child: CustomText(
              text: widget.subTitle ?? '',
              fontSize: 12,
              color: widget.subtitleColor,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            constraints: BoxConstraints(
              minHeight: isDescription ? 100 : 0,
              maxHeight: isDescription ? 150 : 100,
            ),
            child: TextFormField(
              controller: _controller,
              cursorColor: Colors.grey,
              readOnly: widget.readOnly,
              enableInteractiveSelection: widget.enablePaste,
              onChanged: (value) {
                setState(() {
                  _characterCount = value.length;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
                validateInput(value);
              },
              onFieldSubmitted: (value) {
                setState(() {
                  _characterCount = 0;
                });
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(value);
                }
                if (widget.nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              focusNode: widget.focusNode,
              textAlign: widget.textAlign,
              onTap: () {
                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              inputFormatters: widget.inputFormatters,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText && _isObscured,
              obscuringCharacter: '*',
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              autofocus: widget.autofocus,
              autofillHints: widget.autofillHints,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              maxLines: maxLines,
              maxLength: widget.maxLength,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                hintText: widget.editableHintText ? null : widget.hintText,
                hintStyle:
                    widget.hintStyle ??
                    TextStyle(color: Color.fromRGBO(100, 100, 100, 1)),
                errorText: widget.errorText,
                errorStyle: const TextStyle(
                  color: Color.fromRGBO(196, 196, 196, 1),
                  fontSize: 12,
                ),
                counterText: '',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromRGBO(233, 235, 238, 1),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ), // Full red border
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: widget.prefixIcon,
                suffixIcon:
                    widget.obscureText
                        ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color.fromRGBO(196, 196, 196, 1),
                          ),
                        )
                        : widget.suffixIcon,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
            ),
          ),
          if (widget.maxLength != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$_characterCount/${widget.maxLength}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomDropdownFormField extends StatelessWidget {
  final String title;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.title,
    required this.items,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(.7),
              fontFamily: 'Rubik',
            ),
          ),
          const SizedBox(height: 6),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonFormField(
              value: value,
              items:
                  items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: CustomText(
                        text: item,
                        // fontSize: 12,
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlexibleBorderedTextField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? labelText;
  final String? hintText;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool enablePaste;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool readOnly;
  final Color focusedBorder;
  final Color enabledBorder;
  final Color borderColor;
  final Color backgroundColor;
  final GestureTapCallback? onTap;
  final List<TextInputFormatter> inputFormatters;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final TextStyle? hintStyle;
  final bool editableHintText;

  const FlexibleBorderedTextField({
    super.key,
    required this.title,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.focusNode,
    this.enablePaste = true,
    this.focusedBorder = Colors.transparent,
    this.enabledBorder = Colors.transparent,
    this.borderColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.validator,
    this.errorText,
    this.initialValue,
    this.maxLines = 1,
    this.maxLength,
    this.onSubmitted,
    this.hintStyle,
    this.editableHintText = false,
  });

  @override
  State<FlexibleBorderedTextField> createState() =>
      _FlexibleBorderedTextFieldState();
}

class _FlexibleBorderedTextFieldState extends State<FlexibleBorderedTextField> {
  bool _isObscured = true;
  int _characterCount = 0;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
      _characterCount = widget.initialValue!.length;
    } else if (widget.editableHintText && widget.hintText != null) {
      _controller.text = widget.hintText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xff475569),
              fontFamily: 'Rubik',
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _controller,
            cursorColor: Colors.black,
            readOnly: widget.readOnly,
            enableInteractiveSelection: widget.enablePaste,
            onChanged: (value) {
              setState(() {
                _characterCount = value.length;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onFieldSubmitted: (value) {
              setState(() {
                _characterCount = 0;
              });
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(value);
              }
            },
            focusNode: widget.focusNode,
            textAlign: widget.textAlign,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText && _isObscured,
            obscuringCharacter: '*',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              hintText: widget.editableHintText ? null : widget.hintText,
              hintStyle:
                  widget.hintStyle ?? TextStyle(color: Colors.grey.shade300),
              errorText: widget.errorText,
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
              prefixIcon:
                  widget.prefixIcon != null
                      ? Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          alignment: Alignment.center,
                          child: widget.prefixIcon,
                        ),
                      )
                      : null,
              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        icon: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                      )
                      : widget.suffixIcon,
            ),
          ),
          if (widget.maxLength != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 5),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$_characterCount/${widget.maxLength}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
