import '../models/batch.dart';
import '../models/step.dart';
import '../models/user.dart';

class FakeApiService {
  // Datos de batches
  final List<Map<String, dynamic>> _batchesData = [
    {"id": "101", "lotName": "Café Cosecha Fina 2025", "farmName": "Los Andes", "variety": "Arábica", "harvestDate": "2025-11-15", "createdDate": "2025-10-01T08:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/cafe_arabica.jpg", "producer_id": "8"},
    {"id": "102", "lotName": "Maíz Amarillo Lote A", "farmName": "Milpa Fértil", "variety": "Hybrid", "harvestDate": "2026-02-10", "createdDate": "2025-10-05T10:30:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/maiz_amarillo.jpg", "producer_id": "8"},
    {"id": "103", "lotName": "Aguacate Hass Export", "farmName": "Hassland", "variety": "Hass", "harvestDate": "2025-12-01", "createdDate": "2025-10-10T15:45:00Z", "state": "Cerrado", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/aguacate_hass.jpg", "producer_id": "1"},
    {"id": "104", "lotName": "Tomate Cherry Invernadero", "farmName": "Red Ruby", "variety": "Cherry", "harvestDate": "2025-11-20", "createdDate": "2025-10-15T11:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/tomate_cherry.jpg", "producer_id": "8"},
    {"id": "105", "lotName": "Fresa Orgánica 2025", "farmName": "Berry Farm", "variety": "Camarosa", "harvestDate": "2025-11-05", "createdDate": "2025-10-20T14:30:00Z", "state": "Cerrado", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/fresa_organica.jpg", "producer_id": "2"},
    {"id": "106", "lotName": "Caña de Azúcar Lote B", "farmName": "Sweet Cane", "variety": "Cristalina", "harvestDate": "2026-01-01", "createdDate": "2025-10-25T09:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/cana_azucar.jpg", "producer_id": "8"},
    {"id": "107", "lotName": "Trigo Duro Panadero", "farmName": "Llanos Verdes", "variety": "Panadero", "harvestDate": "2025-11-25", "createdDate": "2025-10-28T16:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/trigo_panadero.jpg", "producer_id": "3"},
    {"id": "108", "lotName": "Mango Kent 2026", "farmName": "El Trópico", "variety": "Kent", "harvestDate": "2026-03-01", "createdDate": "2025-10-29T11:30:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/mango_kent.jpg", "producer_id": "8"},
    {"id": "109", "lotName": "Papas Nativas Andes", "farmName": "Chacra Huari", "variety": "Huamantanga", "harvestDate": "2025-12-10", "createdDate": "2025-10-30T07:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/papa_nativa.jpg", "producer_id": "1"},
    {"id": "110", "lotName": "Cebolla Roja Grande", "farmName": "Valle Seco", "variety": "Red Onion", "harvestDate": "2026-01-20", "createdDate": "2025-10-30T08:30:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/cebolla_roja.jpg", "producer_id": "2"},
    {"id": "111", "lotName": "Limón Persa Lote C", "farmName": "Citrus Farm", "variety": "Persa", "harvestDate": "2025-11-28", "createdDate": "2025-10-30T09:15:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/limon_persa.jpg", "producer_id": "8"},
    {"id": "112", "lotName": "Quinua Blanca Premium", "farmName": "Altiplano Alto", "variety": "Real", "harvestDate": "2025-12-05", "createdDate": "2025-10-30T10:00:00Z", "state": "Cerrado", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/quinua_blanca.jpg", "producer_id": "3"},
    {"id": "113", "lotName": "Vainas de Cacao", "farmName": "Selva Viva", "variety": "Forastero", "harvestDate": "2025-05-01", "createdDate": "2025-04-15T11:00:00Z", "state": "Cerrado", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/cacao_forastero.jpg", "producer_id": "4"},
    {"id": "114", "lotName": "Zanahoria Baby", "farmName": "Huerto Rápido", "variety": "Nantes", "harvestDate": "2025-12-25", "createdDate": "2025-10-30T12:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/zanahoria_baby.jpg", "producer_id": "8"},
    {"id": "115", "lotName": "Avena Integral", "farmName": "Granos del Sur", "variety": "Blanca", "harvestDate": "2025-11-30", "createdDate": "2025-10-30T13:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/avena_integral.jpg", "producer_id": "1"},
    {"id": "116", "lotName": "Pimientos Rojos California", "farmName": "Campos Color", "variety": "California Wonder", "harvestDate": "2025-11-20", "createdDate": "2025-10-30T14:00:00Z", "state": "Cerrado", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/pimiento_rojo.jpg", "producer_id": "8"},
    {"id": "117", "lotName": "Arroz Jazmín", "farmName": "Delta Verde", "variety": "Jazmín", "harvestDate": "2026-01-01", "createdDate": "2025-10-30T15:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/arroz_jazmin.jpg", "producer_id": "8"},
    {"id": "118", "lotName": "Durazno Piel Roja", "farmName": "Frutales del Sol", "variety": "Piel Roja", "harvestDate": "2025-12-10", "createdDate": "2025-10-30T16:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/durazno_rojo.jpg", "producer_id": "8"},
    {"id": "119", "lotName": "Aceite de Oliva Extra Virgen", "farmName": "Olivares Sur", "variety": "Picual", "harvestDate": "2025-12-15", "createdDate": "2025-10-30T17:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/aceite_oliva.jpg", "producer_id": "8"},
    {"id": "120", "lotName": "Plátano Bellaco Orgánico", "farmName": "La Palmera", "variety": "Bellaco", "harvestDate": "2025-11-20", "createdDate": "2025-10-30T18:00:00Z", "state": "Cerrado", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/platano_bellaco.jpg", "producer_id": "8"},
    {"id": "121", "lotName": "Espárragos Verdes Export", "farmName": "Valle Verde Premium", "variety": "UC-157", "harvestDate": "2025-09-15", "createdDate": "2025-08-01T07:00:00Z", "state": "Activo", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/esparragos.jpg", "producer_id": "1"},
    {"id": "122", "lotName": "Uvas Red Globe Premium", "farmName": "Viñedos del Sol", "variety": "Red Globe", "harvestDate": "2025-10-20", "createdDate": "2025-09-01T08:00:00Z", "state": "Activo", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/uvas_red_globe.jpg", "producer_id": "2"},
    {"id": "123", "lotName": "Arándanos Orgánicos", "farmName": "Berry Farms International", "variety": "Biloxi", "harvestDate": "2025-08-25", "createdDate": "2025-07-15T06:30:00Z", "state": "Activo", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/arandanos.jpg", "producer_id": "4"},
    {"id": "124", "lotName": "Palta Hass Primera", "farmName": "Agroexport SAC", "variety": "Hass", "harvestDate": "2025-10-05", "createdDate": "2025-09-10T09:00:00Z", "state": "Activo", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/palta_hass.jpg", "producer_id": "1"},
    {"id": "125", "lotName": "Brócoli Premium", "farmName": "Verduras Selectas", "variety": "Calabrese", "harvestDate": "2025-11-02", "createdDate": "2025-10-15T10:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/brocoli.jpg", "producer_id": "3"},
    {"id": "126", "lotName": "Lechugas Hidropónicas", "farmName": "Hydrotech Farms", "variety": "Romana", "harvestDate": "2025-11-08", "createdDate": "2025-10-25T08:00:00Z", "state": "Draft", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/lechuga_hidropo.jpg", "producer_id": "8"},
    {"id": "127", "lotName": "Naranjas Valencia", "farmName": "Citrus Premium SAC", "variety": "Valencia", "harvestDate": "2025-10-30", "createdDate": "2025-09-20T07:30:00Z", "state": "Activo", "imageUrl": "https://res.cloudinary.com/dwrfcod77/image/upload/v1699032145/naranja_valencia.jpg", "producer_id": "2"}
  ];

  // Datos de usuarios
  final List<Map<String, dynamic>> _usersData = [
    {"firstName": "Juan", "lastName": "Perez", "email": "juan.perez@finca.com", "companyName": "Finca Los Andes", "taxId": "FND12345", "companyOption": "create", "phoneNumber": "19568654", "password": "productor123", "requestedRole": "Producer", "id": "1"},
    {"firstName": "Maria", "lastName": "Gomez", "email": "maria.gomez@empacadora.com", "companyName": "Empacadora Delta", "taxId": "EMP67890", "companyOption": "join", "password": "procesador123", "phoneNumber": "19568654", "requestedRole": "Processor", "id": "2"},
    {"firstName": "Ricardo", "lastName": "Flores", "email": "ricardo.flores@control.com", "companyName": "Control Certificado", "taxId": "CTRL11223", "phoneNumber": "19568654", "companyOption": "join", "password": "auditor123", "requestedRole": "Processor", "id": "3"},
    {"firstName": "Elena", "lastName": "Soto", "email": "elena.soto@global.com", "companyName": "Admin Global", "taxId": "ADM00001", "companyOption": "create", "password": "admin123", "phoneNumber": "19568654", "requestedRole": "Administrator", "id": "4"},
    {"firstName": "Luis", "lastName": "García", "email": "luis@admin.com", "companyName": "Finca Los Andes", "taxId": "FND12345", "companyOption": "join", "password": "pass", "phoneNumber": "987654321", "requestedRole": "Administrator", "id": "5"},
    {"firstName": "Ana", "lastName": "Diaz", "email": "ana@admin.com", "companyName": "Finca Los Andes", "taxId": "FND12345", "companyOption": "join", "password": "pass", "phoneNumber": "999888777", "requestedRole": "Producer", "id": "6"},
    {"firstName": "Carlos", "lastName": "Mendoza", "email": "carlos.mendoza@foodchain.com", "companyName": "Empacadora Delta", "phoneNumber": "+51 555 123 789", "requestedRole": "Processor", "password": "admin1", "companyOption": "join", "taxId": "EMP67890", "id": "7"},
    {"firstName": "Angelo", "lastName": "Curi", "email": "angelo.curi@test.com", "companyName": "Los Mas Chingones", "taxId": "7875", "companyOption": "create", "password": "123456789", "phoneNumber": "975149459", "requestedRole": "Administrator", "id": "8"},
    {"firstName": "Sofia", "lastName": "Reyes", "email": "sofia.reyes@lmchingones.com", "companyName": "Los Mas Chingones", "taxId": "7875", "companyOption": "join", "password": "password", "phoneNumber": "912345678", "requestedRole": "Processor", "id": "9"},
    {"firstName": "Raul", "lastName": "Vargas", "email": "raul.vargas@lmchingones.com", "companyName": "Los Mas Chingones", "taxId": "7875", "companyOption": "join", "password": "password", "phoneNumber": "955443322", "requestedRole": "Producer", "id": "10"},
    {"firstName": "Miguel", "lastName": "Torres", "email": "miguel.torres@transport.com", "companyName": "Transportes Rápidos SAC", "taxId": "TRANS001", "companyOption": "create", "password": "transport123", "phoneNumber": "987123456", "requestedRole": "Transporter", "id": "11"},
    {"firstName": "Patricia", "lastName": "Quispe", "email": "patricia.q@empacadora.com", "companyName": "Empacadora Delta", "taxId": "EMP67890", "companyOption": "join", "password": "processor123", "phoneNumber": "912334455", "requestedRole": "Processor", "id": "12"},
    {"firstName": "Roberto", "lastName": "Sanchez", "email": "roberto.s@distribuidora.com", "companyName": "Distribuidora Nacional", "taxId": "DIST2025", "companyOption": "create", "password": "distrib123", "phoneNumber": "998877665", "requestedRole": "Distributor", "id": "13"},
    {"firstName": "Carmen", "lastName": "Rojas", "email": "carmen.rojas@retail.com", "companyName": "Supermercados Unidos", "taxId": "RETAIL99", "companyOption": "create", "password": "retail123", "phoneNumber": "955667788", "requestedRole": "Retailer", "id": "14"},
    {"firstName": "Fernando", "lastName": "Castro", "email": "fernando.c@transportes.com", "companyName": "Transportes Rápidos SAC", "taxId": "TRANS001", "companyOption": "join", "password": "transport456", "phoneNumber": "923456789", "requestedRole": "Transporter", "id": "15"},
    {"firstName": "Daniela", "lastName": "Vega", "email": "daniela.v@finca.com", "companyName": "Finca Los Andes", "taxId": "FND12345", "companyOption": "join", "password": "worker123", "phoneNumber": "934567890", "requestedRole": "Producer", "id": "16"},
    {"firstName": "Jorge", "lastName": "Ramirez", "email": "jorge.r@empaque.com", "companyName": "Empacadora Delta", "taxId": "EMP67890", "companyOption": "join", "password": "pack123", "phoneNumber": "945678901", "requestedRole": "Processor", "id": "17"},
    {"firstName": "Isabel", "lastName": "Morales", "email": "isabel.m@distribuidora.com", "companyName": "Distribuidora Nacional", "taxId": "DIST2025", "companyOption": "join", "password": "distrib456", "phoneNumber": "956789012", "requestedRole": "Distributor", "id": "18"},
    {"firstName": "Pedro", "lastName": "Alvarez", "email": "pedro.a@retail.com", "companyName": "Supermercados Unidos", "taxId": "RETAIL99", "companyOption": "join", "password": "retail456", "phoneNumber": "967890123", "requestedRole": "Retailer", "id": "19"},
    {"firstName": "Lucia", "lastName": "Fernandez", "email": "lucia.f@transport.com", "companyName": "Transportes Rápidos SAC", "taxId": "TRANS001", "companyOption": "join", "password": "driver123", "phoneNumber": "978901234", "requestedRole": "Transporter", "id": "20"}
  ];

  // Datos de pasos
  final List<Map<String, dynamic>> _stepsData = [
    {"id": "1", "lotId": "103", "userId": "1", "stepType": "Siembra", "stepDate": "2025-09-01", "stepTime": "07:00", "location": "-12.0464, -77.0428", "observations": "Inicio de plantación de aguacate Hass. Suelo preparado con compost orgánico.", "hash": "0x7a4f9e2b8d1c3e5a6f8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f"},
    {"id": "2", "lotId": "103", "userId": "16", "stepType": "Riego", "stepDate": "2025-09-10", "stepTime": "06:30", "location": "-12.0464, -77.0428", "observations": "Sistema de riego por goteo instalado. Consumo: 20L por árbol.", "hash": "0x8b5g0f3c9e2d4f6a7g9c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f"},
    {"id": "3", "lotId": "103", "userId": "15", "stepType": "Inspección", "stepDate": "2025-09-20", "stepTime": "10:00", "location": "-12.0464, -77.0428", "observations": "Inspección fitosanitaria aprobada. No se detectaron plagas.", "hash": "0x9c6h1g4d0f3e5g7a8h0c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f"},
    {"id": "4", "lotId": "103", "userId": "1", "stepType": "Fertilización", "stepDate": "2025-10-01", "stepTime": "08:00", "location": "-12.0464, -77.0428", "observations": "Aplicación de fertilizante NPK 10-10-10. Dosis: 200g por planta.", "hash": "0xad7i2h5e1g4f6h8a9i1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "5", "lotId": "103", "userId": "16", "stepType": "Poda", "stepDate": "2025-10-15", "stepTime": "07:30", "location": "-12.0464, -77.0428", "observations": "Poda de formación realizada. Eliminadas ramas improductivas.", "hash": "0xbe8j3i6f2h5g7i9a0j2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "6", "lotId": "103", "userId": "15", "stepType": "Inspección", "stepDate": "2025-10-25", "stepTime": "11:00", "location": "-12.0464, -77.0428", "observations": "Control de calidad: 95% de frutos en estado óptimo.", "hash": "0xcf9k4j7g3i6h8j0a1k3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "7", "lotId": "103", "userId": "1", "stepType": "Cosecha", "stepDate": "2025-11-01", "stepTime": "06:00", "location": "-12.0464, -77.0428", "observations": "Cosecha manual realizada. Total: 2500 kg. Calidad premium.", "hash": "0xd0al5k8h4j7i9k1a2l4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "8", "lotId": "103", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-11-02", "stepTime": "08:00", "location": "-12.0612, -77.0354", "observations": "Lavado y selección. Clasificación por calibre. Descartado: 5%.", "hash": "0xe1bm6l9i5k8j0l2a3m5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "9", "lotId": "103", "userId": "17", "stepType": "Empaque", "stepDate": "2025-11-03", "stepTime": "09:00", "location": "-12.0612, -77.0354", "observations": "Empaque en cajas de 10kg. Total: 238 cajas. Etiquetado con código QR.", "hash": "0xf2cn7m0j6l9k1m3a4n6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "10", "lotId": "103", "userId": "18", "stepType": "Inspección", "stepDate": "2025-11-04", "stepTime": "10:00", "location": "-12.0612, -77.0354", "observations": "Certificación orgánica aprobada. Cumple normas internacionales.", "hash": "0x03do8n1k7m0l2n4a5o7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "11", "lotId": "103", "userId": "11", "stepType": "Transporte", "stepDate": "2025-11-05", "stepTime": "14:00", "location": "-12.0612, -77.0354", "observations": "Salida de planta procesadora. Transporte refrigerado a 4°C.", "hash": "0x14ep9o2l8n1m3o5a6p8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "12", "lotId": "103", "userId": "11", "stepType": "Transporte", "stepDate": "2025-11-06", "stepTime": "10:00", "location": "-12.0897, -77.0501", "observations": "En tránsito hacia centro de distribución. Temperatura controlada.", "hash": "0x25fq0p3m9o2n4p6a7q9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "13", "lotId": "103", "userId": "13", "stepType": "Almacenamiento", "stepDate": "2025-11-07", "stepTime": "08:00", "location": "-12.1023, -77.0387", "observations": "Recepción en centro de distribución. Almacenado en cámara fría.", "hash": "0x36gr1q4n0p3o5q7a8r0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "14", "lotId": "103", "userId": "14", "stepType": "Distribución", "stepDate": "2025-11-08", "stepTime": "06:00", "location": "-12.1156, -77.0209", "observations": "Entregado a punto de venta. Producto disponible para consumidor final.", "hash": "0x47hs2r5o1q4p6r8a9s1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "15", "lotId": "105", "userId": "2", "stepType": "Siembra", "stepDate": "2025-09-15", "stepTime": "07:00", "location": "-12.2156, -76.9847", "observations": "Plantación de fresa variedad Camarosa. Sustrato orgánico preparado.", "hash": "0x58it3s6p2r5q7s9a0t2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "16", "lotId": "105", "userId": "2", "stepType": "Riego", "stepDate": "2025-09-20", "stepTime": "06:00", "location": "-12.2156, -76.9847", "observations": "Riego por goteo automatizado. pH del agua: 6.5.", "hash": "0x69ju4t7q3s6r8t0a1u3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "17", "lotId": "105", "userId": "7", "stepType": "Fertilización", "stepDate": "2025-10-01", "stepTime": "08:00", "location": "-12.2156, -76.9847", "observations": "Fertilizante orgánico aplicado. Compost enriquecido con humus.", "hash": "0x7akv5u8r4t7s9u1a2v4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "18", "lotId": "105", "userId": "3", "stepType": "Inspección", "stepDate": "2025-10-10", "stepTime": "09:00", "location": "-12.2156, -76.9847", "observations": "Control de plagas. Aplicación de bioinsecticida preventivo.", "hash": "0x8blw6v9s5u8t0v2a3w5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "19", "lotId": "105", "userId": "2", "stepType": "Cosecha", "stepDate": "2025-11-05", "stepTime": "05:30", "location": "-12.2156, -76.9847", "observations": "Cosecha manual en punto óptimo de maduración. 1800 kg recolectados.", "hash": "0x9cmx7w0t6v9u1w3a4x6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "20", "lotId": "105", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-11-05", "stepTime": "10:00", "location": "-12.2201, -76.9792", "observations": "Clasificación y empaque inmediato. Cadena de frío mantenida.", "hash": "0x0dny8x1u7w0v2x4a5y7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "21", "lotId": "105", "userId": "17", "stepType": "Empaque", "stepDate": "2025-11-05", "stepTime": "12:00", "location": "-12.2201, -76.9792", "observations": "Empacado en bandejas de 250g. Total: 7200 unidades selladas.", "hash": "0x1eoz9y2v8x1w3y5a6z8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "22", "lotId": "105", "userId": "11", "stepType": "Transporte", "stepDate": "2025-11-06", "stepTime": "05:00", "location": "-12.2201, -76.9792", "observations": "Transporte refrigerado iniciado. Temperatura: 2°C.", "hash": "0x2fp0az3w9y2x4z6a7a9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "23", "lotId": "105", "userId": "13", "stepType": "Distribución", "stepDate": "2025-11-07", "stepTime": "07:00", "location": "-12.0897, -77.0501", "observations": "Llegada a centro de distribución. Lote cerrado y disponible.", "hash": "0x3gq1b0a4x0z3y5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "24", "lotId": "112", "userId": "3", "stepType": "Siembra", "stepDate": "2025-08-20", "stepTime": "06:00", "location": "-13.5319, -71.9675", "observations": "Siembra de quinua en altiplano. Preparación de surcos tradicionales.", "hash": "0x4hr2c1b5y1a4z6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "25", "lotId": "112", "userId": "3", "stepType": "Riego", "stepDate": "2025-09-05", "stepTime": "07:00", "location": "-13.5319, -71.9675", "observations": "Riego por gravedad. Aprovechamiento de agua de deshielo.", "hash": "0x5is3d2c6z2b5a7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "26", "lotId": "112", "userId": "15", "stepType": "Inspección", "stepDate": "2025-09-20", "stepTime": "10:00", "location": "-13.5319, -71.9675", "observations": "Verificación de crecimiento. Altura promedio: 45cm. Sin plagas.", "hash": "0x6jt4e3d7a3c6b8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "27", "lotId": "112", "userId": "3", "stepType": "Fertilización", "stepDate": "2025-10-01", "stepTime": "08:00", "location": "-13.5319, -71.9675", "observations": "Fertilización natural con guano de alpaca. Método ancestral.", "hash": "0x7ku5f4e8b4d7c9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "28", "lotId": "112", "userId": "3", "stepType": "Cosecha", "stepDate": "2025-11-15", "stepTime": "07:00", "location": "-13.5319, -71.9675", "observations": "Cosecha manual tradicional. Grano blanco de calidad premium. 3500 kg.", "hash": "0x8lv6g5f9c5e8d0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "29", "lotId": "112", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-11-16", "stepTime": "08:00", "location": "-13.5256, -71.9702", "observations": "Desaponificado y lavado. Secado solar en tendales.", "hash": "0x9mw7h6g0d6f9e1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "30", "lotId": "112", "userId": "17", "stepType": "Empaque", "stepDate": "2025-11-18", "stepTime": "09:00", "location": "-13.5256, -71.9702", "observations": "Envasado en sacos de 25kg. Sellado hermético. Total: 140 sacos.", "hash": "0x0nx8i7h1e7g0f2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "31", "lotId": "112", "userId": "18", "stepType": "Inspección", "stepDate": "2025-11-20", "stepTime": "10:00", "location": "-13.5256, -71.9702", "observations": "Certificación de comercio justo aprobada. Análisis de laboratorio OK.", "hash": "0x1oy9j8i2f8h1g3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "32", "lotId": "112", "userId": "11", "stepType": "Transporte", "stepDate": "2025-11-22", "stepTime": "06:00", "location": "-13.5256, -71.9702", "observations": "Carga para exportación. Destino: puerto del Callao.", "hash": "0x2pz0k9j3g9i2h4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "33", "lotId": "112", "userId": "13", "stepType": "Distribución", "stepDate": "2025-11-25", "stepTime": "14:00", "location": "-12.0464, -77.1428", "observations": "Llegada a almacén de exportación. Lote listo para embarque internacional.", "hash": "0x3qa1l0k4h0j3i5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "34", "lotId": "113", "userId": "4", "stepType": "Siembra", "stepDate": "2025-03-10", "stepTime": "07:00", "location": "-9.5280, -77.5281", "observations": "Plantación de cacao en sistema agroforestal. Sombra natural.", "hash": "0x4rb2m1l5i1k4j6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "35", "lotId": "113", "userId": "4", "stepType": "Riego", "stepDate": "2025-03-20", "stepTime": "06:30", "location": "-9.5280, -77.5281", "observations": "Aprovechamiento de lluvias naturales. Microclima húmedo ideal.", "hash": "0x5sc3n2m6j2l5k7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "36", "lotId": "113", "userId": "3", "stepType": "Fertilización", "stepDate": "2025-04-01", "stepTime": "08:00", "location": "-9.5280, -77.5281", "observations": "Materia orgánica del bosque. Fertilización natural sostenible.", "hash": "0x6td4o3n7k3m6l8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "37", "lotId": "113", "userId": "3", "stepType": "Poda", "stepDate": "2025-04-10", "stepTime": "07:30", "location": "-9.5280, -77.5281", "observations": "Poda sanitaria realizada. Ventilación mejorada en plantación.", "hash": "0x7ue5p4o8l4n7m9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "38", "lotId": "113", "userId": "4", "stepType": "Cosecha", "stepDate": "2025-05-01", "stepTime": "06:00", "location": "-9.5280, -77.5281", "observations": "Cosecha manual de mazorcas maduras. Color amarillo-naranja óptimo. 2200 kg.", "hash": "0x8vf6q5p9m5o8n0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "39", "lotId": "113", "userId": "4", "stepType": "Procesamiento", "stepDate": "2025-05-02", "stepTime": "08:00", "location": "-9.5280, -77.5281", "observations": "Fermentación en cajas de madera. Proceso de 5 días iniciado.", "hash": "0x9wg7r6q0n6p9o1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "40", "lotId": "113", "userId": "4", "stepType": "Procesamiento", "stepDate": "2025-05-07", "stepTime": "10:00", "location": "-9.5280, -77.5281", "observations": "Secado solar completado. Humedad: 7%. Grano listo para empaque.", "hash": "0x0xh8s7r1o7q0p2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "41", "lotId": "113", "userId": "17", "stepType": "Empaque", "stepDate": "2025-05-08", "stepTime": "09:00", "location": "-9.5256, -77.5302", "observations": "Envasado en sacos de yute de 50kg. Total: 44 sacos sellados.", "hash": "0x1yi9t8s2p8r1q3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "42", "lotId": "113", "userId": "18", "stepType": "Inspección", "stepDate": "2025-05-10", "stepTime": "11:00", "location": "-9.5256, -77.5302", "observations": "Certificación orgánica y comercio justo aprobada. Calidad premium.", "hash": "0x2zj0u9t3q9s2r4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "43", "lotId": "113", "userId": "11", "stepType": "Transporte", "stepDate": "2025-05-12", "stepTime": "07:00", "location": "-9.5256, -77.5302", "observations": "Transporte terrestre a Lima. Vehículo con ventilación adecuada.", "hash": "0x3ak1v0u4r0t3s5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "44", "lotId": "113", "userId": "13", "stepType": "Almacenamiento", "stepDate": "2025-05-14", "stepTime": "15:00", "location": "-12.0464, -77.0428", "observations": "Almacenado en bodega seca. Control de temperatura y humedad.", "hash": "0x4bl2w1v5s1u4t6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "45", "lotId": "113", "userId": "13", "stepType": "Distribución", "stepDate": "2025-05-16", "stepTime": "08:00", "location": "-12.0897, -77.0501", "observations": "Distribuido a chocolaterías artesanales. Lote cerrado exitosamente.", "hash": "0x5cm3x2w6t2v5u7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "46", "lotId": "121", "userId": "1", "stepType": "Siembra", "stepDate": "2025-07-01", "stepTime": "06:00", "location": "-13.4189, -76.1317", "observations": "Plantación de espárragos UC-157. Sistema de surcos elevados.", "hash": "0x6dn4y3x7u3w6v8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "47", "lotId": "121", "userId": "16", "stepType": "Riego", "stepDate": "2025-07-10", "stepTime": "05:30", "location": "-13.4189, -76.1317", "observations": "Riego por goteo tecnificado. Fertirrigación programada.", "hash": "0x7eo5z4y8v4x7w9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "48", "lotId": "121", "userId": "1", "stepType": "Fertilización", "stepDate": "2025-07-20", "stepTime": "07:00", "location": "-13.4189, -76.1317", "observations": "Aplicación de NPK vía sistema de riego. Nutrición balanceada.", "hash": "0x8fp6a5z9w5y8x0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "49", "lotId": "121", "userId": "15", "stepType": "Inspección", "stepDate": "2025-08-05", "stepTime": "09:00", "location": "-13.4189, -76.1317", "observations": "Control fitosanitario. Sin presencia de fusarium. Cultivo sano.", "hash": "0x9gq7b6a0x6z9y1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "50", "lotId": "121", "userId": "1", "stepType": "Cosecha", "stepDate": "2025-09-15", "stepTime": "04:00", "location": "-13.4189, -76.1317", "observations": "Cosecha manual nocturna. Turiones de 20-22cm. Calidad export. 4500 kg.", "hash": "0x0hr8c7b1y7a0z2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "51", "lotId": "121", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-09-15", "stepTime": "07:00", "location": "-13.4156, -76.1289", "observations": "Enfriamiento rápido con agua helada. Clasificación automática.", "hash": "0x1is9d8c2z8b1a3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "52", "lotId": "121", "userId": "17", "stepType": "Empaque", "stepDate": "2025-09-15", "stepTime": "10:00", "location": "-13.4156, -76.1289", "observations": "Empaque en cajas de 5kg con atmósfera modificada. 900 cajas.", "hash": "0x2jt0e9d3a9c2b4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "53", "lotId": "121", "userId": "18", "stepType": "Inspección", "stepDate": "2025-09-15", "stepTime": "12:00", "location": "-13.4156, -76.1289", "observations": "Certificación SENASA aprobada. Libre de residuos. Export autorizado.", "hash": "0x3ku1f0e4b0d3c5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "54", "lotId": "121", "userId": "11", "stepType": "Transporte", "stepDate": "2025-09-16", "stepTime": "02:00", "location": "-13.4156, -76.1289", "observations": "Transporte refrigerado a 2°C rumbo al aeropuerto. Carga aérea.", "hash": "0x4lv2g1f5c1e4d6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "55", "lotId": "121", "userId": "13", "stepType": "Distribución", "stepDate": "2025-09-17", "stepTime": "20:00", "location": "-12.0219, -77.1143", "observations": "Exportado vía aérea. Destino: Europa. Lote cerrado exitosamente.", "hash": "0x5mw3h2g6d2f5e7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "56", "lotId": "122", "userId": "2", "stepType": "Poda", "stepDate": "2025-08-15", "stepTime": "07:00", "location": "-14.0678, -75.7289", "observations": "Poda de producción en viñedo. Despunte y raleo de racimos.", "hash": "0x6nx4i3h7e3g6f8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "57", "lotId": "122", "userId": "2", "stepType": "Riego", "stepDate": "2025-08-25", "stepTime": "06:00", "location": "-14.0678, -75.7289", "observations": "Riego por goteo. Estrés hídrico controlado para concentrar azúcares.", "hash": "0x7oy5j4i8f4h7g9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "58", "lotId": "122", "userId": "3", "stepType": "Inspección", "stepDate": "2025-09-10", "stepTime": "10:00", "location": "-14.0678, -75.7289", "observations": "Monitoreo de madurez. Grados Brix: 18°. Color rojo intenso uniforme.", "hash": "0x8pz6k5j9g5i8h0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "59", "lotId": "122", "userId": "7", "stepType": "Fertilización", "stepDate": "2025-09-15", "stepTime": "08:00", "location": "-14.0678, -75.7289", "observations": "Fertilización foliar con potasio. Mejora de color y firmeza.", "hash": "0x9qa7l6k0h6j9i1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "60", "lotId": "122", "userId": "2", "stepType": "Cosecha", "stepDate": "2025-10-20", "stepTime": "06:00", "location": "-14.0678, -75.7289", "observations": "Cosecha manual selectiva. Racimos de 500-600g. Total: 5200 kg.", "hash": "0x0rb8m7l1i7k0j2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "61", "lotId": "122", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-10-20", "stepTime": "10:00", "location": "-14.0645, -75.7256", "observations": "Selección manual. Eliminación de bayas dañadas. Fumigación con SO2.", "hash": "0x1sc9n8m2j8l1k3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "62", "lotId": "122", "userId": "17", "stepType": "Empaque", "stepDate": "2025-10-20", "stepTime": "14:00", "location": "-14.0645, -75.7256", "observations": "Empaque en cajas de 8.2kg con almohadillas. 634 cajas etiquetadas.", "hash": "0x2td0o9n3k9m2l4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "63", "lotId": "122", "userId": "15", "stepType": "Inspección", "stepDate": "2025-10-21", "stepTime": "09:00", "location": "-14.0645, -75.7256", "observations": "Control de calidad: firmeza 8/10, color AAA. Certificado export.", "hash": "0x3ue1p0o4l0n3m5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "64", "lotId": "122", "userId": "11", "stepType": "Transporte", "stepDate": "2025-10-22", "stepTime": "03:00", "location": "-14.0645, -75.7256", "observations": "Carga refrigerada. Temperatura: 0°C. Rumbo a puerto del Callao.", "hash": "0x4vf2q1p5m1o4n6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "65", "lotId": "122", "userId": "13", "stepType": "Almacenamiento", "stepDate": "2025-10-23", "stepTime": "18:00", "location": "-12.0464, -77.1428", "observations": "Almacenado en cámara frigorífica portuaria. Atmósfera controlada.", "hash": "0x5wg3r2q6n2p5o7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "66", "lotId": "122", "userId": "13", "stepType": "Distribución", "stepDate": "2025-10-25", "stepTime": "10:00", "location": "-12.0464, -77.1428", "observations": "Embarcado en contenedor refrigerado. Destino: Asia. Lote cerrado.", "hash": "0x6xh4s3r7o3q6p8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "67", "lotId": "123", "userId": "4", "stepType": "Siembra", "stepDate": "2025-06-20", "stepTime": "07:00", "location": "-12.8956, -74.2145", "observations": "Plantación de arándanos variedad Biloxi. Sistema de macetas elevadas.", "hash": "0x7yi5t4s8p4r7q9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "68", "lotId": "123", "userId": "4", "stepType": "Riego", "stepDate": "2025-07-01", "stepTime": "06:00", "location": "-12.8956, -74.2145", "observations": "Fertirrigación con pH 4.5. Acidificación del sustrato.", "hash": "0x8zj6u5t9q5s8r0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "69", "lotId": "123", "userId": "3", "stepType": "Poda", "stepDate": "2025-07-15", "stepTime": "08:00", "location": "-12.8956, -74.2145", "observations": "Poda de formación. Eliminación de flores tempranas.", "hash": "0x9ak7v6u0r6t9s1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "70", "lotId": "123", "userId": "15", "stepType": "Inspección", "stepDate": "2025-07-30", "stepTime": "10:00", "location": "-12.8956, -74.2145", "observations": "Control de botrytis. Aplicación preventiva de fungicida biológico.", "hash": "0x0bl8w7v1s7u0t2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "71", "lotId": "123", "userId": "4", "stepType": "Fertilización", "stepDate": "2025-08-05", "stepTime": "07:00", "location": "-12.8956, -74.2145", "observations": "Fertilización foliar con micronutrientes. Boro y zinc aplicados.", "hash": "0x1cm9x8w2t8v1u3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "72", "lotId": "123", "userId": "4", "stepType": "Cosecha", "stepDate": "2025-08-25", "stepTime": "05:00", "location": "-12.8956, -74.2145", "observations": "Cosecha manual nocturna. Calibre 16-18mm. Color azul intenso. 2800 kg.", "hash": "0x2dn0y9x3u9w2v4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "73", "lotId": "123", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-08-25", "stepTime": "08:00", "location": "-12.8923, -74.2112", "observations": "Hidroenfriamiento inmediato. Selección electrónica por tamaño.", "hash": "0x3eo1z0y4v0x3w5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "74", "lotId": "123", "userId": "17", "stepType": "Empaque", "stepDate": "2025-08-25", "stepTime": "11:00", "location": "-12.8923, -74.2112", "observations": "Empaque en clamshells de 125g. Atmósfera modificada. 22,400 unidades.", "hash": "0x4fp2a1z5w1y4x6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "75", "lotId": "123", "userId": "18", "stepType": "Inspección", "stepDate": "2025-08-25", "stepTime": "14:00", "location": "-12.8923, -74.2112", "observations": "Certificación orgánica USDA-NOP aprobada. Análisis de residuos negativo.", "hash": "0x5gq3b2a6x2z5y7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "76", "lotId": "123", "userId": "11", "stepType": "Transporte", "stepDate": "2025-08-26", "stepTime": "01:00", "location": "-12.8923, -74.2112", "observations": "Transporte aéreo refrigerado. Temperatura: -0.5°C. Vuelo directo USA.", "hash": "0x6hr4c3b7y3a6z8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "77", "lotId": "123", "userId": "13", "stepType": "Distribución", "stepDate": "2025-08-27", "stepTime": "22:00", "location": "33.9425, -118.4081", "observations": "Llegada a Los Angeles. Distribuido a cadena orgánica. Lote cerrado.", "hash": "0x7is5d4c8z4b7a9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "78", "lotId": "124", "userId": "1", "stepType": "Poda", "stepDate": "2025-08-20", "stepTime": "07:00", "location": "-15.8402, -74.2559", "observations": "Poda de mantenimiento en paltos. Balance vegetativo-productivo.", "hash": "0x8jt6e5d9a5c8b0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "79", "lotId": "124", "userId": "16", "stepType": "Riego", "stepDate": "2025-09-01", "stepTime": "06:00", "location": "-15.8402, -74.2559", "observations": "Riego tecnificado con tensiómetros. Control preciso de humedad.", "hash": "0x9ku7f6e0b6d9c1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "80", "lotId": "124", "userId": "1", "stepType": "Fertilización", "stepDate": "2025-09-10", "stepTime": "08:00", "location": "-15.8402, -74.2559", "observations": "Fertirrigación con nitrógeno y potasio. Engorde de fruto.", "hash": "0x0lv8g7f1c7e0d2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "81", "lotId": "124", "userId": "15", "stepType": "Inspección", "stepDate": "2025-09-20", "stepTime": "10:00", "location": "-15.8402, -74.2559", "observations": "Monitoreo de trips. Control biológico con crisopas liberadas.", "hash": "0x1mw9h8g2d8f1e3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "82", "lotId": "124", "userId": "1", "stepType": "Cosecha", "stepDate": "2025-10-05", "stepTime": "06:00", "location": "-15.8402, -74.2559", "observations": "Cosecha con vara telescópica. Materia seca: 24%. Calibre 18-20. 6200 kg.", "hash": "0x2nx0i9h3e9g2f4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "83", "lotId": "124", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-10-05", "stepTime": "10:00", "location": "-15.8369, -74.2526", "observations": "Maduración en cámaras con etileno. Control de temperatura 18°C.", "hash": "0x3oy1j0i4f0h3g5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "84", "lotId": "124", "userId": "17", "stepType": "Empaque", "stepDate": "2025-10-07", "stepTime": "08:00", "location": "-15.8369, -74.2526", "observations": "Empaque en cajas de 4kg. Papel seda protector. Total: 1550 cajas.", "hash": "0x4pz2k1j5g1i4h6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "85", "lotId": "124", "userId": "18", "stepType": "Inspección", "stepDate": "2025-10-08", "stepTime": "09:00", "location": "-15.8369, -74.2526", "observations": "SENASA certifica libre de mosca de la fruta. Autorizado export.", "hash": "0x5qa3l2k6h2j5i7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "86", "lotId": "124", "userId": "11", "stepType": "Transporte", "stepDate": "2025-10-09", "stepTime": "02:00", "location": "-15.8369, -74.2526", "observations": "Carga refrigerada 6°C. Transporte terrestre a puerto.", "hash": "0x6rb4m3l7i3k6j8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "87", "lotId": "124", "userId": "13", "stepType": "Distribución", "stepDate": "2025-10-11", "stepTime": "15:00", "location": "-12.0464, -77.1428", "observations": "Embarcado en contenedor reefer. Destino: Europa. Lote cerrado.", "hash": "0x7sc5n4m8j4l7k9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "88", "lotId": "120", "userId": "8", "stepType": "Siembra", "stepDate": "2025-09-25", "stepTime": "07:00", "location": "-8.3791, -74.5447", "observations": "Plantación de hijuelos de plátano. Distancia 3x3m.", "hash": "0x8td6o5n9k5m8l0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "89", "lotId": "120", "userId": "19", "stepType": "Riego", "stepDate": "2025-10-05", "stepTime": "06:30", "location": "-8.3791, -74.5447", "observations": "Riego por aspersión. Aprovechamiento de lluvias amazónicas.", "hash": "0x9ue7p6o0l6n9m1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"},
    {"id": "90", "lotId": "120", "userId": "8", "stepType": "Fertilización", "stepDate": "2025-10-15", "stepTime": "08:00", "location": "-8.3791, -74.5447", "observations": "Abono orgánico alrededor de plantas. Compost de platanera.", "hash": "0x0vf8q7p1m7o0n2a4a5b7d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a"},
    {"id": "91", "lotId": "120", "userId": "10", "stepType": "Poda", "stepDate": "2025-10-25", "stepTime": "07:30", "location": "-8.3791, -74.5447", "observations": "Deshije y eliminación de hojas secas. Ventilación mejorada.", "hash": "0x1wg9r8q2n8p1o3a5a6b8d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a"},
    {"id": "92", "lotId": "120", "userId": "18", "stepType": "Inspección", "stepDate": "2025-11-05", "stepTime": "10:00", "location": "-8.3791, -74.5447", "observations": "Control de sigatoka negra. Aplicación de caldo bordelés orgánico.", "hash": "0x2xh0s9r3o9q2p4a6a7b9d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a"},
    {"id": "93", "lotId": "120", "userId": "8", "stepType": "Cosecha", "stepDate": "2025-11-20", "stepTime": "06:00", "location": "-8.3791, -74.5447", "observations": "Corte de racimos en grado 3/4. Peso promedio: 35 kg/racimo. 150 racimos.", "hash": "0x3yi1t0s4p0r3q5a7a8b0d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a"},
    {"id": "94", "lotId": "120", "userId": "12", "stepType": "Procesamiento", "stepDate": "2025-11-20", "stepTime": "09:00", "location": "-8.3758, -74.5414", "observations": "Desmane y lavado con agua clorada. Clasificación manual.", "hash": "0x4zj2u1t5q1s4r6a8a9b1d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a"},
    {"id": "95", "lotId": "120", "userId": "17", "stepType": "Empaque", "stepDate": "2025-11-20", "stepTime": "12:00", "location": "-8.3758, -74.5414", "observations": "Empaque en cajas de cartón 18kg. Manos de 8-10 dedos. 290 cajas.", "hash": "0x5ak3v2u6r2t5s7a9a0b2d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a"},
    {"id": "96", "lotId": "120", "userId": "15", "stepType": "Inspección", "stepDate": "2025-11-21", "stepTime": "08:00", "location": "-8.3758, -74.5414", "observations": "Certificación orgánica aprobada. Comercio justo verificado.", "hash": "0x6bl4w3v7s3u6t8a0a1b3d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a"},
    {"id": "97", "lotId": "120", "userId": "11", "stepType": "Transporte", "stepDate": "2025-11-22", "stepTime": "05:00", "location": "-8.3758, -74.5414", "observations": "Transporte terrestre refrigerado 13°C. Ruta Lima 18 horas.", "hash": "0x7cm5x4w8t4v7u9a1a2b4d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a"},
    {"id": "98", "lotId": "120", "userId": "13", "stepType": "Almacenamiento", "stepDate": "2025-11-23", "stepTime": "10:00", "location": "-12.0897, -77.0501", "observations": "Almacenado en centro de distribución. Maduración controlada.", "hash": "0x8dn6y5x9u5w8v0a2a3b5d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a"},
    {"id": "99", "lotId": "120", "userId": "14", "stepType": "Distribución", "stepDate": "2025-11-24", "stepTime": "07:00", "location": "-12.1156, -77.0209", "observations": "Distribuido a mercados locales. Lote cerrado exitosamente.", "hash": "0x9eo7z6y0v6x9w1a3a4b6d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a"}
  ];

  // Obtener un batch por ID
  Future<Batch> getBatchById(String id) async {
    await Future.delayed(const Duration(seconds: 1));
    final batchMap = _batchesData.firstWhere(
      (b) => b['id'] == id,
      orElse: () => throw Exception('Batch not found'),
    );
    return Batch.fromJson(batchMap);
  }

  // Obtener todos los batches
  Future<List<Batch>> getAllBatches() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _batchesData.map((b) => Batch.fromJson(b)).toList();
  }

  // Obtener pasos de un lote
  Future<List<Step>> getStepsForLot(String lotId) async {
    await Future.delayed(const Duration(seconds: 1));
    final stepsList = _stepsData.where((s) => s['lotId'] == lotId).toList();

    // Ordenar por fecha y hora
    stepsList.sort((a, b) {
      try {
        final dtA = DateTime.parse("${a['stepDate']}T${a['stepTime']}:00");
        final dtB = DateTime.parse("${b['stepDate']}T${b['stepTime']}:00");
        return dtA.compareTo(dtB);
      } catch (e) {
        return 0;
      }
    });

    return stepsList.map((s) => Step.fromJson(s)).toList();
  }

  // Obtener un usuario por ID
  Future<User> getUserById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final userMap = _usersData.firstWhere(
      (u) => u['id'] == id,
      orElse: () => throw Exception('User not found'),
    );
    return User.fromJson(userMap);
  }

  // Obtener todos los usuarios
  Future<List<User>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _usersData.map((u) => User.fromJson(u)).toList();
  }

  // Obtener nombres de compañías únicas
  Future<List<String>> getUniqueCompanies() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final companies = _usersData
        .map((u) => u['companyName'] as String)
        .toSet()
        .toList();
    companies.sort();
    return companies;
  }

  // Obtener usuarios por compañía
  Future<List<User>> getUsersByCompany(String companyName) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final usersList = _usersData
        .where((u) => u['companyName'] == companyName)
        .toList();
    return usersList.map((u) => User.fromJson(u)).toList();
  }

  // Obtener taxId de una compañía
  Future<String> getCompanyTaxId(String companyName) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final user = _usersData.firstWhere(
      (u) => u['companyName'] == companyName && (u['taxId'] as String).isNotEmpty,
      orElse: () => {'taxId': 'N/A'},
    );
    return user['taxId'] as String;
  }
}
