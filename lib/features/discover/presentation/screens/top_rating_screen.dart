import 'package:flutter/material.dart';

class TopRatingScreen extends StatelessWidget {
  const TopRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // استبدل بالبيانات من API
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Placeholder(), // استبدل بصورة الفيلم
            ),
            title: Text('Top Rated Movie'), // استبدل بعنوان الفيلم
            subtitle: Text('Rating: 8.5'), // استبدل بالتقييم من API
          ),
        );
      },
    );
  }
}
