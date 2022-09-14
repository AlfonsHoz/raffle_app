import 'dart:convert';

class Al {
  bool? pay;
  bool? selected;
  String? name;

  Al({this.pay, this.selected, this.name});

  factory Al.fromMap(Map<String, dynamic> data) => Al(
        pay: data['pay'] as bool?,
        selected: data['selected'] as bool?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'pay': pay,
        'selected': selected,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Al].
  factory Al.fromJson(String data) {
    return Al.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Al] to a JSON string.
  String toJson() => json.encode(toMap());
}
