class Monitor {
  final int id;
  final String name;
  final String avatarUrl; // URL para imagem genérica

  Monitor({required this.id, required this.name, required this.avatarUrl});

  factory Monitor.fromJson(Map<String, dynamic> json) {
    return Monitor(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
    );
  }
}
