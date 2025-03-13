1. Esquema de ejecución desde main() hasta la renderización de la vista de pruebas
Inicialización de la aplicación (main.dart)

Entrada principal: main() inicializa el entorno Flutter

Asegura la inicialización de dependencias con WidgetsFlutterBinding.ensureInitialized()
Configura la orientación a modo retrato
Inicializa servicios singleton con patrón de acceso .single:

LdSecureStorageService.single
LdNetworkService.single
LdDatabaseService.single
LdAuthService.single

Crea la instancia principal LdSabinaApp pasándole un controlador LdSabinaCtrl
Carga preferencias (método asíncrono loadPreferences())
Ejecuta la app con runApp(sabinaApp)

2. Construcción de la aplicación (LdSabinaApp)

3. Configuración de la aplicación: LdSabinaApp.build()

Hereda de LdApp<LdSabinaCtrl>, que es una clase abstracta genérica
Inicializa el controlador de temas LdThemeCtrl.single.init()
Configura ScreenUtilInit para adaptación responsiva (usando iPhone8PlusSize)
Configura GetMaterialApp con:

Modo de tema reactivo con Obx(() => ...) observando ctrl.themeMode.value
Temas claro y oscuro desde LdThemeCtrl.single
Sistema de localización con Tr.single
Rutas definidas en AppRoutes

4. Enrutamiento y creación de la vista de prueba

Inicialización de la ruta: AppRoutes.initialRoute = ThemeTestView.routeName

El sistema de rutas de GetX carga la vista definida como inicial (/theme-test)
Activa ThemeTestBinding.dependencies() que:

Asegura la existencia del controlador de temas LdThemeCtrl.single
Crea un estado ThemeTestViewState para la vista
Crea un controlador ThemeTestViewCtrl asociado al estado
Añade el tag del controlador a los parámetros de Get (Get.parameters[parmElm])

5. Construcción de la vista de prueba (ThemeTestView)

Creación de la vista de prueba: ThemeTestView

Se instancia con un tag que permite obtener el controlador asociado
Hereda de LdView<ThemeTestViewState, ThemeTestViewCtrl>
El método build() implementado en LdView utiliza GetBuilder<C> para crear una vista reactiva a los cambios del controlador

6. Renderización del contenido de la vista

Construcción de la interfaz: ThemeTestViewCtrl.buildView()

Crea un LdScaffoldWidget que contiene:

LdAppBarWidget con título, subtítulo y botón para cambiar tema
Cuerpo con ThemeTestComponents que muestra varias secciones de demostración del tema

7. Componentes de demostración de tema

Renderización de componentes de prueba: ThemeTestComponents

Contiene secciones para mostrar colores, botones, entradas de texto, tarjetas e indicadores de progreso
Cada sección está envuelta en un LdThemeSectionWidget
Todos los widgets están asociados con controladores específicos que heredan de LdWidgetCtrl