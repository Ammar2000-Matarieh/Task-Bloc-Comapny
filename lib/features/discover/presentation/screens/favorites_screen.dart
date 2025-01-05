import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Placeholder(), // استبدل بصورة الفيلم
        ),
        title: Text('Favorite Movie'), // استبدل بعنوان الفيلم
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // أضف وظيفة الحذف
          },
        ),
      ),
    );
  }
}
