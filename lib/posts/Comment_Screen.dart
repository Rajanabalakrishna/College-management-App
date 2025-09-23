import 'package:college/error_text.dart';
import 'package:college/loader.dart';
import 'package:college/posts/Feed_Controller.dart';
import 'package:college/posts/Post_Card.dart';
import 'package:college/posts/comment_card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../models/post_model.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final String postId;

  const CommentScreen({super.key, required this.postId});

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final commentController = TextEditingController();

  void addComment(BuildContext context, Post post) {
    ref
        .read(feedControllerProvider.notifier)
        .addComment(
          context: context,
          text: commentController.text.trim(),
          post: post,
        );

    setState(() {
      commentController.text = "";
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: ref
          .watch(getPostByIdProvider(widget.postId))
          .when(
            data: (data) {
              return SafeArea(
                child: Column(
                  children: [
                    PostCard(post: data),
                    TextField(
                      onSubmitted: (val) => addComment(context, data),
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "What are your thoughts?",
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),

                    ref
                        .watch(getPostCommentsProvider(widget.postId))
                        .when(
                          data: (data) {
                            return Expanded(
                              child: ListView.builder(itemCount: data.length,itemBuilder:(BuildContext context,int index){
                                final comment=data[index];
                                return CommentCard(comment: comment);
                              } ),
                            );
                          },
                          error: (error, stackTrace) {
                            print(error.toString());
                            return ErrorText(error: error.toString());
                          },
                          loading: () => const Loader(),
                        ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
