
import 'package:bookclub/common/style_manager.dart';
import 'package:bookclub/model/collection.dart';
import 'package:bookclub/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CollectionCard extends StatelessWidget {
  final Collection collection;

  const CollectionCard({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, AppRoutes.COLLECTION_BOOKS,
          arguments: collection);
    },
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: StyleManager.instance.backgroundColor,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Text(collection.image),
                  Icon(Icons.book_outlined,
                      color: StyleManager.instance.primaryText, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    collection.title ?? '',
                    style: TextStyle(
                        color: StyleManager.instance.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                collection.description ?? '',
                style: TextStyle(color: StyleManager.instance.primaryText),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Por: ${collection.owner ?? ''}',
                    style: TextStyle(color: StyleManager.instance.primaryText),
                  ),
                  const Spacer(),
                  const Icon(Icons.swipe_outlined)
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
  }
}
