# Procediment de creació pel projecte Ld_WBench3

1. Accedir amb línia de comandes al directori on es vol crear el projecte.
* > **cd** _C:\Projectes\ld_workbench_
2. Crear el projecte amb _Flutter_.
- > **flutter** _create ld_wbench3_
3. Compilar i executar l'esquelet.
- > **flutter** _run_
4. Obrir el projecte amb VS Code.
* > **code** .
5. Crea el fitxer de workspace.
* > File > Save Workspace As... >
**"C:\Projectes\ld_workbench\ld_wbench3.code-workspace"**
6. Instal·la _FVM_
* > **cd** ld_wbench3
    > [admin] **setx** _PATH "%PATH%;C:\Users\jibor\AppData\Local\Pub\Cache\bin" /M_
  > **fvm** install 3.29.0
  > **fvm** use 3.29.0
7. Copia les dependències necessàries.
* > 
8. Actualitza les dependències.
* > **flutter** _pub get_
9. Llista de directoris sota '/lib':
 > * **core/**      ⇨ _Classes base i patrons_
 > * **services/**  ⇨ _Serveis d'aplicació_
 > * **theme/**     ⇨ _Configuració de tema_
 > * **tools/**     ⇨ _Utilitats i eines_
 > * **trans/**     ⇨ _Traduccions_
 > * **views/**     ⇨ _Pantalles_
 > * **widgets/**   ⇨ _Components reutilitzables_
 > * **main.dart**  ⇨ _Punt d'entrada_
10. Copia els fitxers base.
>│   ld_sabina_application.dart
│   ld_sabina_controller.dart
│   main.dart
├───core
│       ld_ctrl.dart
│       ld_id_mixin.dart
│       ld_service.dart
│       ld_state.dart
│       ld_view.dart
│       ld_view_ctrl.dart
│       ld_view_state.dart
│       ld_widget.dart
│       ld_widget_ctrl.dart
│       ld_widget_state.dart
├───services
├───theme
│       ld_theme.dart
│       ld_theme_controller.dart
│       text_styles.dart
├───tools
│   │   debug.dart
│   │   fi_fo.dart
│   │   li_fo.dart
│   │   li_fo_map.dart
│   │   load_steps.dart
│   │   null_mang.dart
│   │   patterns.dart
│   └───consts
│           devices.dart
│           ui.dart
├───trans
│       ca.dart
│       en.dart
│       es.dart
│       fr.dart
│       pt.dart
│       tr.dart
├───views
└───widgets