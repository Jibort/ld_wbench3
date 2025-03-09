// Classe base dels estats de vistes de l'aplicació.
// CreatedAt: 2025/02/15 ds. JIQ

// ignore_for_file: unnecessary_getters_setters

import 'package:ld_wbench3/core/ld_state.dart';
import 'package:ld_wbench3/core/ld_view_ctrl.dart';
import 'package:ld_wbench3/widgets/widget_key.dart';

abstract class LdViewState<
  S extends LdViewState<S, C>,
  C extends LdViewCtrl<C, S>
>
    extends LdState {
  // 🧩 MEMBRES --------------------------
  LoadState _loadState = LoadState.isNew;
  late final C _ctrl;

  bool virgin = true;
  String _title;
  String? _subtitle;
  String? _message;

  // 🛠️ CONSTRUCTORS ---------------------
  LdViewState({
    required String pTitle,
    String? pSubtitle,
    String? pMessage,
    super.pErrorCode,
    super.pErrorMessage,
    super.pException,
  }) : _title = pTitle,
       _subtitle = pSubtitle,
       _message = pMessage;

  // 📥 GETTERS/SETTERS ------------------
  C get ctrl => _ctrl;
  set ctrl(C pCtrl) => _ctrl = pCtrl;

  String get title => _title;
  String? get subtitle => _subtitle;
  void setTitles({required String pTitle, String? pSubtitle}) {
    _title = pTitle;
    _subtitle = pSubtitle;
    ctrl.notify();
  }

  String? get message => _message;
  set message(String? pMessage) {
    _message = pMessage;
    ctrl.notify();
  }

  @override
  setError(String? pErrCode, String? pErrMsg) {
    super.setError(pErrCode, pErrMsg);
    ctrl.notify();
  }

  @override
  set exception(Exception? pException) {
    super.exception = pException;
    ctrl.notify();
  }

  // 'LdState' ------------------------
  @override
  bool get isNew => (_loadState == LoadState.isNew);
  @override
  bool get isPreparing => (_loadState == LoadState.isPreparing);
  @override
  bool get isLoading => (_loadState == LoadState.isLoading);
  @override
  bool get isLoaded => (_loadState == LoadState.isLoaded);
  @override
  bool get isPreparingAgain => (_loadState == LoadState.isPreparingAgain);
  @override
  bool get isLoadingAgain => (_loadState == LoadState.isLoadingAgain);

  // Estableix que la càrrega s'està preparant.
  void setPreparing() {
    _loadState = (virgin) ? LoadState.isPreparing : LoadState.isPreparingAgain;
    ctrl.notify(
      pTgts: [
        WidgetKey.scaffold.idx,
        WidgetKey.appBar.idx,
        WidgetKey.appBarProgress.idx,
        WidgetKey.pageBody.idx,
      ],
    );
  }

  // Estableix que la càrrega s'està executant.
  void setLoading() {
    _loadState = (virgin) ? LoadState.isLoading : LoadState.isLoadingAgain;
    ctrl.notify(
      pTgts: [
        WidgetKey.pageBody.idx,
        WidgetKey.appBar.idx,
        WidgetKey.appBarProgress.idx,
        WidgetKey.pageBody.idx,
      ],
    );
  }

  // Estableix que la càrrega s'ha completat.
  void setLoaded(Exception? pExc) {
    exception = pExc;

    _loadState = LoadState.isLoaded;
    virgin = false;
    ctrl.notify();
  }

  // Estableix que la càrrega s'ha completat amb error.
  void setException(String? pError, String? pErrorMessage, Exception pExc) {
    exception = pExc;
    _loadState = LoadState.isError;
    setError(pError, pErrorMessage);
    ctrl.notify();
  }

  // Reinicia l'estat original de càrrega.
  @override
  void reset() {
    super.reset();
    _loadState = LoadState.isNew;
    virgin = true;
    loadData();
    ctrl.notify();
  }
}
