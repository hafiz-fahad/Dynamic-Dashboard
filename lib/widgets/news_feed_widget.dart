import 'dart:async';
import 'package:flutter/material.dart';

class NewsFeedWidget extends StatefulWidget {
  @override
  _NewsFeedWidgetState createState() => _NewsFeedWidgetState();
}

class _NewsFeedWidgetState extends State<NewsFeedWidget> {
  static const String _baseUrl = 'https://picsum.photos/200/300';
  String _imageUrl = _baseUrl; // Initial image URL
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startImageUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateImageUrl() {
    setState(() {
      _imageUrl =
          '$_baseUrl?timestamp=${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  void _startImageUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateImageUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'News Feed',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Center(
            child: Center(
              child: Image.network(
                _imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Text('Error loading image'));
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Random image from Picsum API (updates every 30 seconds).',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
