import 'package:flutter/material.dart';
import 'package:userapp/core/core.dart';

/// Don't forget to dispose this controller from the screen that uses it.
class CustomTextController<T> {
  CustomTextController._({
    final T? initialValue,
    this.keyboardType,
    this.labelText,
    this.subtitleText,
    this.isDisabled = false,
    this.isReadOnly = false,
    this.isRequired = false,
    this.isObscureText = false,
    this.isAutoFocus = false,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.hintText,
    this.validateSync,
    this.allowedRegExp,
  }) : data = NotifierWrapper<T?>(initialValue),
       state = NotifierWrapper<UiState>(UiState.idle);

  CustomTextController.onlyText({
    final T? initialValue,
    final TextInputType? keyboardType,
    final String? labelText,
    final String? subtitleText,
    final bool isDisabled = false,
    final bool isRequired = false,
    final bool isReadOnly = false,
    final bool isObscureText = false,
    final bool isAutoFocus = false,
    final int? maxLength,
    final int? minLines,
    final int? maxLines,
    final String? hintText,
    final ValidateSync? validateSync,
    final RegExp? allowedRegExp,
  }) : this._(
         initialValue: initialValue,
         keyboardType: keyboardType,
         labelText: labelText,
         subtitleText: subtitleText,
         isDisabled: isDisabled,
         isReadOnly: isReadOnly,
         isRequired: isRequired,
         isObscureText: isObscureText,
         isAutoFocus: isAutoFocus,
         maxLength: maxLength,
         minLines: minLines,
         maxLines: maxLines,
         hintText: hintText,
         validateSync: validateSync,
         allowedRegExp: allowedRegExp,
       );

  //-----Notifiers-----//
  final NotifierWrapper<T?> data;
  final NotifierWrapper<UiState> state;

  //-----TextField Core-----//
  final TextInputType? keyboardType;
  final String? labelText;
  final String? subtitleText;
  final bool isDisabled;
  final bool isReadOnly;
  final bool isRequired;
  final bool isObscureText;
  final bool isAutoFocus;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  //-----Decoration-----//
  final String? hintText;

  //----- Validation -----//
  final ValidateSync? validateSync;
  final RegExp? allowedRegExp;

  void resetData() {
    data.value = null;
    state.value = isRequired ? UiState.error : UiState.idle;
  }

  void dispose() {
    data.dispose();
    state.dispose();
  }
}
