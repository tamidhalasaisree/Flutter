import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TripProvider(),
      child: const TravelPlanApp(),
    ),
  );
}

// EXPERIMENT 5: Shared state management
class TripProvider extends ChangeNotifier {
  int days = 3;
  double dailyBudget = 3000;
  bool tripSaved = false;

  double get totalBudget => days * dailyBudget;

  void updateDays(int value) {
    days = value;
    tripSaved = false;
    notifyListeners();
  }

  void updateBudget(double value) {
    dailyBudget = value;
    tripSaved = false;
    notifyListeners();
  }

  void saveTrip() {
    tripSaved = true;
    notifyListeners();
  }
}

// EXPERIMENT 6: Application theme
class TravelPlanApp extends StatelessWidget {
  const TravelPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Plan',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00796B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F8F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00796B),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00796B),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: const TripPlannerScreen(),
    );
  }
}

// Main screen
class TripPlannerScreen extends StatelessWidget {
  const TripPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = context.watch<TripProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Plan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.flight_takeoff),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover. Plan. Explore.',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your next adventure starts here.',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 22),

            // Reusable custom destination widget
            const DestinationCard(
              name: 'Goa',
              subtitle: 'Beaches, sunsets and adventures',
              icon: Icons.beach_access,
              color: Color(0xFF00897B),
              tag: 'FEATURED DESTINATION',
            ),

            const SizedBox(height: 26),

            const SectionHeading(
              title: 'Plan Your Trip',
              subtitle: 'Customize your travel preferences',
            ),

            const SizedBox(height: 15),

            const Text(
              'How many days?',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: [2, 3, 4, 5, 7].map((day) {
                return ChoiceChip(
                  label: Text('$day Days'),
                  selected: trip.days == day,
                  onSelected: (selected) {
                    if (selected) {
                      context.read<TripProvider>().updateDays(day);
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            const Text(
              'Daily Budget',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            Slider(
              value: trip.dailyBudget,
              min: 1000,
              max: 10000,
              divisions: 18,
              label: '₹${trip.dailyBudget.toInt()}',
              onChanged: (value) {
                context.read<TripProvider>().updateBudget(value);
              },
            ),

            // Reusable custom budget widget
            BudgetCard(
              days: trip.days,
              dailyBudget: trip.dailyBudget,
              totalBudget: trip.totalBudget,
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                context.read<TripProvider>().saveTrip();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your trip has been saved!'),
                  ),
                );
              },
              icon: const Icon(Icons.bookmark_added),
              label: const Text('Save My Trip'),
            ),

            if (trip.tripSaved)
              const Padding(
                padding: EdgeInsets.only(top: 14),
                child: Center(
                  child: Text(
                    '✓ Your trip is saved!',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// CUSTOM WIDGET 1: Destination card
class DestinationCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String tag;

  const DestinationCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withValues(alpha: 0.75)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.wb_sunny_outlined,
            color: Colors.white70,
            size: 26,
          ),
          const SizedBox(height: 16),
          Text(
            tag,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(icon, color: Colors.white, size: 42),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// CUSTOM WIDGET 2: Section heading
class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionHeading({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

// CUSTOM WIDGET 3: Budget summary
class BudgetCard extends StatelessWidget {
  final int days;
  final double dailyBudget;
  final double totalBudget;

  const BudgetCard({
    super.key,
    required this.days,
    required this.dailyBudget,
    required this.totalBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE0F2F1),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF00796B),
              child: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Estimated Trip Budget'),
                  const SizedBox(height: 5),
                  Text(
                    '₹${totalBudget.toInt()}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00796B),
                    ),
                  ),
                  Text(
                    '$days days × ₹${dailyBudget.toInt()}',
                    style: const TextStyle(fontSize: 12),
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