// Widget per a l'edició de text d'una línia.
// CreatedAt: 2025/03/13 dj.

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ld_wbench3/core/ld_view.dart';
import 'package:ld_wbench3/core/ld_widget.dart';
import 'package:ld_wbench3/theme/text_styles.dart';

// DEFINICIÓ D'ENUMERACIONS I TIPUS

// Tipus predefinits per a LdEditWidget
enum LdEditType { text, email, password, number, phone, search, url }

final TextScaler _txtScaler = MediaQuery.of(Get.context!).textScaler;

// WIDGET 'LdEditWidget' ==============
class LdEditWidget extends LdWidget<LdEditWidgetCtrl> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdEditWidget";
  static const String widgetTag = "${className}_tag";

  // CONSTRUCTOR ---------------------
  LdEditWidget({
    super.key,
    required LdViewCtrl viewCtrl,
    String? pTag,
    required String label,
    String? placeholder,
    String? helperText,
    String? errorText,
    String? initialValue,
    TextEditingController? controller,
    bool obscureText = true,
    bool enabled = true,
    bool readOnly = false,
    bool autofocus = false,
    bool autocorrect = true,
    LdEditType type = LdEditType.text,
    TextInputAction? textInputAction,
    InputDecoration? decoration,
    Function(String)? onChanged,
    Function(String)? onSubmitted,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
    FocusNode? focusNode,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixIconPressed,
    bool showSuffixClearButton = false,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) : super(pViewCtrl: viewCtrl) {
    tag = pTag ?? "${widgetTag}_${DateTime.now().millisecondsSinceEpoch}";
    typeName = className;
    ctrl = LdEditWidgetCtrl(
      pTag: tag,
      pViewCtrl: viewCtrl,
      label: label,
      placeholder: placeholder,
      helperText: helperText,
      errorText: errorText,
      initialValue: initialValue,
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      autocorrect: autocorrect,
      type: type,
      textInputAction: textInputAction,
      decoration: decoration,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      focusNode: focusNode,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      onSuffixIconPressed: onSuffixIconPressed,
      showSuffixClearButton: showSuffixClearButton,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      textCapitalization: textCapitalization,
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

// CTRL 'LdEditWidgetCtrl' ===========
class LdEditWidgetCtrl extends LdWidgetCtrl {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdEditWidgetCtrl";

  // 🧩 MEMBRES --------------------------
  // Propietats de configuració
  final String label;
  final String? placeholder;
  String? helperText;
  RxString errorText = RxString('');
  final String? initialValue;
  final TextEditingController _textController;
  final bool obscureText;
  final RxBool _isEnabled = true.obs;
  final bool readOnly;
  final bool autofocus;
  final bool autocorrect;
  final LdEditType type;
  final TextInputAction? textInputAction;
  final InputDecoration? decoration;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  FocusNode? _focusNode;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool showSuffixClearButton;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final TextCapitalization textCapitalization;

  // Propietats d'estat
  RxBool isFocused = false.obs;
  RxBool isObscureText = true.obs;
  RxBool isDirty = false.obs;
  RxString text = ''.obs;

  // CONSTRUCTOR -----------------------
  LdEditWidgetCtrl({
    required super.pTag,
    required super.pViewCtrl,
    required this.label,
    this.placeholder,
    this.helperText,
    String? errorText,
    this.initialValue,
    TextEditingController? controller,
    this.obscureText = false,
    bool enabled = true,
    super.pFocusable = true,
    this.readOnly = false,
    this.autofocus = false,
    this.autocorrect = true,
    this.type = LdEditType.text,
    this.textInputAction,
    this.decoration,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLength,
    FocusNode? focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.showSuffixClearButton = false,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.textCapitalization = TextCapitalization.none,
  }) : _textController =
           controller ?? TextEditingController(text: initialValue),
       _focusNode = focusNode {
    _isEnabled.value = enabled;
    if (errorText != null) this.errorText.value = errorText;
    isObscureText.value = obscureText;
    text.value = initialValue ?? '';

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

  // Obtenir el KeyboardType adequat segons el tipus
  TextInputType _getKeyboardType() {
    switch (type) {
      case LdEditType.email:
        return TextInputType.emailAddress;
      case LdEditType.password:
        return TextInputType.visiblePassword;
      case LdEditType.number:
        return TextInputType.number;
      case LdEditType.phone:
        return TextInputType.phone;
      case LdEditType.search:
        return TextInputType.text;
      case LdEditType.url:
        return TextInputType.url;
      case LdEditType.text:
      // default:
      // return TextInputType.text;
    }
    return TextInputType.text;
  }

  // Obtenir la llista de formatadors segons el tipus
  List<TextInputFormatter> _getInputFormatters() {
    List<TextInputFormatter> formatters = inputFormatters?.toList() ?? [];

    // Afegir formatadors específics segons el tipus
    switch (type) {
      case LdEditType.number:
        formatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      case LdEditType.phone:
        formatters.add(FilteringTextInputFormatter.digitsOnly);
        break;
      default:
        break;
    }

    // Afegir limitador de longitud si és necessari
    if (maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(maxLength));
    }

    return formatters;
  }

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

      contentPadding: theme.inputDecorationTheme.contentPadding,
    );

    // Afegir icones si és necessari
    if (prefixIcon != null) {
      baseDecoration = baseDecoration.copyWith(
        prefixIcon: Icon(prefixIcon, color: primaryColor),
      );
    }

    // Suffix icon segons configuració
    Widget? suffixIconWidget;
    if (showSuffixClearButton && text.value.isNotEmpty) {
      suffixIconWidget = IconButton(
        icon: Icon(Icons.clear, color: primaryColor),
        focusNode: FocusNode(skipTraversal: true),
        onPressed: clear,
      );
    } else if (type == LdEditType.password) {
      suffixIconWidget = IconButton(
        icon: Icon(
          isObscureText.value ? Icons.visibility : Icons.visibility_off,
          color: primaryColor,
        ),
        focusNode: FocusNode(skipTraversal: true),
        onPressed: () {
          isObscureText.value = !isObscureText.value;
          update([tag]);
        },
      );
    } else if (suffixIcon != null) {
      suffixIconWidget = IconButton(
        icon: Icon(suffixIcon, color: primaryColor),
        focusNode: FocusNode(skipTraversal: true),
        onPressed: onSuffixIconPressed,
      );
    }

    if (suffixIconWidget != null) {
      baseDecoration = baseDecoration.copyWith(suffixIcon: suffixIconWidget);
    }

    return baseDecoration;
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

    return GetBuilder<LdEditWidgetCtrl>(
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
              keyboardType: _getKeyboardType(),
              textInputAction: textInputAction,
              obscureText:
                  type == LdEditType.password ? isObscureText.value : false,
              enabled: _isEnabled.value && !readOnly,
              readOnly: readOnly,
              autocorrect: autocorrect,
              autofocus: autofocus,
              inputFormatters: _getInputFormatters(),
              textCapitalization: textCapitalization,
              onSubmitted: onSubmitted,
              onChanged: (value) {
                text.value = value;
                if (onChanged != null) onChanged!(value);
              },
            ),
          ),
    );
  }
}
