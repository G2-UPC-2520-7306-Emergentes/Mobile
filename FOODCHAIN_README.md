# FoodChain - Aplicación de Trazabilidad

Aplicación Flutter completa para rastreo y verificación de productos alimenticios mediante códigos QR y blockchain.

## Características Implementadas

### 1. Navegación Principal
- **BottomNavigationBar** con 4 pestañas:
  - Historial (Timeline)
  - Mapa
  - Empresas
  - Ayuda

### 2. Flujo Principal

#### Pantalla de Inicio (HomeScreen)
- Botón "Scan QR Code" con animación de pulso
- Diseño limpio con branding de FoodChain
- Textos informativos sobre verificación blockchain

#### Simulador de Escaneo QR (QRScannerScreen)
- Diálogo de selección de lotes para simulación:
  - Lote 101 - Café Cosecha Fina 2025 (con múltiples pasos)
  - Lote 120 - Plátano Bellaco (con ubicación GPS)
  - Lote 103 - Aguacate Hass Export

#### Pantalla de Validación (ValidationScreen)
- Indicador de carga animado
- Carga de datos del lote desde FakeApiService
- Navegación automática a Timeline al completar

#### Pantalla Timeline (TimelineScreen)
- Vista de línea de tiempo vertical con timeline_tile
- Iconos específicos para cada tipo de evento (Siembra, Fertilización, Riego, etc.)
- Información del lote (ID, fecha de origen, estado)
- Sello verificado con botones para:
  - Ver Mapa
  - Ver Empresas Participantes
  - Ver Verificación Blockchain

#### Pantalla de Mapa (MapScreen)
- Mapa interactivo con flutter_map
- Filtros: Todos, Movimientos, Procesos fijos
- Marcadores para ubicaciones GPS
- DraggableScrollableSheet con lista de eventos

#### Pantalla de Empresas (CompaniesScreen)
- Lista de empresas participantes
- Tarjetas con iconos específicos por tipo de empresa
- Botón "View Details" para cada empresa

#### Pantalla de Detalles de Empresa (CompanyDetailScreen)
- Información de la empresa seleccionada
- Certificaciones de calidad (ISO 9001, GlobalG.A.P., Organic Certified)
- Lista de personal de la empresa
- Tax ID e información básica

#### Pantalla de Verificación Blockchain (BlockchainVerificationScreen)
- Tres estados posibles:
  - **Verificado**: Muestra hash y Transaction ID
  - **En verificación**: Algunos eventos pendientes
  - **Inconsistencia detectada**: Error en blockchain
- Información detallada del lote

#### Pantalla de Ayuda (HelpScreen)
- Guía de uso de la aplicación
- Preguntas frecuentes
- Información de contacto

## Arquitectura

### Modelos de Datos (`lib/core/models/`)
- **Batch**: Información del lote (id, lotName, farmName, variety, harvestDate, createdDate, state, imageUrl, producerId)
- **Step**: Pasos de trazabilidad (id, lotId, userId, stepType, stepDate, stepTime, location, observations, hash)
- **User**: Usuarios de empresas (id, firstName, lastName, email, companyName, taxId, requestedRole, etc.)

### Servicios (`lib/core/services/`)
- **FakeApiService**: Simula una API REST con datos JSON estáticos
  - 20 lotes de productos diversos
  - 10 usuarios de diferentes empresas
  - 21 eventos de trazabilidad
  - Métodos con latencia simulada (Future.delayed)

### Manejo de Estado (`lib/core/providers/`)
- **AppStateProvider**: Provider con ChangeNotifier
  - Gestión de lote actual y pasos
  - Lista de usuarios cargados
  - Índice de navegación seleccionado
  - Métodos de navegación entre pestañas

### Pantallas (`lib/features/home/presentation/`)
- home_screen.dart
- qr_scanner_screen.dart
- validation_screen.dart
- main_screen.dart
- timeline_screen.dart
- map_screen.dart
- companies_screen.dart
- company_detail_screen.dart
- blockchain_verification_screen.dart
- help_screen.dart

## Datos de Prueba

El FakeApiService contiene datos completos de:

### Batches (20 lotes)
- Café, Maíz, Aguacate, Tomate Cherry, Fresa, Caña de Azúcar
- Trigo, Mango, Papas, Cebolla, Limón, Quinua
- Cacao, Zanahoria, Avena, Pimientos, Arroz, Durazno
- Aceite de Oliva, Plátano

### Empresas
- Finca Los Andes (Productor)
- Empacadora Delta (Procesador)
- Control Certificado (Auditor)
- Admin Global (Administrador)
- Los Mas Chingones (Administrador)

### Tipos de Eventos
- Siembra
- Fertilización
- Riego
- Cosecha
- Inspección
- Plantación
- Fumigación
- Poda
- Monitoreo
- Abono

## Tecnologías Utilizadas

### Dependencias Principales
- **provider**: Manejo de estado
- **timeline_tile**: Componente de línea de tiempo
- **flutter_map**: Mapas interactivos
- **latlong2**: Coordenadas geográficas
- **intl**: Formateo de fechas
- **mobile_scanner**: Escaneo de QR (base existente)

## Cómo Ejecutar

1. Asegúrate de tener Flutter instalado
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## Flujo de Uso

1. En la pantalla de inicio, presiona "Scan QR Code"
2. Selecciona un lote del diálogo de simulación (101, 120, o 103)
3. Espera la validación
4. Explora el Timeline del producto
5. Navega entre las pestañas:
   - **Historial**: Ver eventos cronológicos
   - **Mapa**: Ver ubicaciones en el mapa
   - **Empresas**: Ver empresas participantes
   - **Ayuda**: Obtener información de uso

## Características Destacadas

- Diseño limpio y moderno
- Animaciones suaves (pulso en botones, transiciones)
- Manejo robusto de estado con Provider
- Datos realistas de producción agrícola
- Simulación completa de API sin backend
- Verificación blockchain simulada
- Mapas interactivos con OpenStreetMap
- Timeline visual con iconos contextuales

## Notas Técnicas

- El hash de los eventos está vacío ("") por defecto para simular el estado "En verificación"
- Las ubicaciones GPS usan el formato "-12.1470976, -76.9785856"
- Las fechas usan el formato ISO 8601
- El servicio FakeApiService simula latencia de red (1-2 segundos)
- La aplicación usa un tema personalizado (AppTheme)

## Estructura de Archivos

```
lib/
├── app/
│   └── app_bootstrap.dart          # Configuración inicial con Provider
├── core/
│   ├── models/                     # Modelos de datos
│   │   ├── batch.dart
│   │   ├── step.dart
│   │   └── user.dart
│   ├── providers/                  # Manejo de estado
│   │   └── app_state_provider.dart
│   ├── services/                   # Servicios de datos
│   │   └── fake_api_service.dart
│   ├── theme/                      # Tema de la app
│   │   └── app_theme.dart
│   └── widgets/                    # Widgets reutilizables
│       ├── elevated_surface.dart
│       └── primary_button.dart
├── features/
│   └── home/
│       ├── domain/
│       │   └── home_nav_item.dart  # Enum de navegación
│       └── presentation/           # Todas las pantallas
│           ├── home_screen.dart
│           ├── qr_scanner_screen.dart
│           ├── validation_screen.dart
│           ├── main_screen.dart
│           ├── timeline_screen.dart
│           ├── map_screen.dart
│           ├── companies_screen.dart
│           ├── company_detail_screen.dart
│           ├── blockchain_verification_screen.dart
│           └── help_screen.dart
└── main.dart                       # Punto de entrada
```

---

Aplicación creada para demostrar trazabilidad de productos alimenticios con blockchain.
