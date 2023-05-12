import 'dart:convert';

class PaymentType {
  final int? id;
  final String name;
  final String acronym;
  final bool enable;

  PaymentType({
    this.id,
    required this.name,
    required this.acronym,
    required this.enable,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'acronym': acronym});
    result.addAll({'enable': enable});

    return result;
  }

  factory PaymentType.fromMap(Map<String, dynamic> map) {
    return PaymentType(
      id: map['id']?.toInt(),
      name: map['name'] ?? '',
      acronym: map['acronym'] ?? '',
      enable: map['enable'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentType.fromJson(String source) =>
      PaymentType.fromMap(json.decode(source));
}
