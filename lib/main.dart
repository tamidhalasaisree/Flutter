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
      ),
      home: const ResponsiveHome(),
    );
  }
}

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery obtains the current screen size.
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Travel Plan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive breakpoints
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(screenWidth);
          } else if (constraints.maxWidth < 1000) {
            return _buildTabletLayout(screenWidth);
          } else {
            return _buildDesktopLayout(screenWidth);
          }
        },
      ),
    );
  }

  // ---------------- MOBILE ----------------

  Widget _buildMobileLayout(double screenWidth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeText('Mobile Travel Planning'),

          const SizedBox(height: 20),

          _featuredCard(height: 220),

          const SizedBox(height: 25),

          _sectionTitle('Popular Destinations'),

          const SizedBox(height: 15),

          const DestinationCard(
            name: 'Goa',
            location: 'India',
            rating: '4.8',
            price: '₹12,000',
            imageUrl:
                'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
                '?auto=format&fit=crop&w=800&q=80',
          ),

          const SizedBox(height: 15),

          const DestinationCard(
            name: 'Ooty',
            location: 'Tamil Nadu',
            rating: '4.7',
            price: '₹10,500',
            imageUrl:
                'https://images.unsplash.com/photo-1597074866923-dc0589150358'
                '?auto=format&fit=crop&w=800&q=80',
          ),

          const SizedBox(height: 15),

          const DestinationCard(
            name: 'Manali',
            location: 'Himachal Pradesh',
            rating: '4.9',
            price: '₹15,000',
            imageUrl:
                'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23'
                '?auto=format&fit=crop&w=800&q=80',
          ),

          const SizedBox(height: 25),

          _responsiveInfoCard(),
        ],
      ),
    );
  }

  // ---------------- TABLET ----------------

  Widget _buildTabletLayout(double screenWidth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeText('Tablet Travel Planning'),

          const SizedBox(height: 25),

          _featuredCard(height: 280),

          const SizedBox(height: 30),

          _sectionTitle('Popular Destinations'),

          const SizedBox(height: 20),

          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.45,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DestinationCard(
                name: 'Goa',
                location: 'India',
                rating: '4.8',
                price: '₹12,000',
                imageUrl:
                    'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
              DestinationCard(
                name: 'Ooty',
                location: 'Tamil Nadu',
                rating: '4.7',
                price: '₹10,500',
                imageUrl:
                    'https://images.unsplash.com/photo-1597074866923-dc0589150358'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
              DestinationCard(
                name: 'Manali',
                location: 'Himachal Pradesh',
                rating: '4.9',
                price: '₹15,000',
                imageUrl:
                    'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
              DestinationCard(
                name: 'Kerala',
                location: 'India',
                rating: '4.8',
                price: '₹13,500',
                imageUrl:
                    'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
            ],
          ),

          const SizedBox(height: 30),

          _responsiveInfoCard(),
        ],
      ),
    );
  }

  // ---------------- DESKTOP ----------------

  Widget _buildDesktopLayout(double screenWidth) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 35,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _welcomeText('Desktop Travel Planning'),

          const SizedBox(height: 30),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _featuredCard(height: 350),
              ),
              const SizedBox(width: 30),
              Expanded(
                flex: 2,
                child: _responsiveInfoCard(),
              ),
            ],
          ),

          const SizedBox(height: 40),

          _sectionTitle('Popular Destinations'),

          const SizedBox(height: 20),

          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            childAspectRatio: 0.85,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              DestinationCard(
                name: 'Goa',
                location: 'India',
                rating: '4.8',
                price: '₹12,000',
                imageUrl:
                    'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
              DestinationCard(
                name: 'Ooty',
                location: 'Tamil Nadu',
                rating: '4.7',
                price: '₹10,500',
                imageUrl:
                    'https://images.unsplash.com/photo-1597074866923-dc0589150358'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
              DestinationCard(
                name: 'Manali',
                location: 'Himachal Pradesh',
                rating: '4.9',
                price: '₹15,000',
                imageUrl:
                    'https://images.unsplash.com/photo-1626621341517-bbf3d9990a23'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
              DestinationCard(
                name: 'Kerala',
                location: 'India',
                rating: '4.8',
                price: '₹13,500',
                imageUrl:
                    'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944'
                    '?auto=format&fit=crop&w=800&q=80',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- COMMON UI ----------------

  Widget _welcomeText(String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Plan your next',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'adventure ✈️',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _featuredCard({required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2'
            '?auto=format&fit=crop&w=1200&q=80',
            width: double.infinity,
            height: height,
            fit: BoxFit.cover,
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Featured Destination',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Goa',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '4.8',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _responsiveInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.devices,
            color: Colors.teal,
            size: 35,
          ),
          SizedBox(height: 15),
          Text(
            'Responsive Planning',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Travel Plan automatically adapts its '
            'layout according to the available screen size.',
            style: TextStyle(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String name;
  final String location;
  final String rating;
  final String price;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.teal.shade100,
                  child: const Center(
                    child: Icon(Icons.image_outlined),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      size: 17,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(rating),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'From $price',
                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}