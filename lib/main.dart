import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';


void main() {
  runApp(const EVServiceApp());
}

// ============================================================
// COLORES DE LA APLICACIÓN
// ============================================================

const Color evBlue = Color(0xFF087EF5);
const Color evDark = Color(0xFF102A43);
const Color evGreen = Color(0xFF18A558);
const Color evLight = Color(0xFFF4F8FC);
const Color evOrange = Color(0xFFFFA726);

class SesionUsuario {
  static int? id;
  static String? nombre;
  static String? email;
  static String? rol;
}

//===========================================================
// APLICACIÓN
// ============================================================

class EVServiceApp extends StatelessWidget {
  const EVServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EV SERVICE',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: evLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: evBlue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: evLight,
          foregroundColor: evDark,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

// ============================================================
// BIENVENIDA
// ============================================================

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: evBlue.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.electric_car,
                    size: 90,
                    color: evBlue,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'EV SERVICE',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: evDark,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Gestión inteligente para vehículos eléctricos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 45),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
     onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginPage(),
    ),
  );
},
                    icon: const Icon(Icons.login),
                    label: const Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text(
                      'Crear cuenta',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Movilidad eléctrica • Tecnología • Servicio',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String role = 'Cliente';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: evBlue.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.electric_car,
                size: 65,
                color: evBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido a EV SERVICE',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: evDark,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: role,
              decoration: const InputDecoration(
                labelText: 'Tipo de usuario',
                prefixIcon: Icon(Icons.badge_outlined),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Cliente',
                  child: Text('Cliente'),
                ),
                DropdownMenuItem(
                  value: 'Mecánico',
                  child: Text('Mecánico'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  role = value!;
                });
              },
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ingrese correo y contraseña'),
      ),
    );
    return;
  }

  try {
    final resultado = await ApiService.login(
      email,
      password,
    );

    if (!mounted) return;

    if (resultado['estado'] == 'OK') {
      final usuario = resultado['usuario'];
      final rolUsuario = usuario['rol'];
if (rolUsuario != role) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Esta cuenta no corresponde al tipo de usuario $role',
      ),
    ),
  );
  return;
}
      SesionUsuario.id = usuario['id'];
      SesionUsuario.nombre = usuario['nombre'];
      SesionUsuario.email = usuario['email'];
      SesionUsuario.rol = usuario['rol'];

      if (rolUsuario == 'Cliente') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ClientHomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MechanicHomePage(),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            resultado['mensaje'] ?? 'Error al iniciar sesión',
          ),
        ),
      );
    }
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'No se pudo conectar con el servidor: $error',
        ),
      ),
    );
  }
},
                icon: const Icon(Icons.login),
                label: const Text('Ingresar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REGISTRO
// ============================================================

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear cuenta'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.person_add_alt_1,
              size: 70,
              color: evBlue,
            ),
            const SizedBox(height: 15),
            const Text(
              'Crear nueva cuenta',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: evDark,
              ),
            ),
            const SizedBox(height: 25),
TextField(
  controller: nameController,
  decoration: const InputDecoration(
    labelText: 'Nombre completo',
    prefixIcon: Icon(Icons.person_outline),
  ),
),
            const SizedBox(height: 15),
          TextField(
  controller: emailController,
  keyboardType: TextInputType.emailAddress,
  decoration: const InputDecoration(
    labelText: 'Correo electrónico',
    prefixIcon: Icon(Icons.email_outlined),
  ),
),       
            const SizedBox(height: 15),
            TextField(
  controller: passwordController,
  obscureText: true,
  decoration: const InputDecoration(
    labelText: 'Contraseña',
    prefixIcon: Icon(Icons.lock_outline),
  ),
),
            const SizedBox(height: 15),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () async {
  final nombre = nameController.text.trim();
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (nombre.isEmpty || email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Complete todos los campos'),
      ),
    );
    return;
  }

  try {
    final resultado = await ApiService.registrarUsuario(
      nombre,
      email,
      password,
      'Cliente',
    );

    if (!mounted) return;

    if (resultado['estado'] == 'OK') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cuenta creada correctamente'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            resultado['mensaje'] ?? 'No se pudo crear la cuenta',
          ),
        ),
      );
    }
  } catch (error) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'No se pudo conectar con el servidor: $error',
        ),
      ),
    );
  }
},
                icon: const Icon(Icons.check),
                label: const Text('Crear cuenta'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PANEL CLIENTE
// ============================================================

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EV SERVICE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const WelcomePage(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hola, Cliente 👋',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: evDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Todo el control de tu vehículo eléctrico en un solo lugar.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),

            // VEHÍCULO PRINCIPAL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    evBlue,
                    Color(0xFF35A7FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.electric_car,
                        color: Colors.white,
                        size: 42,
                      ),
                      Spacer(),
                      Icon(
                        Icons.battery_full,
                        color: Colors.white,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Nissan Leaf',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'ABC-1234 • 45.230 km',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Estado de batería',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '92 % SOH',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Servicios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: evDark,
              ),
            ),

            const SizedBox(height: 12),

            MenuCard(
              icon: Icons.directions_car,
              title: 'Mis vehículos',
              subtitle: 'Consulta tus vehículos registrados',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VehiclePage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.event_available,
              title: 'Agendar cita',
              subtitle: 'Solicita mantenimiento o diagnóstico',
              iconColor: evGreen,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AppointmentPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.calendar_month,
              title: 'Mis citas',
              subtitle: 'Consulta tus citas programadas',
              iconColor: evOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyAppointmentsPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.battery_full,
              title: 'Batería',
              subtitle: 'Estado y datos técnicos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BatteryPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.history,
              title: 'Historial',
              subtitle: 'Mantenimientos y diagnósticos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoryPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.picture_as_pdf,
              title: 'Documentos',
              subtitle: 'Informes y documentos de servicio',
              iconColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DocumentsPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.qr_code_2,
              title: 'Código QR',
              subtitle: 'Identificación de tu vehículo',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QrPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TARJETA DE MENÚ
// ============================================================

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? iconColor;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? evBlue;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 27,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: evDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// QR ?
// ============================================================

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool procesando = false;

  void procesarCodigo(String codigo) {
    if (procesando) return;

    if (!codigo.startsWith('EVSERVICE|vehiculo:')) {
      return;
    }

    setState(() {
      procesando = true;
    });

    Navigator.pop(context, codigo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Escanear vehículo'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (capture) {
              final codigo = capture.barcodes.firstOrNull?.rawValue;

              if (codigo != null) {
                procesarCodigo(codigo);
              }
            },
          ),

          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(
                  color: evBlue,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 40,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Coloca el código QR del vehículo dentro del recuadro.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ============================================================
// VEHÍCULOS
// ============================================================

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  State<VehiclePage> createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  late Future<List<dynamic>> vehiculosFuture;

  @override
void initState() {
  super.initState();

  if (SesionUsuario.id == null) {
    vehiculosFuture = Future.error(
      Exception('No hay un usuario conectado'),
    );
  } else if (SesionUsuario.rol == 'Mecánico') {
    vehiculosFuture = ApiService.obtenerVehiculos();
  } else {
    vehiculosFuture =
        ApiService.obtenerVehiculosPorUsuario(SesionUsuario.id!);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
  title: const Text('Mis vehículos'),
  backgroundColor: evDark,
  foregroundColor: Colors.white,
  actions: [
    IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Agregar vehículo',
      onPressed: () async {
  final resultado = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AddVehiclePage(),
    ),
  );

  if (resultado == true && mounted) {
    setState(() {
      vehiculosFuture =
          ApiService.obtenerVehiculosPorUsuario(SesionUsuario.id!);
    });
  }
},
    ),
  ],
),
      body: FutureBuilder<List<dynamic>>(
        future: vehiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudieron cargar los vehículos.\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final vehiculos = snapshot.data ?? [];

          if (vehiculos.isEmpty) {
            return const Center(
              child: Text('No hay vehículos registrados.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: vehiculos.length,
            itemBuilder: (context, index) {
              final vehiculo = vehiculos[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: evBlue.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.electric_car,
                              color: evBlue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              '${vehiculo['marca']} ${vehiculo['modelo']}',
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: evDark,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Placa: ${vehiculo['placa']}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 6),

                      Text('Año: ${vehiculo['anio']}'),

                      const SizedBox(height: 6),

                      Text(
                        'Kilometraje: ${vehiculo['kilometraje']} km',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'VIN: ${vehiculo['vin']}',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Batería: ${vehiculo['bateria_kwh']} kWh',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Voltaje: ${vehiculo['voltaje']} V',
                      ),
                      const SizedBox(height: 16),

                       Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    OutlinedButton.icon(
      onPressed: () async {
        final resultado = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EditVehiclePage(
              vehiculo: vehiculo,
            ),
          ),
        );

        if (resultado == true && mounted) {
          setState(() {
            vehiculosFuture =
                ApiService.obtenerVehiculosPorUsuario(
              SesionUsuario.id!,
            );
          });
        }
      },
      icon: const Icon(Icons.edit),
      label: const Text('Editar'),
    ),

OutlinedButton.icon(
  onPressed: () {
    final qrData =
        'EVSERVICE|vehiculo:${vehiculo['id']}|placa:${vehiculo['placa']}';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Código QR del vehículo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
  width: 220,
  height: 220,
  child: QrImageView(
    data: qrData,
  ),
),
              const SizedBox(height: 12),
              Text(
                '${vehiculo['marca']} ${vehiculo['modelo']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: evDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'Placa: ${vehiculo['placa']}',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  },
  icon: const Icon(Icons.qr_code),
  label: const Text('Ver QR'),
),

const SizedBox(width: 10),


    const SizedBox(width: 10),

    OutlinedButton.icon(
      onPressed: () async {
        final confirmar = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Eliminar vehículo'),
              content: Text(
                '¿Está seguro de eliminar '
                '${vehiculo['marca']} ${vehiculo['modelo']}?',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Eliminar'),
                ),
              ],
            );
          },
        );

        if (confirmar != true || !mounted) {
          return;
        }

        try {
          final resultado =
              await ApiService.eliminarVehiculo(
            vehiculo['id'],
          );

          if (!mounted) return;

          if (resultado['estado'] == 'OK') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Vehículo eliminado correctamente',
                ),
              ),
            );

            setState(() {
              vehiculosFuture =
                  ApiService.obtenerVehiculosPorUsuario(
                SesionUsuario.id!,
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  resultado['mensaje'] ??
                      'No se pudo eliminar el vehículo',
                ),
              ),
            );
          }
        } catch (error) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'No se pudo conectar con el servidor: $error',
              ),
            ),
          );
        }
      },
      icon: const Icon(Icons.delete_outline),
      label: const Text('Eliminar'),
    ),
  ],
),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// DATOS VEHÍCULO
// ============================================================

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  String service = 'Mantenimiento preventivo';

  List<dynamic> vehiculos = [];
  int? vehiculoSeleccionadoId;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final descriptionController = TextEditingController();

  bool cargandoVehiculos = true;
  bool guardando = false;

  @override
  void initState() {
    super.initState();
    cargarVehiculos();
  }

  Future<void> cargarVehiculos() async {
    if (SesionUsuario.id == null) {
      setState(() {
        cargandoVehiculos = false;
      });
      return;
    }

    try {
      final resultado =
          await ApiService.obtenerVehiculosPorUsuario(
        SesionUsuario.id!,
      );

      if (!mounted) return;

      setState(() {
        vehiculos = resultado;
        cargandoVehiculos = false;

        if (vehiculos.isNotEmpty) {
          vehiculoSeleccionadoId = vehiculos.first['id'];
        }
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        cargandoVehiculos = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudieron cargar los vehículos: $error',
          ),
        ),
      );
    }
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      initialDate: DateTime.now(),
    );

    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: 9,
        minute: 0,
      ),
    );

    if (time != null && mounted) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  Future<void> confirmAppointment() async {
    if (SesionUsuario.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No hay un usuario conectado.',
          ),
        ),
      );
      return;
    }

    if (vehiculoSeleccionadoId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleccione un vehículo.',
          ),
        ),
      );
      return;
    }

    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleccione una fecha y una hora para continuar.',
          ),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    final fecha =
        '${selectedDate!.year.toString().padLeft(4, '0')}-'
        '${selectedDate!.month.toString().padLeft(2, '0')}-'
        '${selectedDate!.day.toString().padLeft(2, '0')}';

    final hora =
        '${selectedTime!.hour.toString().padLeft(2, '0')}:'
        '${selectedTime!.minute.toString().padLeft(2, '0')}:00';

    try {
      final resultado = await ApiService.registrarCita(
        SesionUsuario.id!,
        vehiculoSeleccionadoId!,
        service,
        fecha,
        hora,
        descriptionController.text.trim(),
      );

      if (!mounted) return;

      if (resultado['estado'] == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cita registrada correctamente.',
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const MyAppointmentsPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado['mensaje'] ??
                  'No se pudo registrar la cita.',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo conectar con el servidor: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cita'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nueva cita de servicio',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: evDark,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Solicita atención para tu vehículo eléctrico.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Vehículo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            if (cargandoVehiculos)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (vehiculos.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'No tiene vehículos registrados. '
                  'Registre primero un vehículo en "Mis vehículos".',
                ),
              )
            else
              DropdownButtonFormField<int>(
                initialValue: vehiculoSeleccionadoId,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.electric_car,
                  ),
                ),
                items: vehiculos.map<DropdownMenuItem<int>>(
                  (vehiculo) {
                    return DropdownMenuItem<int>(
                      value: vehiculo['id'],
                      child: Text(
                        '${vehiculo['marca']} '
                        '${vehiculo['modelo']} - '
                        '${vehiculo['placa']}',
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    vehiculoSeleccionadoId = value;
                  });
                },
              ),

            const SizedBox(height: 20),

            const Text(
              'Tipo de servicio',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: service,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.build),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Mantenimiento preventivo',
                  child: Text(
                    'Mantenimiento preventivo',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Diagnóstico de batería',
                  child: Text(
                    'Diagnóstico de batería',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Diagnóstico general',
                  child: Text(
                    'Diagnóstico general',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Cambio de batería',
                  child: Text(
                    'Cambio de batería',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Revisión sistema eléctrico',
                  child: Text(
                    'Revisión sistema eléctrico',
                  ),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    service = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Fecha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: selectDate,
                icon: const Icon(
                  Icons.calendar_month,
                ),
                label: Text(
                  selectedDate == null
                      ? 'Seleccionar fecha'
                      : '${selectedDate!.day}/'
                          '${selectedDate!.month}/'
                          '${selectedDate!.year}',
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'Hora',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: selectTime,
                icon: const Icon(
                  Icons.access_time,
                ),
                label: Text(
                  selectedTime == null
                      ? 'Seleccionar hora'
                      : selectedTime!.format(context),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Descripción / motivo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText:
                    'Describa brevemente el motivo de la cita...',
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed:
                    guardando ? null : confirmAppointment,
                icon: guardando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.check_circle,
                      ),
                label: Text(
                  guardando
                      ? 'Guardando...'
                      : 'Confirmar cita',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MIS CITAS
// ============================================================

class MechanicAppointmentsPage extends StatefulWidget {
  const MechanicAppointmentsPage({super.key});

  @override
  State<MechanicAppointmentsPage> createState() =>
      _MechanicAppointmentsPageState();
}

class _MechanicAppointmentsPageState
    extends State<MechanicAppointmentsPage> {
  late Future<List<dynamic>> citasFuture;

  @override
  void initState() {
    super.initState();
    citasFuture = ApiService.obtenerCitas();
  }

  Future<void> recargarCitas() async {
    setState(() {
      citasFuture = ApiService.obtenerCitas();
    });

    await citasFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Citas de servicio'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: citasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudieron cargar las citas.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final todasLasCitas = snapshot.data ?? [];

final citas = todasLasCitas.where((cita) {
  final estado = cita['estado'];

  return estado == 'Pendiente' ||
      estado == 'Confirmada';
}).toList();

debugPrint('CITAS ACTIVAS: ${citas.length}');

          if (citas.isEmpty) {
            return RefreshIndicator(
              onRefresh: recargarCitas,
              child: ListView(
                children: const [
                  SizedBox(height: 180),
                  Center(
                    child: Text(
                      'No hay citas pendientes ni confirmadas.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: recargarCitas,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: citas.length,
              itemBuilder: (context, index) {
                final cita = citas[index];

                final estado =
                    cita['estado'] ?? 'Pendiente';

                Color estadoColor;

                switch (estado) {
                  case 'Confirmada':
                    estadoColor = evGreen;
                    break;
                  case 'Atendida':
                    estadoColor = evBlue;
                    break;
                  case 'Cancelada':
                    estadoColor = Colors.red;
                    break;
                  default:
                    estadoColor = evOrange;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: evBlue.withValues(
                                  alpha: 0.10,
                                ),
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.event,
                                color: evBlue,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                cita['servicio'] ??
                                    'Servicio',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: evDark,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: estadoColor.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: Text(
                                estado,
                                style: TextStyle(
                                  color: estadoColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 8),

                        _CitaDato(
                          icon: Icons.calendar_today,
                          label: 'Fecha',
                          valor: '${cita['fecha'] ?? ''}',
                        ),

                        _CitaDato(
                          icon: Icons.access_time,
                          label: 'Hora',
                          valor: '${cita['hora'] ?? ''}',
                        ),

                        _CitaDato(
                          icon: Icons.person,
                          label: 'Cliente',
                          valor:
                              '${cita['cliente'] ?? 'Cliente'}',
                        ),

_CitaDato(
  icon: Icons.engineering,
  label: 'Mecánico',
  valor:
      '${cita['mecanico'] ?? 'Por asignar'}',
),

                        _CitaDato(
                          icon: Icons.directions_car,
                          label: 'Vehículo',
                          valor:
                              '${cita['marca'] ?? ''} ${cita['modelo'] ?? ''}',
                        ),

                        _CitaDato(
                          icon: Icons.confirmation_number,
                          label: 'Placa',
                          valor:
                              '${cita['placa'] ?? 'Sin placa'}',
                        ),

                        if (cita['descripcion'] != null &&
    cita['descripcion']
        .toString()
        .isNotEmpty)
  _CitaDato(
    icon: Icons.notes,
    label: 'Descripción',
    valor:
        '${cita['descripcion']}',
  ),

if (estado == 'Pendiente') ...[
  const SizedBox(height: 16),

  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () async {
        final resultado =
            await ApiService.confirmarCita(
          int.parse('${cita['id']}'),
          SesionUsuario.id!,
        );

        if (!context.mounted) return;

        if (resultado['estado'] == 'OK') {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Cita confirmada correctamente',
              ),
            ),
          );

          setState(() {
            citasFuture =
                ApiService.obtenerCitas();
          });
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                '${resultado['mensaje']}',
              ),
            ),
          );
        }
      },
      icon: const Icon(
        Icons.check_circle,
      ),
      label: const Text(
        'CONFIRMAR CITA',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: evGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
      ),
    ),
  ),
],

if (estado == 'Confirmada') ...[
  const SizedBox(height: 16),

  SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: () async {
        final resultado =
            await ApiService.atenderCita(
          int.parse('${cita['id']}'),
        );

        if (!context.mounted) return;

        if (resultado['estado'] == 'OK') {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
              content: Text(
                'Cita marcada como atendida',
              ),
            ),
          );

          setState(() {
            citasFuture =
                ApiService.obtenerCitas();
          });
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                '${resultado['mensaje']}',
              ),
            ),
          );
        }
      },
      icon: const Icon(
        Icons.task_alt,
      ),
      label: const Text(
        'MARCAR COMO ATENDIDA',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: evBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
      ),
    ),
  ),
],
],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _CitaDato extends StatelessWidget {
  final IconData icon;
  final String label;
  final String valor;

  const _CitaDato({
    required this.icon,
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: evDark,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 75,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(valor),
          ),
        ],
      ),
    );
  }
}

class MyAppointmentsPage extends StatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage> {
  late Future<List<dynamic>> citasFuture;

  @override
  void initState() {
    super.initState();

    if (SesionUsuario.id == null) {
      citasFuture = Future.error(
        Exception('No hay un usuario conectado'),
      );
    } else {
      citasFuture =
          ApiService.obtenerCitasPorUsuario(SesionUsuario.id!);
    }
  }

  String formatearFecha(String fecha) {
    final partes = fecha.split('-');

    if (partes.length == 3) {
      return '${partes[2]}/${partes[1]}/${partes[0]}';
    }

    return fecha;
  }

  String formatearHora(String hora) {
    if (hora.length >= 5) {
      return hora.substring(0, 5);
    }

    return hora;
  }

  Color colorEstado(String estado) {
    switch (estado) {
      case 'Confirmada':
        return evGreen;
      case 'Cancelada':
        return Colors.red;
      case 'Atendida':
        return evBlue;
      default:
        return evOrange;
    }
  }

  String textoEstado(String estado) {
    switch (estado) {
      case 'Confirmada':
        return 'Confirmada';
      case 'Cancelada':
        return 'Cancelada';
      case 'Atendida':
        return 'Atendida';
      default:
        return 'Pendiente de confirmación';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis citas'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: citasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudieron cargar las citas.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final citas = snapshot.data ?? [];

          if (citas.isEmpty) {
            return const Center(
              child: Text(
                'No tienes citas registradas.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: citas.length,
            itemBuilder: (context, index) {
              final cita = citas[index];

              final estado =
                  '${cita['estado'] ?? 'Pendiente'}';

              final color = colorEstado(estado);

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: color.withValues(
                                alpha: 0.10,
                              ),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.event_available,
                              color: color,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              'Cita de servicio',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 25),

                      Text(
                        '${cita['marca']} '
                        '${cita['modelo']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Placa: ${cita['placa']}',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Servicio: ${cita['servicio']}',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Fecha: '
                        '${formatearFecha('${cita['fecha']}')}',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Hora: '
                        '${formatearHora('${cita['hora']}')}',
                      ),

                      if (cita['descripcion'] != null &&
                          '${cita['descripcion']}'
                              .trim()
                              .isNotEmpty) ...[

const SizedBox(height: 6),

Row(
  children: [
    const Icon(
      Icons.engineering,
      size: 19,
      color: evBlue,
    ),
    const SizedBox(width: 8),
    Expanded(
      child: Text(
        'Mecánico asignado: '
        '${cita['mecanico'] ?? 'Por asignar'}',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ],
),

                        const SizedBox(height: 10),

                        Text(
                          'Descripción: '
                          '${cita['descripcion']}',
                        ),
                      ],

                      const SizedBox(height: 15),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: color.withValues(
                            alpha: 0.12,
                          ),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          textoEstado(estado),
                          style: TextStyle(
                            color: color,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ============================================================
// BATERÍA
// ============================================================

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  late Future<List<dynamic>> vehiculosFuture;

  @override
  void initState() {
    super.initState();

    vehiculosFuture = ApiService.obtenerVehiculos();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Batería'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: vehiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo cargar la información de batería.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final vehiculos = snapshot.data ?? [];

          if (vehiculos.isEmpty) {
            return const Center(
              child: Text(
                'No tienes vehículos registrados.',
              ),
            );
          }

          final vehiculo = vehiculos.first;

          final bateria =
              vehiculo['bateria_kwh'] ?? 0;
          final voltaje =
              vehiculo['voltaje'] ?? 0;
          final kilometraje =
              vehiculo['kilometraje'] ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        evGreen,
                        Color(0xFF2ECC71),
                      ],
                    ),
                    borderRadius:
                        BorderRadius.circular(22),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.battery_full,
                        size: 75,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Batería del vehículo',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Información registrada',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.electric_car,
                      color: evBlue,
                    ),
                    title: Text(
                      '${vehiculo['marca']} '
                      '${vehiculo['modelo']}',
                    ),
                    subtitle: Text(
                      'Placa: ${vehiculo['placa']}',
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                BatteryData(
                  label: 'Capacidad de batería',
                  value: '$bateria kWh',
                ),

                BatteryData(
                  label: 'Voltaje',
                  value: '$voltaje V',
                ),

                BatteryData(
                  label: 'Kilometraje',
                  value: '$kilometraje km',
                ),

                const SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: evBlue.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: evBlue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Los datos mostrados corresponden '
                          'a la información registrada del vehículo.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// DATOS BATERÍA
// ============================================================

class BatteryData extends StatelessWidget {
  final String label;
  final String value;

  const BatteryData({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: evDark,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HISTORIAL
// ============================================================

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<dynamic>> historialFuture;

@override
void initState() {
  super.initState();

  if (SesionUsuario.id == null) {
    historialFuture = Future.error(
      Exception('No hay un usuario conectado'),
    );
  } else if (SesionUsuario.rol == 'Mecánico') {
    historialFuture = ApiService.obtenerHistorial();
  } else {
    historialFuture =
        ApiService.obtenerHistorialPorUsuario(
      SesionUsuario.id!,
    );
  }
}

  String formatearFecha(String fecha) {
    final partes = fecha.split('-');

    if (partes.length == 3) {
      return '${partes[2]}/${partes[1]}/${partes[0]}';
    }

    return fecha;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: historialFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo cargar el historial.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final historial = snapshot.data ?? [];

          if (historial.isEmpty) {
            return const Center(
              child: Text(
                'No tienes registros en tu historial.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: historial.length,
            itemBuilder: (context, index) {
              final registro = historial[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: evBlue.withValues(
                                alpha: 0.10,
                              ),
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.build_circle,
                              color: evBlue,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${registro['tipo_servicio']}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: evDark,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 25),

                      Text(
                        '${registro['marca']} '
                        '${registro['modelo']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Placa: ${registro['placa']}',
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Fecha: '
                        '${formatearFecha('${registro['fecha']}')}',
                      ),

                      if (registro['kilometraje'] != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          'Kilometraje: '
                          '${registro['kilometraje']} km',
                        ),
                      ],

                      if (registro['descripcion'] != null &&
                          '${registro['descripcion']}'
                              .trim()
                              .isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Descripción: '
                          '${registro['descripcion']}',
                        ),
                      ],

                      if (registro['resultado'] != null &&
                          '${registro['resultado']}'
                              .trim()
                              .isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Resultado: '
                          '${registro['resultado']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],

                      if (registro['observaciones'] != null &&
                          '${registro['observaciones']}'
                              .trim()
                              .isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Text(
                          'Observaciones: '
                          '${registro['observaciones']}',
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


// ============================================================
// TARJETA HISTORIAL
// ============================================================

class HistoryCard extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final IconData icon;

  const HistoryCard({
    super.key,
    required this.date,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: evBlue.withValues(alpha: 0.10),
              child: Icon(
                icon,
                color: evBlue,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: evBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: evDark,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DOCUMENTOS
// ============================================================

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  late Future<List<dynamic>> historialFuture;

  @override
  void initState() {
    super.initState();

    if (SesionUsuario.id == null) {
      historialFuture = Future.error(
        Exception('No hay un usuario conectado'),
      );
    } else if (SesionUsuario.rol == 'Mecánico') {
      historialFuture = ApiService.obtenerHistorial();
    } else {
      historialFuture =
          ApiService.obtenerHistorialPorUsuario(
        SesionUsuario.id!,
      );
    }
  }

  List<List<dynamic>> agruparPorVehiculo(
    List<dynamic> historial,
  ) {
    final Map<dynamic, List<dynamic>> grupos = {};

    for (final registro in historial) {
      final vehiculoId = registro['vehiculo_id'];

      if (!grupos.containsKey(vehiculoId)) {
        grupos[vehiculoId] = [];
      }

      grupos[vehiculoId]!.add(registro);
    }

    return grupos.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos PDF'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: historialFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'No se pudo cargar el historial.',
              ),
            );
          }

          final historial = snapshot.data ?? [];

          if (historial.isEmpty) {
            return const Center(
              child: Text(
                'No hay registros de historial.',
              ),
            );
          }

          final grupos = agruparPorVehiculo(historial);

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: grupos.length,
            itemBuilder: (context, index) {
              final registrosVehiculo = grupos[index];

              return VehicleDocumentCard(
                registros: registrosVehiculo,
              );
            },
          );
        },
      ),
    );
  }
}


// ============================================================
// DOCUMENTO
// ============================================================

class VehicleDocumentCard extends StatelessWidget {
  final List<dynamic> registros;

  const VehicleDocumentCard({
    super.key,
    required this.registros,
  });

  Future<void> generarPDF(BuildContext context) async {
    final pdf = pw.Document();

    final primerRegistro = registros.first;

    final marca =
        '${primerRegistro['marca'] ?? 'Sin marca'}';

    final modelo =
        '${primerRegistro['modelo'] ?? 'Sin modelo'}';

    final placa =
        '${primerRegistro['placa'] ?? 'Sin placa'}';

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Text(
              'EV SERVICE',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 8),

            pw.Text(
              'HISTORIAL COMPLETO DEL VEHÍCULO',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: PdfColor.fromInt(0xFF808080),
                ),
                borderRadius:
                    pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                crossAxisAlignment:
                    pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'VEHÍCULO',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.SizedBox(height: 6),

                  pw.Text(
                    '$marca $modelo',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),

                  pw.SizedBox(height: 5),

                  pw.Text(
                    'Placa: $placa',
                    style: pw.TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              'HISTORIAL DE SERVICIOS',
              style: pw.TextStyle(
                fontSize: 15,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 10),

            ...registros.asMap().entries.map((entrada) {
              final indice = entrada.key + 1;
              final registro = entrada.value;

              return pw.Container(
                margin: const pw.EdgeInsets.only(
                  bottom: 18,
                ),
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColor.fromInt(
                      0xFFD0D0D0,
                    ),
                  ),
                  borderRadius:
                      pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment:
                      pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      '$indice. '
                      '${registro['tipo_servicio'] ?? 'Servicio'}',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight:
                            pw.FontWeight.bold,
                      ),
                    ),

                    pw.SizedBox(height: 8),

                    pw.Text(
                      'Fecha: '
                      '${registro['fecha'] ?? ''}',
                    ),

                    pw.Text(
                      'Kilometraje: '
                      '${registro['kilometraje'] ?? 0} km',
                    ),

                    pw.SizedBox(height: 8),

                    pw.Text(
                      'Descripción',
                      style: pw.TextStyle(
                        fontWeight:
                            pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      '${registro['descripcion'] ?? 'Sin descripción'}',
                    ),

                    pw.SizedBox(height: 8),

                    pw.Text(
                      'Resultado',
                      style: pw.TextStyle(
                        fontWeight:
                            pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      '${registro['resultado'] ?? 'Sin resultado'}',
                    ),

                    pw.SizedBox(height: 8),

                    pw.Text(
                      'Observaciones',
                      style: pw.TextStyle(
                        fontWeight:
                            pw.FontWeight.bold,
                      ),
                    ),

                    pw.Text(
                      '${registro['observaciones'] ?? 'Sin observaciones'}',
                    ),
                  ],
                ),
              );
            }),

            pw.Divider(),

            pw.SizedBox(height: 8),

            pw.Text(
              'Total de servicios registrados: '
              '${registros.length}',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 15),

            pw.Text(
              'Documento generado por EV SERVICE',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColor.fromInt(
                  0xFF808080,
                ),
              ),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primerRegistro = registros.first;

    final marca =
        '${primerRegistro['marca'] ?? 'Sin marca'}';

    final modelo =
        '${primerRegistro['modelo'] ?? 'Sin modelo'}';

    final placa =
        '${primerRegistro['placa'] ?? 'Sin placa'}';

    return Card(
      margin: const EdgeInsets.only(bottom: 14),

      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: Colors.red.withValues(
              alpha: 0.10,
            ),
            borderRadius:
                BorderRadius.circular(12),
          ),

          child: const Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
          ),
        ),

        title: Text(
          '$marca $modelo',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        subtitle: Text(
          'Placa: $placa\n'
          '${registros.length} '
          'servicio(s) registrado(s)',
        ),

        trailing: IconButton(
          icon: const Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
          ),

          onPressed: () {
            generarPDF(context);
          },
        ),
      ),
    );
  }
}


// ============================================================
// QR
// ============================================================

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  late Future<List<dynamic>> vehiculosFuture;

  @override
  void initState() {
    super.initState();

    if (SesionUsuario.id == null) {
      vehiculosFuture = Future.error(
        Exception('No hay un usuario conectado'),
      );
    } else {
      vehiculosFuture =
          ApiService.obtenerVehiculosPorUsuario(SesionUsuario.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Código QR'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: vehiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No se pudo cargar el vehículo.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final vehiculos = snapshot.data ?? [];

          if (vehiculos.isEmpty) {
            return const Center(
              child: Text(
                'No tienes vehículos registrados.',
              ),
            );
          }

          final vehiculo = vehiculos.first;

          final datosQr = '''
EV SERVICE
Vehículo: ${vehiculo['marca']} ${vehiculo['modelo']}
Placa: ${vehiculo['placa']}
Año: ${vehiculo['anio']}
VIN: ${vehiculo['vin'] ?? 'No registrado'}
Usuario ID: ${SesionUsuario.id}
Vehículo ID: ${vehiculo['id']}
''';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  'Identificación del vehículo',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '${vehiculo['marca']} '
                  '${vehiculo['modelo']}',
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Placa: ${vehiculo['placa']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.08,
                        ),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: QrImageView(
                    data: datosQr,
                    version: QrVersions.auto,
                    size: 260,
                    backgroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: evBlue.withValues(
                      alpha: 0.08,
                    ),
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: evBlue,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Este código QR identifica el vehículo '
                          'registrado en EV SERVICE. '
                          'Posteriormente podrá utilizarse para '
                          'consultar información autorizada.',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================
// PANEL MECÁNICO
// ============================================================

class GestionGeneralMecanicoPage extends StatefulWidget {
  const GestionGeneralMecanicoPage({super.key});

  @override
  State<GestionGeneralMecanicoPage> createState() =>
      _GestionGeneralMecanicoPageState();
}

class _GestionGeneralMecanicoPageState
    extends State<GestionGeneralMecanicoPage> {
  late Future<Map<String, List<dynamic>>> datosFuture;

  @override
  void initState() {
    super.initState();
    datosFuture = cargarDatos();
  }

  Future<Map<String, List<dynamic>>> cargarDatos() async {
    final resultados = await Future.wait([
      ApiService.obtenerUsuarios(),
      ApiService.obtenerVehiculos(),
      ApiService.obtenerCitas(),
      ApiService.obtenerHistorial(),
    ]);

    return {
      'usuarios': resultados[0],
      'vehiculos': resultados[1],
      'citas': resultados[2],
      'historial': resultados[3],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Gestión general'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Map<String, List<dynamic>>>(
        future: datosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'No se pudieron cargar los datos.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final datos = snapshot.data!;

          final usuarios = datos['usuarios'] ?? [];
          final vehiculos = datos['vehiculos'] ?? [];
          final citas = datos['citas'] ?? [];
          final historial = datos['historial'] ?? [];

          final clientes = usuarios
              .where((u) => u['rol'] == 'Cliente')
              .toList();

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                datosFuture = cargarDatos();
              });

              await datosFuture;
            },
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Centro de gestión 🔧',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Información general del sistema EV SERVICE',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _GestionCard(
                        icon: Icons.people,
                        titulo: 'Clientes',
                        cantidad: clientes.length,
                        color: evBlue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _GestionCard(
                        icon: Icons.directions_car,
                        titulo: 'Vehículos',
                        cantidad: vehiculos.length,
                        color: evGreen,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _GestionCard(
                        icon: Icons.event,
                        titulo: 'Citas',
                        cantidad: citas.length,
                        color: evOrange,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _GestionCard(
                        icon: Icons.history,
                        titulo: 'Historial',
                        cantidad: historial.length,
                        color: evDark,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  'Clientes registrados',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 10),

                ...clientes.map(
                  (cliente) => Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: Text(
                        cliente['nombre'] ?? 'Sin nombre',
                      ),
                      subtitle: Text(
                        cliente['email'] ?? 'Sin correo',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Vehículos registrados',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 10),

                ...vehiculos.map(
                  (vehiculo) => Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.electric_car,
                        color: evGreen,
                      ),
                      title: Text(
                        '${vehiculo['marca']} ${vehiculo['modelo']}',
                      ),
                      subtitle: Text(
                        'Placa: ${vehiculo['placa']}',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Citas de servicio',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 10),

                ...citas.map(
                  (cita) => Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.event,
                        color: evOrange,
                      ),
                      title: Text(
                        cita['servicio'] ?? 'Servicio',
                      ),
                      subtitle: Text(
                        'Fecha: ${cita['fecha'] ?? ''}\n'
                        'Estado: ${cita['estado'] ?? ''}',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Historial técnico',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 10),

                ...historial.map(
                  (registro) => Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.history,
                        color: evDark,
                      ),
                      title: Text(
                        registro['tipo_servicio'] ??
                            'Servicio técnico',
                      ),
                      subtitle: Text(
                        registro['descripcion'] ??
                            'Sin descripción',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GestionCard extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final int cantidad;
  final Color color;

  const _GestionCard({
    required this.icon,
    required this.titulo,
    required this.cantidad,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 38,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              '$cantidad',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              titulo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MechanicHomePage extends StatelessWidget {
  const MechanicHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EV SERVICE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const WelcomePage(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Panel del Mecánico 🔧',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: evDark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Gestión técnica y atención de vehículos eléctricos.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    evDark,
                    Color(0xFF1D4E89),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.engineering,
                    size: 55,
                    color: Colors.white,
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Centro técnico',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Administra vehículos, citas y servicios.',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

MenuCard(
  icon: Icons.dashboard,
  title: 'Gestión general',
  subtitle: 'Clientes, vehículos, citas e historial',
  iconColor: evBlue,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GestionGeneralMecanicoPage(),
      ),
    );
  },
),

            const SizedBox(height: 25),

            const Text(
              'Gestión',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: evDark,
              ),
            ),

            const SizedBox(height: 12),

            MenuCard(
  icon: Icons.people,
  title: 'Clientes',
  subtitle: 'Gestionar clientes registrados',
  onTap: () async {
    try {
      final usuarios = await ApiService.obtenerUsuarios();

      final clientes = usuarios
          .where((usuario) => usuario['rol'] == 'Cliente')
          .toList();

      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Clientes registrados'),
            content: SizedBox(
              width: 420,
              height: 450,
              child: clientes.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay clientes registrados.',
                      ),
                    )
                  : ListView.builder(
                      itemCount: clientes.length,
                      itemBuilder: (context, index) {
                        final cliente = clientes[index];

                        return Card(
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  evBlue.withValues(alpha: 0.12),
                              child: const Icon(
                                Icons.person,
                                color: evBlue,
                              ),
                            ),
                            title: Text(
                              '${cliente['nombre'] ?? 'Sin nombre'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: evDark,
                              ),
                            ),
                            subtitle: Text(
                              '${cliente['email'] ?? 'Sin correo'}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudieron cargar los clientes: $e',
          ),
        ),
      );
    }
  },
),

            MenuCard(
              icon: Icons.directions_car,
              title: 'Vehículos',
              subtitle: 'Registrar y consultar vehículos',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const VehiclePage(),
                  ),
                );
              },
            ),

MenuCard(
  icon: Icons.qr_code_scanner,
  title: 'Escanear QR',
  subtitle: 'Identificar vehículo',
  iconColor: evBlue,
  onTap: () async {
  final resultado = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const QRScannerPage(),
    ),
  );

  if (resultado != null) {
    final codigo = resultado.toString();
    final partes = codigo.split('|');

    if (partes.length >= 2) {
      final parteVehiculo = partes[1];
      final idTexto =
          parteVehiculo.replaceFirst('vehiculo:', '');
      final idVehiculo = int.tryParse(idTexto);

      if (idVehiculo != null) {
        try {
          final vehiculos =
              await ApiService.obtenerVehiculos();

          final vehiculoEncontrado = vehiculos.firstWhere(
            (vehiculo) =>
                int.tryParse('${vehiculo['id']}') ==
                idVehiculo,
          );

          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Vehículo identificado'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${vehiculoEncontrado['marca']} '
                        '${vehiculoEncontrado['modelo']}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: evDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Placa: ${vehiculoEncontrado['placa']}',
                      ),
                      Text(
                        'Año: ${vehiculoEncontrado['anio']}',
                      ),
                      Text(
                        'Kilometraje: '
                        '${vehiculoEncontrado['kilometraje']} km',
                      ),
                      Text(
                        'VIN: ${vehiculoEncontrado['vin']}',
                      ),
                      Text(
                        'Batería: '
                        '${vehiculoEncontrado['bateria_kwh']} kWh',
                      ),
                      Text(
                        'Voltaje: '
                        '${vehiculoEncontrado['voltaje']} V',
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cerrar'),
                    ),
                  ],
                );
              },
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'No se pudo consultar el vehículo: $e',
                ),
              ),
            );
          }
        }
      }
    }
  }
},

),
            MenuCard(
              icon: Icons.event,
              title: 'Citas',
              subtitle: 'Consultar solicitudes de servicio',
              iconColor: evGreen,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MechanicAppointmentsPage(),
                  ),
                );
              },
            ),

MenuCard(
  icon: Icons.assignment_turned_in,
  title: 'Atenciones realizadas',
  subtitle: 'Consultar clientes y citas atendidas',
  iconColor: evGreen,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AtencionesRealizadasPage(),
      ),
    );
  },
),

            MenuCard(
              icon: Icons.battery_full,
              title: 'Baterías',
              subtitle: 'Gestionar información técnica',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BatteryPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.search,
              title: 'Diagnóstico',
              subtitle: 'Registrar diagnósticos técnicos',
              onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const DiagnosticoPage(),
      ),
    );
  },
),

            MenuCard(
  icon: Icons.build,
  title: 'Mantenimiento',
  subtitle: 'Registrar trabajos realizados',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const MantenimientoPage(),
      ),
    );
  },
),

            MenuCard(
  icon: Icons.battery_charging_full,
  title: 'Cambio de batería',
  subtitle: 'Registrar cambio de batería',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CambioBateriaPage(),
      ),
    );
  },
),

            MenuCard(
              icon: Icons.history,
              title: 'Historial completo',
              subtitle: 'Consultar historial técnico',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const HistoryPage(),
                  ),
                );
              },
            ),

            MenuCard(
              icon: Icons.picture_as_pdf,
              title: 'Documentos PDF',
              subtitle: 'Consultar informes de servicio',
              iconColor: Colors.red,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DocumentsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



// ============================================================
// MENSAJE
// ============================================================

void showInfo(BuildContext context, String module) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        '$module: se desarrollará en la siguiente etapa.',
      ),
    ),
  );
}
class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final anioController = TextEditingController();
  final placaController = TextEditingController();
  final kilometrajeController = TextEditingController();
  final vinController = TextEditingController();
  final bateriaController = TextEditingController();
  final voltajeController = TextEditingController();

  bool guardando = false;

  Future<void> guardarVehiculo() async {
    if (SesionUsuario.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay un usuario conectado'),
        ),
      );
      return;
    }

    final marca = marcaController.text.trim();
    final modelo = modeloController.text.trim();
    final anioTexto = anioController.text.trim();
    final placa = placaController.text.trim();
    final kilometrajeTexto = kilometrajeController.text.trim();
    final vin = vinController.text.trim();
    final bateriaTexto = bateriaController.text.trim();
    final voltajeTexto = voltajeController.text.trim();

    if (marca.isEmpty ||
        modelo.isEmpty ||
        anioTexto.isEmpty ||
        placa.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete marca, modelo, año y placa'),
        ),
      );
      return;
    }

    final anio = int.tryParse(anioTexto);
    final kilometraje =
        double.tryParse(kilometrajeTexto.isEmpty ? '0' : kilometrajeTexto);
    final bateria =
        double.tryParse(bateriaTexto.isEmpty ? '0' : bateriaTexto);
    final voltaje =
        double.tryParse(voltajeTexto.isEmpty ? '0' : voltajeTexto);

    if (anio == null ||
        kilometraje == null ||
        bateria == null ||
        voltaje == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Revise los valores numéricos ingresados'),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      final resultado = await ApiService.registrarVehiculo(
        SesionUsuario.id!,
        marca,
        modelo,
        anio,
        placa,
        kilometraje,
        vin,
        bateria,
        voltaje,
      );

      if (!mounted) return;

      if (resultado['estado'] == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Vehículo registrado correctamente'),
          ),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado['mensaje'] ??
                  'No se pudo registrar el vehículo',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo conectar con el servidor: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Agregar vehículo'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca',
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: modeloController,
              decoration: const InputDecoration(
                labelText: 'Modelo',
                prefixIcon: Icon(Icons.electric_car),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: anioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Año',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: placaController,
              decoration: const InputDecoration(
                labelText: 'Placa',
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: kilometrajeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilometraje',
                prefixIcon: Icon(Icons.speed),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: vinController,
              decoration: const InputDecoration(
                labelText: 'VIN',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: bateriaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Batería (kWh)',
                prefixIcon: Icon(Icons.battery_charging_full),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: voltajeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Voltaje (V)',
                prefixIcon: Icon(Icons.bolt),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: guardando ? null : guardarVehiculo,
                icon: guardando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  guardando
                      ? 'Guardando...'
                      : 'Guardar vehículo',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class EditVehiclePage extends StatefulWidget {
  final Map<String, dynamic> vehiculo;

  const EditVehiclePage({
    super.key,
    required this.vehiculo,
  });

  @override
  State<EditVehiclePage> createState() => _EditVehiclePageState();
}

class _EditVehiclePageState extends State<EditVehiclePage> {
  late final TextEditingController marcaController;
  late final TextEditingController modeloController;
  late final TextEditingController anioController;
  late final TextEditingController placaController;
  late final TextEditingController kilometrajeController;
  late final TextEditingController vinController;
  late final TextEditingController bateriaController;
  late final TextEditingController voltajeController;

  bool guardando = false;

  @override
  void initState() {
    super.initState();

    final vehiculo = widget.vehiculo;

    marcaController =
        TextEditingController(text: '${vehiculo['marca'] ?? ''}');
    modeloController =
        TextEditingController(text: '${vehiculo['modelo'] ?? ''}');
    anioController =
        TextEditingController(text: '${vehiculo['anio'] ?? ''}');
    placaController =
        TextEditingController(text: '${vehiculo['placa'] ?? ''}');
    kilometrajeController =
        TextEditingController(text: '${vehiculo['kilometraje'] ?? ''}');
    vinController =
        TextEditingController(text: '${vehiculo['vin'] ?? ''}');
    bateriaController =
        TextEditingController(text: '${vehiculo['bateria_kwh'] ?? ''}');
    voltajeController =
        TextEditingController(text: '${vehiculo['voltaje'] ?? ''}');
  }

  Future<void> actualizarVehiculo() async {
    final marca = marcaController.text.trim();
    final modelo = modeloController.text.trim();
    final anioTexto = anioController.text.trim();
    final placa = placaController.text.trim();
    final kilometrajeTexto = kilometrajeController.text.trim();
    final vin = vinController.text.trim();
    final bateriaTexto = bateriaController.text.trim();
    final voltajeTexto = voltajeController.text.trim();

    if (marca.isEmpty ||
        modelo.isEmpty ||
        anioTexto.isEmpty ||
        placa.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Complete marca, modelo, año y placa',
          ),
        ),
      );
      return;
    }

    final anio = int.tryParse(anioTexto);
    final kilometraje = double.tryParse(
      kilometrajeTexto.isEmpty ? '0' : kilometrajeTexto,
    );
    final bateria = double.tryParse(
      bateriaTexto.isEmpty ? '0' : bateriaTexto,
    );
    final voltaje = double.tryParse(
      voltajeTexto.isEmpty ? '0' : voltajeTexto,
    );

    if (anio == null ||
        kilometraje == null ||
        bateria == null ||
        voltaje == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Revise los valores numéricos ingresados',
          ),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      final resultado = await ApiService.actualizarVehiculo(
        widget.vehiculo['id'],
        marca,
        modelo,
        anio,
        placa,
        kilometraje,
        vin,
        bateria,
        voltaje,
      );

      if (!mounted) return;

      if (resultado['estado'] == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Vehículo actualizado correctamente',
            ),
          ),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado['mensaje'] ??
                  'No se pudo actualizar el vehículo',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo conectar con el servidor: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    marcaController.dispose();
    modeloController.dispose();
    anioController.dispose();
    placaController.dispose();
    kilometrajeController.dispose();
    vinController.dispose();
    bateriaController.dispose();
    voltajeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Editar vehículo'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca',
                prefixIcon: Icon(Icons.directions_car),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: modeloController,
              decoration: const InputDecoration(
                labelText: 'Modelo',
                prefixIcon: Icon(Icons.electric_car),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: anioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Año',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: placaController,
              decoration: const InputDecoration(
                labelText: 'Placa',
                prefixIcon: Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: kilometrajeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilometraje',
                prefixIcon: Icon(Icons.speed),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: vinController,
              decoration: const InputDecoration(
                labelText: 'VIN',
                prefixIcon: Icon(Icons.confirmation_number),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: bateriaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Batería (kWh)',
                prefixIcon: Icon(Icons.battery_charging_full),
              ),
            ),
            const SizedBox(height: 14),

            TextField(
              controller: voltajeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Voltaje (V)',
                prefixIcon: Icon(Icons.bolt),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: guardando
                    ? null
                    : actualizarVehiculo,
                icon: guardando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.save),
                label: Text(
                  guardando
                      ? 'Guardando...'
                      : 'Guardar cambios',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/////////////////////////////////
///DIAGNOSTICO
////////////////////////////////////
class DiagnosticoPage extends StatefulWidget {
  const DiagnosticoPage({super.key});

  @override
  State<DiagnosticoPage> createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  late Future<List<dynamic>> vehiculosFuture;

  int? vehiculoSeleccionado;
  int? propietarioSeleccionadoId;

  final descripcionController = TextEditingController();
  final kilometrajeController = TextEditingController();
  final resultadoController = TextEditingController();
  final observacionesController = TextEditingController();

  bool guardando = false;

  @override
  void initState() {
    super.initState();

    if (SesionUsuario.id == null) {
      vehiculosFuture = Future.error(
        Exception('No hay un usuario conectado'),
      );
    } else {
      vehiculosFuture = ApiService.obtenerVehiculos();
    }
  }

  Future<void> guardarDiagnostico() async {
    if (SesionUsuario.id == null) {
      return;
    }

    if (vehiculoSeleccionado == null ||
         propietarioSeleccionadoId == null ||
        descripcionController.text.trim().isEmpty ||
        resultadoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleccione un vehículo y complete descripción y resultado',
          ),
        ),
      );
      return;
    }

    final kilometraje = double.tryParse(
      kilometrajeController.text.trim().isEmpty
          ? '0'
          : kilometrajeController.text.trim(),
    );

    if (kilometraje == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un kilometraje válido'),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      final resultado = await ApiService.registrarDiagnostico(
        propietarioSeleccionadoId!,
        vehiculoSeleccionado!,
        descripcionController.text.trim(),
        kilometraje,
        resultadoController.text.trim(),
        observacionesController.text.trim(),
        SesionUsuario.id!, 
      );

      if (!mounted) return;

      if (resultado['estado'] == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Diagnóstico registrado correctamente',
            ),
          ),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado['mensaje'] ??
                  'No se pudo registrar el diagnóstico',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo conectar con el servidor: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    descripcionController.dispose();
    kilometrajeController.dispose();
    resultadoController.dispose();
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Diagnóstico'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: vehiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'No se pudieron cargar los vehículos.\n\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final vehiculos = snapshot.data ?? [];

          if (vehiculos.isEmpty) {
            return const Center(
              child: Text(
                'No hay vehículos registrados.',
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registro de diagnóstico',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Registre el diagnóstico técnico realizado al vehículo.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<int>(
                  initialValue: vehiculoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Vehículo',
                    prefixIcon:
                        Icon(Icons.electric_car),
                    border: OutlineInputBorder(),
                  ),
                  items: vehiculos.map((vehiculo) {
                    return DropdownMenuItem<int>(
                      value: vehiculo['id'],
                      child: Text(
                        '${vehiculo['marca']} '
                        '${vehiculo['modelo']} - '
                        '${vehiculo['placa']}',
                      ),
                    );
                  }).toList(),
                  onChanged: (valor) {
  final vehiculo = vehiculos.firstWhere(
    (v) => v['id'] == valor,
  );

  setState(() {
    vehiculoSeleccionado = valor;
    propietarioSeleccionadoId = vehiculo['usuario_id'];
  });
},
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripción del diagnóstico',
                    hintText:
                        'Describa la falla o condición encontrada',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: kilometrajeController,
                  keyboardType:
                      TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kilometraje',
                    prefixIcon: Icon(Icons.speed),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: resultadoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Resultado',
                    hintText:
                        'Indique el resultado del diagnóstico',
                    prefixIcon:
                        Icon(Icons.assignment_turned_in),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: observacionesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Observaciones',
                    hintText:
                        'Observaciones adicionales',
                    prefixIcon: Icon(Icons.notes),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: guardando
                        ? null
                        : guardarDiagnostico,
                    icon: guardando
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                      guardando
                          ? 'Guardando...'
                          : 'Registrar diagnóstico',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// MantenimientoPage

class MantenimientoPage extends StatefulWidget {
  const MantenimientoPage({super.key});

  @override
  State<MantenimientoPage> createState() => _MantenimientoPageState();
}

class _MantenimientoPageState extends State<MantenimientoPage> {
  late Future<List<dynamic>> vehiculosFuture;

  int? vehiculoSeleccionado;
  int? propietarioSeleccionadoId; 

  final descripcionController = TextEditingController();
  final kilometrajeController = TextEditingController();
  final resultadoController = TextEditingController();
  final observacionesController = TextEditingController();

  bool guardando = false;

  @override
  void initState() {
    super.initState();

    if (SesionUsuario.id == null) {
      vehiculosFuture = Future.error(
        Exception('No hay un usuario conectado'),
      );
    } else {
      vehiculosFuture = ApiService.obtenerVehiculos();
    }
  }

  Future<void> guardarMantenimiento() async {
    if (SesionUsuario.id == null) {
      return;
    }

    if (vehiculoSeleccionado == null ||
        propietarioSeleccionadoId == null ||
        descripcionController.text.trim().isEmpty ||
        resultadoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleccione un vehículo y complete descripción y resultado',
          ),
        ),
      );
      return;
    }

    final kilometraje = double.tryParse(
      kilometrajeController.text.trim().isEmpty
          ? '0'
          : kilometrajeController.text.trim(),
    );

    if (kilometraje == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un kilometraje válido'),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      final resultado =
          await ApiService.registrarMantenimiento(
        propietarioSeleccionadoId!,
        vehiculoSeleccionado!,
        descripcionController.text.trim(),
        kilometraje,
        resultadoController.text.trim(),
        observacionesController.text.trim(),
        SesionUsuario.id!,
      );

      if (!mounted) return;

      if (resultado['estado'] == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Mantenimiento registrado correctamente',
            ),
          ),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado['mensaje'] ??
                  'No se pudo registrar el mantenimiento',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo conectar con el servidor: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    descripcionController.dispose();
    kilometrajeController.dispose();
    resultadoController.dispose();
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Mantenimiento'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: vehiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'No se pudieron cargar los vehículos.\n\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final vehiculos = snapshot.data ?? [];

          if (vehiculos.isEmpty) {
            return const Center(
              child: Text(
                'No hay vehículos registrados.',
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registro de mantenimiento',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Registre el trabajo de mantenimiento realizado al vehículo.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<int>(
                  initialValue: vehiculoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Vehículo',
                    prefixIcon:
                        Icon(Icons.electric_car),
                    border: OutlineInputBorder(),
                  ),
                  items: vehiculos.map((vehiculo) {
                    return DropdownMenuItem<int>(
                      value: vehiculo['id'],
                      child: Text(
                        '${vehiculo['marca']} '
                        '${vehiculo['modelo']} - '
                        '${vehiculo['placa']}',
                      ),
                    );
                  }).toList(),
                  onChanged: (valor) {
  if (valor == null) {
    setState(() {
      vehiculoSeleccionado = null;
      propietarioSeleccionadoId = null;
    });
    return;
  }

  final vehiculo = vehiculos.firstWhere(
    (v) => v['id'] == valor,
  );

  setState(() {
    vehiculoSeleccionado = valor;
    propietarioSeleccionadoId = vehiculo['usuario_id'];
  });
},
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText:
                        'Descripción del mantenimiento',
                    hintText:
                        'Describa los trabajos realizados',
                    prefixIcon:
                        Icon(Icons.build),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: kilometrajeController,
                  keyboardType:
                      TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kilometraje',
                    prefixIcon:
                        Icon(Icons.speed),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: resultadoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Resultado',
                    hintText:
                        'Indique el resultado del mantenimiento',
                    prefixIcon:
                        Icon(Icons.assignment_turned_in),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: observacionesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Observaciones',
                    hintText:
                        'Observaciones adicionales',
                    prefixIcon:
                        Icon(Icons.notes),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: guardando
                        ? null
                        : guardarMantenimiento,
                    icon: guardando
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.save),
                    label: Text(
                      guardando
                          ? 'Guardando...'
                          : 'Registrar mantenimiento',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
  //////////////////////
  ///CAMBIO DE BATERIA
  ///////////////////////
class CambioBateriaPage extends StatefulWidget {
  const CambioBateriaPage({super.key});

  @override
  State<CambioBateriaPage> createState() => _CambioBateriaPageState();
}


class _CambioBateriaPageState extends State<CambioBateriaPage> {
  late Future<List<dynamic>> vehiculosFuture;

  int? vehiculoSeleccionado;
  int? propietarioSeleccionadoId;

  final descripcionController = TextEditingController();
  final kilometrajeController = TextEditingController();
  final resultadoController = TextEditingController();
  final observacionesController = TextEditingController();

  bool guardando = false;

  @override
  void initState() {
    super.initState();

    if (SesionUsuario.id == null) {
      vehiculosFuture = Future.error(
        Exception('No hay un usuario conectado'),
      );
    } else {
      vehiculosFuture = ApiService.obtenerVehiculos();
    }
  }

  Future<void> guardarCambioBateria() async {
    if (SesionUsuario.id == null) {
      return;
    }

    if (vehiculoSeleccionado == null ||
        propietarioSeleccionadoId == null ||
        descripcionController.text.trim().isEmpty ||
        resultadoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seleccione un vehículo y complete descripción y resultado',
          ),
        ),
      );
      return;
    }

    final kilometraje = double.tryParse(
      kilometrajeController.text.trim().isEmpty
          ? '0'
          : kilometrajeController.text.trim(),
    );

    if (kilometraje == null || kilometraje < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingrese un kilometraje válido'),
        ),
      );
      return;
    }

    setState(() {
      guardando = true;
    });

    try {
      final resultado = await ApiService.registrarCambioBateria(
        propietarioSeleccionadoId!,
        vehiculoSeleccionado!,
        descripcionController.text.trim(),
        kilometraje,
        resultadoController.text.trim(),
        observacionesController.text.trim(),
        SesionUsuario.id!,
      );

      if (!mounted) return;

      if (resultado['estado'] == 'OK') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Cambio de batería registrado correctamente',
            ),
          ),
        );

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              resultado['mensaje'] ??
                  'No se pudo registrar el cambio de batería',
            ),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No se pudo conectar con el servidor: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          guardando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    descripcionController.dispose();
    kilometrajeController.dispose();
    resultadoController.dispose();
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: evLight,
      appBar: AppBar(
        title: const Text('Cambio de batería'),
        backgroundColor: evDark,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: vehiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'No se pudieron cargar los vehículos.\n\n'
                '${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final vehiculos = snapshot.data ?? [];

          if (vehiculos.isEmpty) {
            return const Center(
              child: Text('No hay vehículos registrados.'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registro de cambio de batería',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: evDark,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Registre el cambio o reemplazo de la batería del vehículo.',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<int>(
                  initialValue: vehiculoSeleccionado,
                  decoration: const InputDecoration(
                    labelText: 'Vehículo',
                    prefixIcon: Icon(Icons.electric_car),
                    border: OutlineInputBorder(),
                  ),
                  items: vehiculos.map((vehiculo) {
                    return DropdownMenuItem<int>(
                      value: vehiculo['id'],
                      child: Text(
                        '${vehiculo['marca']} '
                        '${vehiculo['modelo']} - '
                        '${vehiculo['placa']}',
                      ),
                    );
                  }).toList(),
                  onChanged: (valor) {
                    if (valor == null) {
                      setState(() {
                        vehiculoSeleccionado = null;
                        propietarioSeleccionadoId = null;
                      });
                      return;
                    }

                    final vehiculo = vehiculos.firstWhere(
                      (v) => v['id'] == valor,
                    );

                    setState(() {
                      vehiculoSeleccionado = valor;
                      propietarioSeleccionadoId =
                          vehiculo['usuario_id'];
                    });
                  },
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripción del cambio',
                    hintText: 'Describa el cambio de batería realizado',
                    prefixIcon: Icon(Icons.battery_charging_full),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: kilometrajeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Kilometraje',
                    prefixIcon: Icon(Icons.speed),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: resultadoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Resultado',
                    hintText: 'Indique el resultado del cambio de batería',
                    prefixIcon: Icon(Icons.assignment_turned_in),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: observacionesController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Observaciones',
                    hintText: 'Observaciones adicionales',
                    prefixIcon: Icon(Icons.notes),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: guardando
                        ? null
                        : guardarCambioBateria,
                    icon: guardando
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.battery_charging_full),
                    label: Text(
                      guardando
                          ? 'Guardando...'
                          : 'Registrar cambio de batería',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


class AtencionesRealizadasPage extends StatefulWidget {
  const AtencionesRealizadasPage({super.key});

  @override
  State<AtencionesRealizadasPage> createState() =>
      _AtencionesRealizadasPageState();
}

class _AtencionesRealizadasPageState
    extends State<AtencionesRealizadasPage> {
  late Future<List<dynamic>> atencionesFuture;

  String busqueda = '';
  String anioSeleccionado = 'Todos';

  @override
  void initState() {
    super.initState();
    atencionesFuture = ApiService.obtenerCitas();
  }

  Future<void> recargarAtenciones() async {
    setState(() {
      atencionesFuture = ApiService.obtenerCitas();
    });

    await atencionesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atenciones realizadas'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: atencionesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'No se pudieron cargar las atenciones: '
                '${snapshot.error}',
              ),
            );
          }

          final todas = snapshot.data ?? [];

          final atendidas = todas.where((cita) {
            return cita['estado'] == 'Atendida';
          }).toList();

          atendidas.sort((a, b) {
            final fechaA =
                '${a['fecha'] ?? ''} ${a['hora'] ?? ''}';
            final fechaB =
                '${b['fecha'] ?? ''} ${b['hora'] ?? ''}';

            return fechaB.compareTo(fechaA);
          });

          final anios = atendidas
              .map((cita) =>
                  '${cita['fecha'] ?? ''}'.split('-').first)
              .where((anio) => anio.isNotEmpty)
              .toSet()
              .toList()
            ..sort((a, b) => b.compareTo(a));

          final filtradas = atendidas.where((cita) {
            final cliente =
                '${cita['cliente'] ?? ''}'.toLowerCase();
            final placa =
                '${cita['placa'] ?? ''}'.toLowerCase();
            final mecanico =
                '${cita['mecanico'] ?? ''}'.toLowerCase();

            final texto = busqueda.toLowerCase();

            final coincideBusqueda =
                cliente.contains(texto) ||
                placa.contains(texto) ||
                mecanico.contains(texto);

            final anio =
                '${cita['fecha'] ?? ''}'.split('-').first;

            final coincideAnio =
                anioSeleccionado == 'Todos' ||
                anioSeleccionado == anio;

            return coincideBusqueda && coincideAnio;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText:
                            'Buscar cliente, placa o mecánico',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (valor) {
                        setState(() {
                          busqueda = valor.trim();
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue:
                          anios.contains(anioSeleccionado)
                              ? anioSeleccionado
                              : 'Todos',
                      decoration: const InputDecoration(
                        labelText: 'Filtrar por año',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month),
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: 'Todos',
                          child: Text('Todos los años'),
                        ),
                        ...anios.map(
                          (anio) => DropdownMenuItem(
                            value: anio,
                            child: Text(anio),
                          ),
                        ),
                      ],
                      onChanged: (valor) {
                        setState(() {
                          anioSeleccionado = valor ?? 'Todos';
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Atenciones encontradas: '
                      '${filtradas.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: evDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: recargarAtenciones,
                  child: filtradas.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 100),
                            Center(
                              child: Text(
                                'No hay atenciones para mostrar.',
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          itemCount: filtradas.length,
                          itemBuilder: (context, index) {
                            final cita = filtradas[index];

                            return Card(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${cita['servicio'] ?? 'Servicio'}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: evDark,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Cliente: '
                                      '${cita['cliente'] ?? 'Sin nombre'}',
                                    ),
                                    Text(
                                      'Vehículo: '
                                      '${cita['marca'] ?? ''} '
                                      '${cita['modelo'] ?? ''}',
                                    ),
                                    Text(
                                      'Placa: '
                                      '${cita['placa'] ?? ''}',
                                    ),
                                    Text(
                                      'Fecha: '
                                      '${cita['fecha'] ?? ''}',
                                    ),
                                    Text(
                                      'Hora: '
                                      '${cita['hora'] ?? ''}',
                                    ),
                                    Text(
                                      'Atendido por: '
                                      '${cita['mecanico'] ?? 'No registrado'}',
                                      style: const TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        color: evBlue,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: evGreen,
                                          size: 18,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          'Atendida',
                                          style: TextStyle(
                                            color: evGreen,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}