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

  // Generate a description based on company name and certifications
  static String _generateDescription(String name, List<String> certifications) {
    final nameLower = name.toLowerCase();
    String baseDescription;

    if (nameLower.contains('acme')) {
      baseDescription = 'Empresa líder en soluciones corporativas con amplia experiencia en el mercado. Comprometida con la excelencia y la innovación continua para satisfacer las necesidades de nuestros clientes.';
    } else if (nameLower.contains('beta')) {
      baseDescription = 'Especialistas en brindar soluciones integrales de negocio. Nos enfocamos en la calidad y seguridad de todos nuestros procesos para garantizar resultados óptimos.';
    } else if (nameLower.contains('globaltech')) {
      baseDescription = 'Empresa de tecnología e innovación dedicada a transformar industrias mediante soluciones digitales avanzadas y desarrollo tecnológico de vanguardia.';
    } else if (nameLower.contains('ecovida')) {
      baseDescription = 'Comprometidos con la producción de alimentos saludables y sostenibles. Trabajamos directamente con productores locales para garantizar la más alta calidad y frescura en cada producto.';
    } else if (nameLower.contains('constructora') || nameLower.contains('águila')) {
      baseDescription = 'Constructora con amplia trayectoria en proyectos de infraestructura y edificación. Nos distinguimos por nuestra responsabilidad, puntualidad y compromiso con la seguridad.';
    } else {
      baseDescription = 'Empresa comprometida con la calidad y trazabilidad de sus productos. Trabajamos bajo los más altos estándares para garantizar la satisfacción de nuestros clientes.';
    }

    if (certifications.isNotEmpty) {
      baseDescription += ' Contamos con certificaciones como ${certifications.join(", ")}.';
    }

    return baseDescription;
  }

  factory EnterpriseDetail.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? '';
    final certifications = (json['certifications'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ?? [];

    // Use description from API if available, otherwise generate one
    final description = json['description'] ?? _generateDescription(name, certifications);

    return EnterpriseDetail(
      id: json['id'] ?? '',
      name: name,
      description: description,
      logoUrl: json['logoUrl'],
      website: json['website'],
      foundationYear: json['foundationYear'],
      country: json['country'],
      certifications: certifications,
    );
  }
}
