class TraceabilityEventResource {
  final String id;
  final String batchId;
  final String eventType;
  final String eventDate;
  final String? actorName;
  final String? enterpriseId;
  final Location? location;
  final String blockchainStatus;
  final String? transactionHash;
  final String? proofImageUrl;
  final String? proofImageHash;
  final String? verificationUrl;

  TraceabilityEventResource({
    required this.id,
    required this.batchId,
    required this.eventType,
    required this.eventDate,
    this.actorName,
    this.enterpriseId,
    this.location,
    required this.blockchainStatus,
    this.transactionHash,
    this.proofImageUrl,
    this.proofImageHash,
    this.verificationUrl,
  });

  factory TraceabilityEventResource.fromJson(Map<String, dynamic> json) {
    return TraceabilityEventResource(
      id: json['id'] ?? '',
      batchId: json['batchId'] ?? '',
      eventType: json['eventType'] ?? '',
      eventDate: json['eventDate'] ?? '',
      actorName: json['actorName'],
      enterpriseId: json['enterpriseId'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      blockchainStatus: json['blockchainStatus'] ?? 'PENDING',
      transactionHash: json['transactionHash'],
      proofImageUrl: json['proofImageUrl'],
      proofImageHash: json['proofImageHash'],
      verificationUrl: json['verificationUrl'],
    );
  }

  // Getters for backward compatibility
  String get eventId => id;
  String? get description => null; // Description is not in the new API
  String? get enterpriseName =>
      enterpriseId; // Mapping enterpriseId to enterpriseName for now
  String? get txHash => transactionHash;
  String? get txUrl => verificationUrl;
}

class Location {
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? city;
  final String? region;
  final String? country;

  Location({
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.region,
    this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      address: json['address'],
      city: json['city'],
      region: json['region'],
      country: json['country'],
    );
  }

  @override
  String toString() {
    if (address != null) return address!;
    if (city != null && country != null) return '$city, $country';
    if (latitude != null && longitude != null) return '$latitude, $longitude';
    return 'Ubicación desconocida';
  }
}
