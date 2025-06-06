class Calculation {
  final String expression;
  final String result;
  final DateTime timestamp;

  Calculation({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  // For Hive storage
  Map<String, dynamic> toMap() => {
    'expression': expression,
    'result': result,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Calculation.fromMap(Map<String, dynamic> map) => Calculation(
    expression: map['expression'],
    result: map['result'],
    timestamp: DateTime.parse(map['timestamp']),
  );
}
