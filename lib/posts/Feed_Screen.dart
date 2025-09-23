import "package:college/post_loader.dart";
import "package:college/posts/Feed_Controller.dart";
import "package:college/posts/Post_Card.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../error_text.dart";

class PostsScreen extends ConsumerWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(postsProvider)
        .when(
      data: (posts) {
        return ListView.builder(itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              final post = posts[index];

              return PostCard(post: post,);
            });
      },
      error: (error, stackTrace) {
        print(error);
        return ErrorText(error: error.toString());
      },
      loading: () => postLoader(),
    );
  }
}
