`
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_plan/main.dart';

void main() {
  group('TravelPost Model Tests', () {
    test('Converts JSON data into a TravelPost object', () {
      final json = {
        'id': 1,
        'title': 'Goa Beach',
        'body': 'A beautiful beach destination.',
      };

      final post = TravelPost.fromJson(json);

      expect(post.id, 1);
      expect(post.title, 'Goa Beach');
      expect(post.description, 'A beautiful beach destination.');
    });

    test('Stores different API records correctly', () {
      final json = {
        'id': 2,
        'title': 'Mountain Adventure',
        'body': 'Explore the mountains.',
      };

      final post = TravelPost.fromJson(json);

      expect(post.id, 2);
      expect(post.title, 'Mountain Adventure');
      expect(post.description, 'Explore the mountains.');
    });

    test('Preserves the API record ID', () {
      final json = {
        'id': 10,
        'title': 'Travel Destination',
        'body': 'Discover a new place.',
      };

      final post = TravelPost.fromJson(json);

      expect(post.id, 10);
    });
  });
}
