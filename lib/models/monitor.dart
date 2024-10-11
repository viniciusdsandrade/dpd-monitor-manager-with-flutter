/// Representa um monitor obtido da Random User API.
class Monitor {
  /// Identificador único do monitor.
  final String id;

  /// Nome completo do monitor.
  final String name;

  /// URL para a imagem do avatar do monitor.
  final String avatarUrl;

  /// Email do monitor.
  final String email;

  /// Cria uma instância de [Monitor].
  Monitor({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.email,
  });

  /// Cria uma instância de [Monitor] a partir de um mapa JSON.
  factory Monitor.fromJson(Map<String, dynamic> json) {
    String firstName = json['name']['first'];
    String lastName = json['name']['last'];
    String name = '$firstName $lastName';
    String avatarUrl = 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}&background=random';

    return Monitor(
      id: json['login']['uuid'],
      name: name,
      avatarUrl: avatarUrl,
      email: json['email'],
    );
  }
}
