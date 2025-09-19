import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/core/core.dart';
import 'package:userapp/widgets/custom_text_field/custom_text_controller.dart';

class CustomTextField<T> extends StatefulWidget {
  const CustomTextField({required this.customTextController, super.key});

  final CustomTextController<T> customTextController;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState<T> extends State<CustomTextField<T>> {
  late final TextEditingController _textEditingController;
  late final CustomTextController<T> _customTextController;

  FocusNode? _focusNode;
  String? _errorText;
  bool _obscureValue = false;

  @override
  void initState() {
    super.initState();

    _customTextController = widget.customTextController;
    _customTextController.state.addListener(_updateState);

    _createTextEditingController();

    if (_customTextController.isAutoFocus) {
      _focusNode = FocusNode();
      _focusNode?.requestFocus();
    }

    if (_customTextController.isObscureText) {
      _obscureValue = true;
    }
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  void _createTextEditingController() {
    final T? initialValue = _customTextController.data.value;
    String? initialText;

    if (initialValue is String) {
      initialText = initialValue;
    }

    if (initialText != null) {
      _customTextController.state.value = UiState.success;
    }

    _textEditingController = TextEditingController(text: initialText);
  }

  void _onChanged(final String value) {
    if (value is T) _customTextController.data.value = value as T?;

    if (!_customTextController.isRequired) {
      _customTextController.state.value = value.isNotEmpty ? UiState.success : UiState.idle;
      return;
    }

    if (value.isEmpty && _customTextController.validateSync == null) {
      _customTextController.state.value = UiState.idle;
      return;
    }

    final String? errorText = _customTextController.validateSync?.call(value);
    log('errorText: $errorText', name: 'CustomTextField');
    _errorText = errorText?.isNotEmpty ?? false ? errorText : null;

    if (errorText == null) {
      _errorText = null;
      _customTextController.state.value = UiState.success;
    } else if (errorText.isEmpty) {
      _errorText = null;
      _customTextController.state.value = UiState.error;
      _updateState();
    } else {
      _customTextController.state.value = UiState.error;
      _updateState();
    }
  }

  List<TextInputFormatter>? get inputFormatters => <TextInputFormatter>[
    // Add allowed RegExp if any
    if (_customTextController.allowedRegExp != null)
      FilteringTextInputFormatter.allow(_customTextController.allowedRegExp!),
  ];

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      /// Label if any
      if (_customTextController.labelText != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            _customTextController.labelText!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),

      /// TextField
      TextField(
        controller: _textEditingController,
        focusNode: _focusNode,
        obscureText: _obscureValue,
        readOnly: _customTextController.isReadOnly,
        keyboardType: _customTextController.keyboardType,
        inputFormatters: inputFormatters,
        minLines: _customTextController.minLines,
        maxLines: _obscureValue ? 1 : _customTextController.maxLines,
        showCursor: !_customTextController.isReadOnly,
        decoration: InputDecoration(
          suffixIcon: _customTextController.isObscureText ? _buildObscureIcon(_obscureValue) : null,
          hintText: _customTextController.hintText,
          errorText: _errorText,
        ),
        onTapOutside: (final event) => FocusManager.instance.primaryFocus?.unfocus(),
        onChanged: _onChanged,
      ),

      /// Subtitle if any
      if (_customTextController.subtitleText != null)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            _customTextController.subtitleText!,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
    ],
  );

  Widget _buildObscureIcon(final bool isObscure) => IconButton(
    icon: isObscure ? const Icon(CupertinoIcons.eye) : const Icon(CupertinoIcons.eye_slash),
    onPressed: () {
      _obscureValue = !_obscureValue;
      _updateState();
    },
  );
}
