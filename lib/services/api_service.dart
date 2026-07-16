import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Flutter Web
  static const baseUrl = "http://127.0.0.1:8000";

  // Android Emulator
  // static const String baseUrl = "http://10.0.2.2:8000";

  // Physical Device
  // static const String baseUrl = "http://YOUR_IP:8000";

  // ================= DASHBOARD =================

  static Future<Map<String, dynamic>> getDashboardData() async {
    final response = await http.get(Uri.parse("$baseUrl/"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load dashboard");
  }

  // ================= MESSAGES =================

  static Future<List<dynamic>> getMessages() async {
    final response = await http.get(
      Uri.parse("$baseUrl/messages"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load messages");
  }

  // ================= SOS =================

  static Future<List<dynamic>> getSOSAlerts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/sos"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load SOS alerts");
  }

  static Future<void> createSOSAlert() async {
    final response = await http.post(
      Uri.parse("$baseUrl/sos"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": 1,
        "alert_type": "Emergency",
        "latitude": 18.5204,
        "longitude": 73.8567,
        "battery_level": 85,
        "status": "ACTIVE",
        "timestamp": DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Failed to send SOS");
    }
  }

  // ================= MAP =================

  static Future<Map<String, dynamic>> getMapData() async {
    final response = await http.get(
      Uri.parse("$baseUrl/map-data"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load map");
  }

  // ================= COMMUNITY HUBS =================

  static Future<List<dynamic>> getCommunityHubs() async {
    final response = await http.get(
      Uri.parse("$baseUrl/community-hubs"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load community hubs");
  }

  // ================= KNOWLEDGE VAULT =================

  static Future<List<dynamic>> getKnowledgeArticles() async {
    final response = await http.get(
      Uri.parse("$baseUrl/vaults"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load vault");
  }

  // ================= VOICE CAPSULES =================

  static Future<List<dynamic>> getVoiceCapsules() async {
    final response = await http.get(
      Uri.parse("$baseUrl/voice-capsules"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load voice capsules");
  }

  static Future<void> createVoiceCapsule(
    String sender,
    String transcript,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/voice-capsules"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "sender": sender,
        "duration": transcript.length,
        "transcript": transcript,
      }),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw Exception("Failed to create voice capsule");
    }
  }

  // ================= VERIFIED ORGANIZATIONS =================

  static Future<List<dynamic>> getVerifiedOrganizations() async {
    final response = await http.get(
      Uri.parse("$baseUrl/verified-organizations"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load organizations");
  }

  // ================= TRANSLATION =================

  static Future<Map<String, dynamic>> translateText(
    String text,
    String language,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/translate"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "text": text,
        "source_language": "en",
        "target_language": language,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Translation failed");
  }

// ================= SEND MESSAGE =================

  static Future<void> sendMessage(
  String title,
  String content,
  String author,
) async {

  final response = await http.post(
    Uri.parse("$baseUrl/messages"),
    headers: {
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      "title": title,
      "content": content,
      "author": author,
      "timestamp": DateTime.now().toIso8601String(),
      "priority_level": "HIGH",
    }),
  );

  if (response.statusCode != 200 &&
      response.statusCode != 201) {
    throw Exception(
      "Failed to send message: ${response.body}",
    );
  }
}

static Future<void> createCommunityHub(
  String hubName,
  String location,
) async {

  final response = await http.post(
    Uri.parse("$baseUrl/community-hubs"),

    headers: {
      "Content-Type": "application/json",
    },

    body: jsonEncode({
      "hub_name": hubName,
      "location": location,
      "latitude": 18.5204,
      "longitude": 73.8567,
      "members": 0,
      "trust_score": 100,
      "status": "ACTIVE",
    }),
  );

  if (response.statusCode != 200 &&
      response.statusCode != 201) {
    throw Exception("Failed to create hub");
  }
}

static Future<void> createArticle(
  String title,
  String category,
  String content,
) async {

  final response = await http.post(
    Uri.parse("$baseUrl/vaults"),

    headers: {
      "Content-Type": "application/json",
    },

    body: jsonEncode({
      "title": title,
      "category": category,
      "content": content,
    }),
  );

  if (response.statusCode != 200 &&
      response.statusCode != 201) {
    throw Exception("Failed to create article");
  }
}

static Future<List<dynamic>>
getMissingPersons() async {

  final response = await http.get(
    Uri.parse("$baseUrl/missing-persons"),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  throw Exception(
    "Failed to load missing persons",
  );
}

static Future<void>
createMissingPerson(
  String name,
  int age,
  String description,
  String lastSeenLocation,
) async {

  final response = await http.post(

    Uri.parse(
      "$baseUrl/missing-persons",
    ),

    headers: {
      "Content-Type":
          "application/json",
    },

    body: jsonEncode({

      "name": name,

      "age": age,

      "description":
          description,

      "last_seen_location":
          lastSeenLocation,

      "last_seen_time":
          DateTime.now()
              .toString(),

      "contact_number":
          "9876543210",

      "latitude": 18.5204,

      "longitude": 73.8567,

      "status": "MISSING",
    }),
  );

  if (response.statusCode != 200 &&
      response.statusCode != 201) {

    throw Exception(
      "Failed to create report",
    );
  }
}
}