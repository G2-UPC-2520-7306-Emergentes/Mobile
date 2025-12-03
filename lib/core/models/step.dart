enum BlockchainStatus {
  pending,
  confirmed,
  failed,
}

class Step {
  final String id;
  final String lotId;
  final String userId;
  final String stepType;
  final String stepDate;
  final String stepTime;
  final String location;
  final double? latitude;
  final double? longitude;
  final String observations;
  final String hash;
  final BlockchainStatus blockchainStatus;

  Step({
    required this.id,
    required this.lotId,
    required this.userId,
    required this.stepType,
    required this.stepDate,
    required this.stepTime,
    required this.location,
    this.latitude,
    this.longitude,
    required this.observations,
    required this.hash,
    this.blockchainStatus = BlockchainStatus.pending,
  });

  static BlockchainStatus _parseBlockchainStatus(String? status) {
    switch (status?.toUpperCase()) {
      case 'CONFIRMED':
        return BlockchainStatus.confirmed;
      case 'FAILED':
        return BlockchainStatus.failed;
      case 'PENDING':
      default:
        return BlockchainStatus.pending;
    }
  }

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      id: json['id'] as String,
      lotId: json['lotId'] as String,
      userId: json['userId'] as String,
      stepType: json['stepType'] as String,
      stepDate: json['stepDate'] as String,
      stepTime: json['stepTime'] as String,
      location: json['location'] as String,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      observations: json['observations'] as String,
      hash: json['hash'] as String,
      blockchainStatus: _parseBlockchainStatus(json['blockchainStatus'] as String?),
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
      'latitude': latitude,
      'longitude': longitude,
      'observations': observations,
      'hash': hash,
      'blockchainStatus': blockchainStatus.name.toUpperCase(),
    };
  }
}