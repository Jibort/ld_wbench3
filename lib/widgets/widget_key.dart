// Enumeració de GetBuilder's per a la seva actualització.
// createdAt: 24/07/18 dj. JIQ

// Identificadors constants.
const String scaffoldIdx = "scaffold";
const String appBarIdx = "appBar";
const String appBarProgressIdx = "appBarProgress";
const String pageBodyIdx = "pageBody";
const String bottomBarIdx = "bottomBar";
const String drawerIdx = "drawer";
const String floatingActionButtonIdx = "floatingActionButton";
const String snackbarIdx = "snackbar";
const String dialogIdx = "dialog";
const String bottomSheetIdx = "bottomSheet";
const String cardIdx = "card";
const String listTileIdx = "listTile";
const String chipIdx = "chip";
const String tabBarIdx = "tabBar";
const String tabBarViewIdx = "tabBarView";
const String customIdx = "custom";

// Enumeració de widgets a actualitzar.
enum WidgetKey implements Comparable<WidgetKey> {
  // Widget principal d'una pàgina.
  scaffold(pId: scaffoldIdx, pName: scaffoldIdx),
  // Widget de la barra superior d'una pàgina.
  appBar(pId: appBarIdx, pName: appBarIdx),
  // Widget de la barra superior de progrés.
  appBarProgress(pId: appBarProgressIdx, pName: appBarProgressIdx),
  // Widget del cos d'una pàgina.
  pageBody(pId: pageBodyIdx, pName: pageBodyIdx),
  // Widget de la barra inferior d'una pàgina.
  bottomBar(pId: bottomBarIdx, pName: bottomBarIdx),
  // Widget del menú lateral d'una pàgina.
  drawer(pId: drawerIdx, pName: drawerIdx),
  // Widget del botó flotant d'una pàgina.
  floatingActionButton(
    pId: floatingActionButtonIdx,
    pName: floatingActionButtonIdx,
  ),
  // Widget de la barra inferior d'una pàgina que mostra missatges breus.
  snackbar(pId: snackbarIdx, pName: snackbarIdx),
  // Widget de diàleg modal que mostra informació o demana una decisió a l'usuari.
  dialog(pId: dialogIdx, pName: dialogIdx),
  // Widget que s'obre des de la part inferior de la pantalla i mostra informació o opcions addicionals.
  bottomSheet(pId: bottomSheetIdx, pName: bottomSheetIdx),
  // Widget que mostra informació en un format compacte i visualment atractiu.
  card(pId: cardIdx, pName: cardIdx),
  // Widget que mostra informació en una fila amb un ícone, un títol i una subtítol opcionals.
  listTile(pId: listTileIdx, pName: listTileIdx),
  // Widget que representa una etiqueta o un element seleccionable en una llista o un formulari.
  chip(pId: chipIdx, pName: chipIdx),
  // Widget que permet a l'usuari navegar entre diferents seccions o pàgines d'una aplicació.
  tabBar(pId: tabBarIdx, pName: tabBarIdx),
  // Widget que mostra el contingut associat a una pestanya seleccionada en un TabBar.
  tabBarView(pId: tabBarViewIdx, pName: tabBarViewIdx),

  // Índex de l'entrada a partir de la qual fer widgets custom.
  custom(pId: customIdx, pName: customIdx);

  final String _idx;
  final String _name;

  const WidgetKey({required String pId, required String pName})
    : _idx = pId,
      _name = pName;

  @override
  String toString() => "WidgetKey[$_idx: '$_name']";

  String get idx => _idx;
  String get name => _name;

  @override
  int compareTo(WidgetKey other) => _idx.compareTo(other._idx);
}
