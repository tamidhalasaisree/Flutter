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

// Shared trip state
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
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      home: const TripFormScreen(),
    );
  }
}

class TripFormScreen extends StatefulWidget {
  const TripFormScreen({super.key});

  @override
  State<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _travellersController = TextEditingController(text: '1');
  final _budgetController = TextEditingController(text: '9000');

  String _destination = 'Goa';
  int _days = 3;
  bool _includeHotel = true;
  bool _includeTransport = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _travellersController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the highlighted fields.'),
        ),
      );
      return;
    }

    final budget = double.parse(_budgetController.text.trim());

    context.read<TripProvider>().updateDays(_days);
    context.read<TripProvider>().updateBudget(budget / _days);
    context.read<TripProvider>().saveTrip();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.teal,
            size: 45,
          ),
          title: const Text('Trip Plan Created!'),
          content: Text(
            'Traveler: ${_nameController.text.trim()}\n'
            'Destination: $_destination\n'
            'Duration: $_days days\n'
            'Travelers: ${_travellersController.text}\n'
            'Total budget: ₹${budget.toStringAsFixed(0)}\n'
            'Hotel: ${_includeHotel ? "Included" : "Not included"}\n'
            'Transport: ${_includeTransport ? "Included" : "Not included"}',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  String? _validateRequired(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $label';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan Your Trip',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your next adventure starts here ✈️',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your details to create a travel plan.',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 25),

              const _FormSectionTitle(
                title: 'Traveler Information',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Enter your name',
                ),
                validator: (value) =>
                    _validateRequired(value, 'your full name'),
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                  hintText: 'you@example.com',
                ),
                validator: (value) {
                  final requiredError =
                      _validateRequired(value, 'your email address');

                  if (requiredError != null) return requiredError;

                  final email = value!.trim();
                  final emailPattern =
                      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                  if (!emailPattern.hasMatch(email)) {
                    return 'Enter a valid email address';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 25),

              const _FormSectionTitle(
                title: 'Trip Details',
                icon: Icons.explore_outlined,
              ),
              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: _destination,
                decoration: const InputDecoration(
                  labelText: 'Choose Destination',
                  prefixIcon: Icon(Icons.place_outlined),
                ),
                items: const [
                  DropdownMenuItem(value: 'Goa', child: Text('Goa')),
                  DropdownMenuItem(value: 'Ooty', child: Text('Ooty')),
                  DropdownMenuItem(
                    value: 'Manali',
                    child: Text('Manali'),
                  ),
                  DropdownMenuItem(
                    value: 'Jaipur',
                    child: Text('Jaipur'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _destination = value);
                  }
                },
              ),
              const SizedBox(height: 20),

              const Text(
                'Trip Duration',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                children: [2, 3, 4, 5, 7].map((day) {
                  return ChoiceChip(
                    label: Text('$day Days'),
                    selected: _days == day,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _days = day;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _travellersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Number of Travelers',
                  prefixIcon: Icon(Icons.groups_outlined),
                ),
                validator: (value) {
                  final requiredError =
                      _validateRequired(value, 'number of travelers');

                  if (requiredError != null) return requiredError;

                  final count = int.tryParse(value!.trim());

                  if (count == null || count < 1 || count > 20) {
                    return 'Enter a number between 1 and 20';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _budgetController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Total Budget (₹)',
                  prefixIcon: Icon(Icons.account_balance_wallet_outlined),
                ),
                validator: (value) {
                  final requiredError =
                      _validateRequired(value, 'your total budget');

                  if (requiredError != null) return requiredError;

                  final budget = double.tryParse(value!.trim());

                  if (budget == null || !budget.isFinite || budget <= 0) {
                    return 'Enter a valid budget greater than zero';
                  }

                  if (budget > 1000000000) {
                    return 'Budget is too large';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),

              const _FormSectionTitle(
                title: 'Additional Preferences',
                icon: Icons.tune,
              ),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Include Hotel'),
                subtitle: const Text('Add accommodation to your plan'),
                value: _includeHotel,
                onChanged: (value) {
                  setState(() => _includeHotel = value);
                },
              ),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Include Transport'),
                subtitle: const Text('Include local transport'),
                value: _includeTransport,
                onChanged: (value) {
                  setState(() => _includeTransport = value);
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    'Create My Travel Plan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormSectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _FormSectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}