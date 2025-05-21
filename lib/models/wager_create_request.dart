class WagerCreateRequest {
  final String title;
  final String description;
  final DateTime deadline;
  final double amount;
  final String outcomeA;
  final String outcomeB;
  // Add other required fields based on the API spec

  WagerCreateRequest({
    required this.title,
    required this.description,
    required this.deadline,
    required this.amount,
    required this.outcomeA,
    required this.outcomeB,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'amount': amount,
      'outcomeA': outcomeA,
      'outcomeB': outcomeB,
      // Include other fields
    };
  }
}