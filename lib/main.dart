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
        scaffoldBackgroundColor: const Color(0xFFF4F8F7),
      ),
      home: const AnimatedTravelScreen(),
    );
  }
}

class AnimatedTravelScreen extends StatefulWidget {
  const AnimatedTravelScreen({super.key});

  @override
  State<AnimatedTravelScreen> createState() =>
      _AnimatedTravelScreenState();
}

class _AnimatedTravelScreenState extends State<AnimatedTravelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _showDetails = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replayAnimation() {
    setState(() {
      _showDetails = false;
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Plan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Replay animation',
            onPressed: _replayAnimation,
            icon: const Icon(Icons.replay),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Adventure Awaits!',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Discover beautiful places and plan your next getaway.',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 25),

                // Animated destination card
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.85, end: 1.0),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutBack,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00796B),
                          Color(0xFF26A69A),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withValues(alpha: 0.20),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          size: 45,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'FEATURED DESTINATION',
                          style: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 2,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Goa, India 🌴',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Golden beaches, beautiful sunsets '
                          'and unforgettable memories.',
                          style: TextStyle(
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Why Travel With Us?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                const FeatureCard(
                  icon: Icons.explore,
                  title: 'Explore Destinations',
                  description: 'Discover places for your next holiday.',
                ),
                const FeatureCard(
                  icon: Icons.account_balance_wallet,
                  title: 'Smart Budget Planning',
                  description: 'Estimate expenses before you travel.',
                ),
                const FeatureCard(
                  icon: Icons.calendar_month,
                  title: 'Flexible Trip Duration',
                  description: 'Choose a duration that suits your plans.',
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    },
                    icon: const Icon(Icons.auto_awesome),
                    label: Text(
                      _showDetails
                          ? 'Hide Travel Tip'
                          : 'Reveal Travel Tip',
                    ),
                  ),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: _showDetails
                      ? Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 15),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.teal.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.lightbulb_outline,
                                color: Colors.teal,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Travel tip: Plan your daily activities '
                                  'and keep some extra money for unexpected '
                                  'expenses.',
                                  style: TextStyle(height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.withValues(alpha: 0.12),
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(description),
        ),
      ),
    );
  }
}