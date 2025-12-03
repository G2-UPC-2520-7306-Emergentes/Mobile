class EnterpriseDetail {
  final String id;
  final String name;
  final String? description;
  final String? logoUrl;
  final String? website;
  final int? foundationYear;
  final String? country;
  final List<String> certifications;

  EnterpriseDetail({
    required this.id,
    required this.name,
    this.description,
    this.logoUrl,
    this.website,
    this.foundationYear,
    this.country,
    this.certifications = const [],
  });

  factory EnterpriseDetail.fromJson(Map<String, dynamic> json) {
    return EnterpriseDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      logoUrl: json['logoUrl'],
      website: json['website'],
      foundationYear: json['foundationYear'],
      country: json['country'],
      certifications:
          (json['certifications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
