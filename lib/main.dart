import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TravelPlanApp());
}

class TravelPlanApp extends StatelessWidget {
  const TravelPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Plan',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
      ),
      home: const DestinationApiScreen(),
    );
  }
}

// Model for API response
class TravelPost {
  final int id;
  final String title;
  final String description;

  const TravelPost({
    required this.id,
    required this.title,
    required this.description,
  });

  factory TravelPost.fromJson(Map<String, dynamic> json) {
    return TravelPost(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['body'] as String,
    );
  }
}

// Fetch data from the REST API
class TravelApiService {
  static Future<List<TravelPost>> fetchDestinations() async {
    final response = await http
        .get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      return data
          .map(
            (item) => TravelPost.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList();
    } else {
      throw Exception('Unable to load data from the API');
    }
  }
}

class DestinationApiScreen extends StatefulWidget {
  const DestinationApiScreen({super.key});

  @override
  State<DestinationApiScreen> createState() =>
      _DestinationApiScreenState();
}

class _DestinationApiScreenState extends State<DestinationApiScreen> {
  late Future<List<TravelPost>> _destinationFuture;

  @override
  void initState() {
    super.initState();
    _loadDestinations();
  }

  void _loadDestinations() {
    _destinationFuture = TravelApiService.fetchDestinations();
  }

  Future<void> _refresh() async {
    setState(_loadDestinations);
    await _destinationFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Destinations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(_loadDestinations);
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<TravelPost>>(
          future: _destinationFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Discovering destinations...'),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 100),
                  const Icon(
                    Icons.cloud_off,
                    size: 60,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Unable to load destinations.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text('Check your internet connection and retry.'),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(_loadDestinations);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                    ),
                  ),
                ],
              );
            }

            final posts = snapshot.data ?? [];

            if (posts.isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(18),
              children: [
                const Text(
                  'Find Your Next Adventure ✈️',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Destination information loaded from a REST API.',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cloud_download_outlined,
                        size: 38,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          '${posts.length} records fetched successfully',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ...posts.asMap().entries.map((entry) {
                  final index = entry.key;
                  final post = entry.value;

                  final icons = [
                    Icons.beach_access,
                    Icons.landscape,
                    Icons.terrain,
                    Icons.location_city,
                    Icons.wb_sunny,
                  ];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 14),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                Colors.teal.withValues(alpha: 0.12),
                            child: Icon(
                              icons[index % icons.length],
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'API RECORD ${post.id}',
                                  style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  post.description,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Powered by REST API • JSON data',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}