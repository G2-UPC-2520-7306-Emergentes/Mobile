class Batch {
  final String id;
  final String lotName;
  final String farmName;
  final String variety;
  final String harvestDate;
  final String createdDate;
  final String state;
  final String imageUrl;
  final String producerId;

  Batch({
    required this.id,
    required this.lotName,
    required this.farmName,
    required this.variety,
    required this.harvestDate,
    required this.createdDate,
    required this.state,
    required this.imageUrl,
    required this.producerId,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['id'] as String,
      lotName: json['lotName'] as String,
      farmName: json['farmName'] as String,
      variety: json['variety'] as String,
      harvestDate: json['harvestDate'] as String,
      createdDate: json['createdDate'] as String,
      state: json['state'] as String,
      imageUrl: json['imageUrl'] as String,
      producerId: json['producer_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lotName': lotName,
      'farmName': farmName,
      'variety': variety,
      'harvestDate': harvestDate,
      'createdDate': createdDate,
      'state': state,
      'imageUrl': imageUrl,
      'producer_id': producerId,
    };
  }
}