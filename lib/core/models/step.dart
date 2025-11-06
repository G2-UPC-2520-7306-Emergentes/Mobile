class Step {
  final String id;
  final String lotId;
  final String userId;
  final String stepType;
  final String stepDate;
  final String stepTime;
  final String location;
  final String observations;
  final String hash;

  Step({
    required this.id,
    required this.lotId,
    required this.userId,
    required this.stepType,
    required this.stepDate,
    required this.stepTime,
    required this.location,
    required this.observations,
    required this.hash,
  });

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      id: json['id'] as String,
      lotId: json['lotId'] as String,
      userId: json['userId'] as String,
      stepType: json['stepType'] as String,
      stepDate: json['stepDate'] as String,
      stepTime: json['stepTime'] as String,
      location: json['location'] as String,
      observations: json['observations'] as String,
      hash: json['hash'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotId': lotId,
      'userId': userId,
      'stepType': stepType,
      'stepDate': stepDate,
      'stepTime': stepTime,
      'location': location,
      'observations': observations,
      'hash': hash,
    };
  }
}