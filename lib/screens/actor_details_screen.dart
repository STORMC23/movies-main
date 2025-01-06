import 'package:flutter/material.dart';
import 'package:movies/api/api.dart';
class ActorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> actor;

  const ActorDetailsScreen({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(actor['name']),
        backgroundColor: const Color(0xFF0296E5),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (actor['profile_path'] != null)
              Image.network(
                '${Api.imageBaseUrl}${actor['profile_path']}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actor['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Popularitat: ${actor['popularity'].toStringAsFixed(1)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Conegut per:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    actor['known_for']
                            ?.map((movie) => movie['title'] ?? movie['name'])
                            ?.join(", ") ??
                        "No disponible",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
