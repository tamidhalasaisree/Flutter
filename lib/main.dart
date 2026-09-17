import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFFF7FAF9),
      ),

      // Named routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/destinations': (context) => const DestinationsScreen(),
        '/goa': (context) => const GoaDetailsScreen(),
        '/planner': (context) => const TripPlannerScreen(),
      },
    );
  }
}

// =====================================================
// HOME SCREEN
// =====================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Plan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              'Welcome, Traveller! ✈️',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Plan your journey, explore destinations '
              'and create memorable trips.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            // Featured Goa card
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
                    '?auto=format&fit=crop&w=1200&q=80',
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 240,
                        color: Colors.teal.shade100,
                        child: const Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),

                  Positioned(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Featured Destination',
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Goa',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Named route navigation
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/destinations',
                  );
                },
                icon: const Icon(Icons.explore),
                label: const Text(
                  'Explore Destinations',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/planner',
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  'Open Trip Planner',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// DESTINATIONS SCREEN
// =====================================================

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinations'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Choose your destination',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          DestinationTile(
            name: 'Goa',
            location: 'Beaches • Nature • Nightlife',
            budget: '₹12,000',
            imageUrl:
                'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
                '?auto=format&fit=crop&w=800&q=80',

            // NAVIGATOR.PUSH
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const GoaDetailsScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          DestinationTile(
            name: 'Ooty',
            location: 'Hills • Nature • Relaxation',
            budget: '₹10,500',
            imageUrl:
                'https://images.unsplash.com/photo-1597074866923-dc0589150358'
                '?auto=format&fit=crop&w=800&q=80',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Ooty details coming soon!',
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          DestinationTile(
            name: 'Manali',
            location: 'Mountains • Adventure • Snow',
            budget: '₹15,000',
            imageUrl:
                'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23'
                '?auto=format&fit=crop&w=800&q=80',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Manali details coming soon!',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =====================================================
// GOA DETAILS SCREEN
// =====================================================

class GoaDetailsScreen extends StatelessWidget {
  const GoaDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goa Details'),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
              '?auto=format&fit=crop&w=1200&q=80',
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Goa',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.teal,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'India',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 5),
                      Text('4.8'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'About Goa',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Goa is a popular destination known for '
                    'its beautiful beaches, vibrant culture, '
                    'local food and relaxing atmosphere.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Estimated Trip Budget',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet,
                          color: Colors.teal,
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Starting from',
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '₹12,000',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Named route navigation
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/planner',
                        );
                      },
                      icon: const Icon(
                        Icons.add_task,
                      ),
                      label: const Text(
                        'Plan This Trip',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
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

// =====================================================
// TRIP PLANNER SCREEN
// =====================================================

class TripPlannerScreen extends StatefulWidget {
  const TripPlannerScreen({super.key});

  @override
  State<TripPlannerScreen> createState() =>
      _TripPlannerScreenState();
}

class _TripPlannerScreenState
    extends State<TripPlannerScreen> {
  int selectedDays = 3;

  @override
  Widget build(BuildContext context) {
    int estimatedBudget = selectedDays * 3000;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Planner'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Plan your Goa trip',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Select the number of days for your trip.',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Trip Duration',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              children: [2, 3, 4, 5, 7].map((days) {
                return ChoiceChip(
                  label: Text('$days Days'),
                  selected: selectedDays == days,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        selectedDays = days;
                      });
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 35),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.teal.shade50,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Estimated Budget',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '₹$estimatedBudget',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$selectedDays days × ₹3,000 per day',
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Your $selectedDays-day Goa trip is saved!',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text(
                  'Save Trip Plan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// DESTINATION TILE
// =====================================================

class DestinationTile extends StatelessWidget {
  final String name;
  final String location;
  final String budget;
  final String imageUrl;
  final VoidCallback onTap;

  const DestinationTile({
    super.key,
    required this.name,
    required this.location,
    required this.budget,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 125,
          child: Row(
            children: [
              Image.network(
                imageUrl,
                width: 125,
                height: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                    width: 125,
                    color: Colors.teal.shade100,
                    child: const Icon(
                      Icons.image_outlined,
                    ),
                  );
                },
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'From $budget',
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}