// Widget per a l'edició de text multilinea.
// CreatedAt: 2025/03/13 dj.

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/theme/text_styles.dart';

final TextScaler _txtScaler = MediaQuery.of(Get.context!).textScaler;

// WIDGET 'LdTextAreaWidget' ==========
class LdTextAreaWidget extends LdWidget<LdTextAreaWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdTextAreaWidget";
  static const String widgetTag = "${className}_tag";

  // CONSTRUCTOR ---------------------
  LdTextAreaWidget({
    super.key,
    required LdViewCtrl viewCtrl,
    String? pTag,
    required String label,
    String? placeholder,
    String? helperText,
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    bool autocorrect = true,
    InputDecoration? decoration,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    int minLines = 3,
    int maxLines = 5,
    FocusNode? focusNode,
    IconData? prefixIcon,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    TextCapitalization textCapitalization = TextCapitalization.sentences,
    bool expands = false,
    EdgeInsetsGeometry? contentPadding,
    bool showCounter = true,
    bool enableSuggestions = true,
    TextAlign textAlign = TextAlign.start,
  }) : super(pViewCtrl: viewCtrl) {
    tag = pTag ?? "${widgetTag}_${DateTime.now().millisecondsSinceEpoch}";
    typeName = className;
    ctrl = LdTextAreaWidgetCtrl(
      pTag: tag,
      pViewCtrl: viewCtrl,
      label: label,
      placeholder: placeholder,
      helperText: helperText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      autocorrect: autocorrect,
      decoration: decoration,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      prefixIcon: prefixIcon,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      textCapitalization: textCapitalization,
      expands: expands,
      contentPadding: contentPadding,
      showCounter: showCounter,
      enableSuggestions: enableSuggestions,
      textAlign: textAlign,
    );
  }

  // GETTERS I SETTERS ----------------
  String get text => ctrl.text.value;
  set text(String value) => ctrl.setText(value);

  // Mètodes per facilitar l'accés al focus
  void requestFocus() => ctrl.requestFocus();
  void unfocus() => ctrl.unfocus();

  // VALIDACIÓ -----------------------
  void setError(String? errorText) => ctrl.setError(errorText);
  void clearError() => ctrl.clearError();

  // Obtenir el TextEditingController
  TextEditingController get textController => ctrl.textController;
}

// CTRL 'LdTextAreaWidgetCtrl' =======
class LdTextAreaWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdTextAreaWidgetCtrl";

  // 🧩 MEMBRES --------------------------
  // Propietats de configuració
  final String label;
  final String? placeholder;
  String? helperText;
  RxString errorText = RxString('');
  final String? initialValue;
  final TextEditingController _textController;
  final RxBool _isEnabled = true.obs;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int minLines;
  final int maxLines;
  FocusNode? _focusNode;
  final IconData? prefixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final TextCapitalization textCapitalization;
  final bool expands;
  final EdgeInsetsGeometry? contentPadding;
  final bool showCounter;
  final bool enableSuggestions;
  final TextAlign textAlign;

  // Propietats d'estat
  RxBool isFocused = false.obs;
  RxBool isDirty = false.obs;
  RxString text = ''.obs;
  RxInt currentLength = 0.obs;

  // CONSTRUCTOR -----------------------
  LdTextAreaWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required this.label,
    this.placeholder,
    this.helperText,
    String? errorText,
    this.initialValue,
    TextEditingController? controller,
    bool enabled = true,
    super.pFocusable = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.decoration,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLength,
    this.minLines = 3,
    this.maxLines = 5,
    FocusNode? focusNode,
    this.prefixIcon,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.textCapitalization = TextCapitalization.sentences,
    this.expands = false,
    this.contentPadding,
    this.showCounter = true,
    this.enableSuggestions = true,
    this.textAlign = TextAlign.start,
  }) : _textController =
           controller ?? TextEditingController(text: initialValue),
       _focusNode = focusNode {
    _isEnabled.value = enabled;
    if (errorText != null) this.errorText.value = errorText;
    text.value = initialValue ?? '';
    currentLength.value = text.value.length;

    // Configurar el focus node
    _focusNode ??= FocusNode();
    _focusNode!.addListener(_onFocusChange);

    // Configurar el controller
    _textController.addListener(_onTextChanged);
  }

  // GETTERS I SETTERS ----------------
  TextEditingController get textController => _textController;
  FocusNode get focusNode => _focusNode!;

  @override
  bool get isEnabled => _isEnabled.value;
  @override
  set isEnabled(bool value) {
    _isEnabled.value = value;
    update([tag]);
  }

  // MÈTODES --------------------------
  void _onFocusChange() {
    isFocused.value = _focusNode!.hasFocus;
    update([tag]);
  }

  void _onTextChanged() {
    text.value = _textController.text;
    currentLength.value = _textController.text.length;
    isDirty.value = true;

    if (onChanged != null) {
      onChanged!(_textController.text);
    }

    update([tag]);
  }

  void setText(String value) {
    _textController.text = value;
    // No cal cridar update perquè el listener ja ho farà
  }

  void clear() {
    _textController.clear();
  }

  void setError(String? error) {
    errorText.value = error ?? '';
    update([tag]);
  }

  void clearError() {
    errorText.value = '';
    update([tag]);
  }

  void requestFocus() {
    _focusNode!.requestFocus();
  }

  void unfocus() {
    _focusNode!.unfocus();
  }

  // Construir la decoració del camp
  // Construir la decoració del camp
  InputDecoration _buildInputDecoration(BuildContext context) {
    // Si hi ha una decoració personalitzada, la utilitzem
    if (decoration != null) {
      return decoration!;
    }

    final theme = Theme.of(context);
    final primaryColor =
        theme.brightness == Brightness.dark
            ? Colors.lightBlueAccent
            : theme.colorScheme.primary;

    // Construir la decoració base a partir del tema
    InputDecoration baseDecoration = InputDecoration(
      labelText: label,
      hintText: placeholder,
      helperText: helperText,
      errorText: errorText.value.isEmpty ? null : errorText.value,
      filled: true,
      fillColor: backgroundColor ?? theme.inputDecorationTheme.fillColor,

      // Utilitzar les vores definides al tema
      border: theme.inputDecorationTheme.border,
      enabledBorder: theme.inputDecorationTheme.enabledBorder,
      focusedBorder: theme.inputDecorationTheme.focusedBorder,
      errorBorder: theme.inputDecorationTheme.errorBorder,
      focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,

      // Aplicar estils de text consistents amb els botons
      labelStyle: txsInputLabelStyle(pFgColor: primaryColor),

      floatingLabelStyle: theme.inputDecorationTheme.floatingLabelStyle
          ?.copyWith(
            fontSize: _txtScaler.scale(12.0.sp),
            color: primaryColor,
            fontWeight: isFocused.value ? FontWeight.bold : FontWeight.normal,
          ),
      hintStyle: theme.inputDecorationTheme.hintStyle,
      errorStyle: theme.inputDecorationTheme.errorStyle,
      helperStyle: txsInputHelperStyle(
        pFgColor:
            theme.brightness == Brightness.dark
                ? Colors.grey.shade400
                : Colors.grey.shade600,
      ),

      contentPadding: EdgeInsets.symmetric(
        vertical: 15.0.h,
        horizontal: 10.0.w,
      ),
      // contentPadding ?? theme.inputDecorationTheme.contentPadding,
      counterText: showCounter ? null : '',
    );

    // Afegir icones si és necessari
    if (prefixIcon != null) {
      baseDecoration = baseDecoration.copyWith(
        prefixIcon: Icon(prefixIcon, color: primaryColor),
      );
    }

    return baseDecoration;
  }

  // Obtenir la llista de formatadors
  List<TextInputFormatter> getInputFormatters() {
    List<TextInputFormatter> formatters = inputFormatters?.toList() ?? [];

    // Afegir limitador de longitud si és necessari
    if (maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(maxLength));
    }

    return formatters;
  }

  // CICLE DE VIDA --------------------
  @override
  void onClose() {
    _focusNode?.removeListener(_onFocusChange);
    _textController.removeListener(_onTextChanged);

    // Dispose del focus node si l'hem creat internament
    if (_focusNode != null) {
      _focusNode!.dispose();
    }

    super.onClose();
  }

  // 'LdWdiget' -----------------------
  @override
  void rebuildFromScrath() {
    // No hi ha builders a anul·lar.
  }

  @override
  Widget buildWidget(BuildContext pBCtx) {
    final theme = Theme.of(pBCtx);

    return GetBuilder<LdTextAreaWidgetCtrl>(
      id: tag,
      tag: tag,
      init: this,
      builder:
          (ctrl) => SizedBox(
            width: width,
            height: height,
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: _buildInputDecoration(pBCtx),
              style: txsInputTextStyle(
                pFgColor:
                    _isEnabled.value
                        ? (theme.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black87)
                        : theme.disabledColor,
              ),
              keyboardType: TextInputType.multiline,
              enabled: _isEnabled.value && !readOnly,
              readOnly: readOnly,
              autocorrect: autocorrect,
              autofocus: autofocus,
              minLines: expands ? null : minLines,
              maxLines: expands ? null : maxLines,
              expands: expands,
              textCapitalization: textCapitalization,
              inputFormatters: getInputFormatters(),
              textAlign: textAlign,
              enableSuggestions: enableSuggestions,
              onSubmitted: onSubmitted,
              onChanged: (value) {
                text.value = value;
                currentLength.value = value.length;
                if (onChanged != null) onChanged!(value);
              },
            ),
          ),
    );
  }
}
