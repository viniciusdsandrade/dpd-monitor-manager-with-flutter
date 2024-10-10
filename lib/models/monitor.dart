/// Representa um monitor do DPD.
///
/// A classe [Monitor] contém informações básicas sobre um monitor, incluindo
/// seu identificador único, nome e a URL para seu avatar (imagem genérica).
class Monitor {
  /// Identificador único do monitor.
  final int id;

  /// Nome completo do monitor.
  final String name;

  /// URL para a imagem do avatar genérico do monitor.
  ///
  /// Esta imagem é usada para representar o monitor na interface do usuário.
  final String avatarUrl;

  /// Cria uma instância de [Monitor].
  ///
  /// Todas as propriedades são obrigatórias.
  ///
  /// ```dart
  /// Monitor monitor = Monitor(
  ///   id: 1,
  ///   name: 'João Silva',
  ///   avatarUrl: 'https://example.com/avatar.png',
  /// );
  /// ```
  Monitor({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  /// Cria uma instância de [Monitor] a partir de um mapa JSON.
  ///
  /// Este metodo é útil para converter dados recebidos de uma API em um objeto [Monitor].
  ///
  /// ```dart
  /// Map<String, dynamic> json = {
  ///   'id': 1,
  ///   'name': 'João Silva',
  ///   'avatarUrl': 'https://example.com/avatar.png',
  /// };
  /// Monitor monitor = Monitor.fromJson(json);
  /// ```
  factory Monitor.fromJson(Map<String, dynamic> json) {
    return Monitor(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
