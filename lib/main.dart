import 'package:flutter/material.dart';
import 'screen/monitor_list_screen.dart';

/// Ponto de entrada do aplicativo Flutter.
///
/// A função [main] é a primeira a ser executada quando o aplicativo inicia.
/// Ela invoca o metodo [runApp], que carrega o widget raiz do aplicativo.
void main() {
  runApp(MyApp());
}

/// Widget raiz do aplicativo.
///
/// A classe [MyApp] estende [StatelessWidget], indicando que seu estado
/// não muda ao longo do tempo. Ela configura os temas do aplicativo e define
/// a tela inicial.
class MyApp extends StatelessWidget {
  /// Tema claro do aplicativo.
  ///
  /// Configurações de aparência para o modo claro, incluindo brilho e
  /// cor primária.
  final ThemeData temaClaro = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  /// Tema escuro do aplicativo.
  ///
  /// Configurações de aparência para o modo escuro, incluindo brilho e
  /// cor primária secundária.
  final ThemeData temaEscuro = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
  );

  /// Construtor padrão da classe [MyApp].
  ///
  /// Utiliza o construtor da superclasse [StatelessWidget].
  ///
  /// ```dart
  /// MyApp app = MyApp();
  /// ```
  MyApp({super.key});

  /// Constrói a interface do widget.
  ///
  /// Este metodo retorna um [MaterialApp] configurado com os temas claro e escuro,
  /// a tela inicial [MonitorListScreen], e outras propriedades de configuração.
  ///
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   return MaterialApp(
  ///     // Configurações do aplicativo
  ///   );
  /// }
  /// ```
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Título do aplicativo exibido em locais apropriados, como na
      /// alternância de tarefas do dispositivo.
      title: 'Monitores do DPD',

      /// Tema claro do aplicativo.
      ///
      /// Define as cores e estilos para o modo claro.
      theme: temaClaro,

      /// Tema escuro do aplicativo.
      ///
      /// Define as cores e estilos para o modo escuro.
      darkTheme: temaEscuro,

      /// Modo de tema do aplicativo.
      ///
      /// Define se o aplicativo deve usar o tema claro, escuro ou seguir
      /// a preferência do sistema.
      themeMode: ThemeMode.system,

      /// Tela inicial do aplicativo.
      ///
      /// Define qual widget deve ser exibido quando o aplicativo é iniciado.
      home: MonitorListScreen(),

      /// Remove a bandeira de "debug" exibida no canto superior direito
      /// durante o desenvolvimento.
      debugShowCheckedModeBanner: false,
    );
  }
}
