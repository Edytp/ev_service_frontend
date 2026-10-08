import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<List<dynamic>> obtenerUsuarios() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/usuarios'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al consultar usuarios');
    }
  }

  static Future<List<dynamic>> obtenerVehiculos() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/vehiculos'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al consultar vehículos');
    }
  }

static Future<List<dynamic>> obtenerVehiculosPorUsuario(
  int usuarioId,
) async {
  final response = await http.get(
    Uri.parse(
      '$baseUrl/api/vehiculos/usuario/$usuarioId',
    ),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
      'Error al consultar los vehículos del usuario',
    );
  }
}

static Future<Map<String, dynamic>> registrarVehiculo(
  int usuarioId,
  String marca,
  String modelo,
  int anio,
  String placa,
  double kilometraje,
  String vin,
  double bateriaKwh,
  double voltaje,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/vehiculos'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'usuario_id': usuarioId,
      'marca': marca,
      'modelo': modelo,
      'anio': anio,
      'placa': placa,
      'kilometraje': kilometraje,
      'vin': vin,
      'bateria_kwh': bateriaKwh,
      'voltaje': voltaje,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 201) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ?? 'Error al registrar el vehículo',
    };
  }
}

static Future<Map<String, dynamic>> actualizarVehiculo(
  int vehiculoId,
  String marca,
  String modelo,
  int anio,
  String placa,
  double kilometraje,
  String vin,
  double bateriaKwh,
  double voltaje,
) async {
  final response = await http.put(
    Uri.parse('$baseUrl/api/vehiculos/$vehiculoId'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'marca': marca,
      'modelo': modelo,
      'anio': anio,
      'placa': placa,
      'kilometraje': kilometraje,
      'vin': vin,
      'bateria_kwh': bateriaKwh,
      'voltaje': voltaje,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ??
          'Error al actualizar el vehículo',
    };
  }
}

static Future<List<dynamic>> obtenerCitas() async {
  final response = await http.get(
    Uri.parse('$baseUrl/api/citas'),
  );

  if (response.statusCode == 200) {
    final datos = jsonDecode(response.body);

    if (datos is Map<String, dynamic> && datos['value'] is List) {
      return datos['value'];
    }

    if (datos is List) {
      return datos;
    }

    throw Exception('Formato de respuesta de citas no válido');
  } else {
    throw Exception('Error al consultar citas');
  }
}

static Future<Map<String, dynamic>> confirmarCita(
  int citaId,
  int mecanicoId,
) async {
  final response = await http.put(
    Uri.parse(
      '$baseUrl/api/citas/$citaId/confirmar',
    ),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'mecanico_id': mecanicoId,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return datos;
  }

  return {
    'estado': 'ERROR',
    'mensaje': datos['mensaje'] ??
        'No se pudo confirmar la cita',
  };
}

static Future<Map<String, dynamic>> atenderCita(
  int citaId,
) async {
  final response = await http.put(
    Uri.parse(
      '$baseUrl/api/citas/$citaId/atender',
    ),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return datos;
  }

  return {
    'estado': 'ERROR',
    'mensaje': datos['mensaje'] ??
        'No se pudo marcar la cita como atendida',
  };
}

  static Future<List<dynamic>> obtenerHistorial() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/historial'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al consultar historial');
    }
  }

  // ============================================================
  // LOGIN
  // ============================================================

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final datos = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return datos;
    } else {
      return {
        'estado': 'ERROR',
        'mensaje': datos['mensaje'] ?? 'Error al iniciar sesión',
      };
    }
  }

  // ============================================================
  // REGISTRO DE USUARIO
  // ============================================================

  static Future<Map<String, dynamic>> registrarUsuario(
    String nombre,
    String email,
    String password,
    String rol,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/usuarios'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nombre': nombre,
        'email': email,
        'password': password,
        'rol': rol,
      }),
    );

    final datos = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return datos;
    } else {
      return {
        'estado': 'ERROR',
        'mensaje': datos['mensaje'] ?? 'Error al registrar usuario',
      };
    }
  }
  static Future<Map<String, dynamic>> eliminarVehiculo(
  int vehiculoId,
) async {
  final response = await http.delete(
    Uri.parse(
      '$baseUrl/api/vehiculos/$vehiculoId',
    ),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ??
          'Error al eliminar el vehículo',
    };
  }
 }
 static Future<List<dynamic>> obtenerCitasPorUsuario(
  int usuarioId,
) async {
  final response = await http.get(
    Uri.parse(
      '$baseUrl/api/citas/usuario/$usuarioId',
    ),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
      'Error al consultar las citas del usuario',
    );
  }
}

static Future<Map<String, dynamic>> registrarCita(
  int usuarioId,
  int vehiculoId,
  String servicio,
  String fecha,
  String hora,
  String descripcion,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/citas'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'usuario_id': usuarioId,
      'vehiculo_id': vehiculoId,
      'servicio': servicio,
      'fecha': fecha,
      'hora': hora,
      'descripcion': descripcion,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 201) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ??
          'Error al registrar la cita',
    };
  }
 }


 static Future<List<dynamic>> obtenerHistorialPorUsuario(
  int usuarioId,
) async {
  final response = await http.get(
    Uri.parse(
      '$baseUrl/api/historial/usuario/$usuarioId',
    ),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
      'Error al consultar el historial del usuario',
    );
  }
 }
 
 
 static Future<Map<String, dynamic>> registrarDiagnostico(
  int usuarioId,
  int vehiculoId,
  String descripcion,
  double kilometraje,
  String resultado,
  String observaciones,
  int mecanicoId,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/diagnosticos'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'usuario_id': usuarioId,
      'vehiculo_id': vehiculoId,
      'mecanico_id': mecanicoId,
      'descripcion': descripcion,
      'kilometraje': kilometraje,
      'resultado': resultado,
      'observaciones': observaciones,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 201) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ??
          'Error al registrar el diagnóstico',
    };
  }
 }
 
 static Future<Map<String, dynamic>> registrarMantenimiento(
  int usuarioId,
  int vehiculoId,
  String descripcion,
  double kilometraje,
  String resultado,
  String observaciones,
  int mecanicoId, 
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/mantenimientos'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'usuario_id': usuarioId,
      'vehiculo_id': vehiculoId,
      'mecanico_id': mecanicoId,
      'descripcion': descripcion,
      'kilometraje': kilometraje,
      'resultado': resultado,
      'observaciones': observaciones,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 201) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ??
          'Error al registrar el mantenimiento',
    };
  }
 }


static Future<Map<String, dynamic>> registrarCambioBateria(
  int usuarioId,
  int vehiculoId,
  String descripcion,
  double kilometraje,
  String resultado,
  String observaciones,
  int mecanicoId,
) async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/cambios-bateria'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'usuario_id': usuarioId,
      'vehiculo_id': vehiculoId,
      'mecanico_id': mecanicoId,
      'descripcion': descripcion,
      'kilometraje': kilometraje,
      'resultado': resultado,
      'observaciones': observaciones,
    }),
  );

  final datos = jsonDecode(response.body);

  if (response.statusCode == 201) {
    return datos;
  } else {
    return {
      'estado': 'ERROR',
      'mensaje': datos['mensaje'] ??
          'Error al registrar el cambio de batería',
    };
  }
 }
}
