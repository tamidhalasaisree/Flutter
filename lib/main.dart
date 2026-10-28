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

// Shared application state using Provider
class TripProvider extends ChangeNotifier {
  int _days = 3;
  double _dailyBudget = 3000;
  bool _tripSaved = false;

  int get days => _days;
  double get dailyBudget => _dailyBudget;
  double get totalBudget => _days * _dailyBudget;
  bool get tripSaved => _tripSaved;

  void updateDays(int value) {
    _days = value;
    _tripSaved = false;
    notifyListeners();
  }

  void updateDailyBudget(double value) {
    _dailyBudget = value;
    _tripSaved = false;
    notifyListeners();
  }

  void saveTrip() {
    _tripSaved = true;
    notifyListeners();
  }
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
      ),
      home: const TripPlannerScreen(),
    );
  }
}

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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plan Your Goa Trip 🌴',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Customize your trip and track your budget.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 25),

            // Destination card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.teal, Colors.cyan],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.beach_access,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'GOA, INDIA',
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your next adventure',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Trip Duration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // setState is demonstrated in the separate duration selector.
            const DurationSelector(),

            const SizedBox(height: 25),

            const Text(
              'Daily Budget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              '₹${trip.dailyBudget.toInt()} per day',
              style: const TextStyle(
                color: Colors.teal,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            Slider(
              value: trip.dailyBudget,
              min: 1000,
              max: 10000,
              divisions: 18,
              label: '₹${trip.dailyBudget.toInt()}',
              onChanged: (value) {
                context.read<TripProvider>().updateDailyBudget(value);
              },
            ),

            const SizedBox(height: 15),

            // Automatically updates when Provider state changes.
            Card(
              elevation: 0,
              color: Colors.teal.withValues(alpha: 0.10),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      color: Colors.teal,
                      size: 35,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Total Budget'),
                          const SizedBox(height: 5),
                          Text(
                            '₹${trip.totalBudget.toInt()}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          Text(
                            '${trip.days} days × '
                            '₹${trip.dailyBudget.toInt()}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<TripProvider>().saveTrip();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your Goa trip has been saved!'),
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Save My Trip'),
              ),
            ),

            if (trip.tripSaved) ...[
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  '✓ Trip saved successfully!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// StatefulWidget demonstrates setState for selecting duration.
class DurationSelector extends StatefulWidget {
  const DurationSelector({super.key});

  @override
  State<DurationSelector> createState() => _DurationSelectorState();
}

class _DurationSelectorState extends State<DurationSelector> {
  @override
  Widget build(BuildContext context) {
    final trip = context.watch<TripProvider>();

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [2, 3, 4, 5, 7].map((days) {
        return ChoiceChip(
          label: Text('$days Days'),
          selected: trip.days == days,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                // Local widget state changes.
              });

              context.read<TripProvider>().updateDays(days);
            }
          },
        );
      }).toList(),
    );
  }
}