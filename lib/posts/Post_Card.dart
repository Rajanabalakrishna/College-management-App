import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college/Pallete.dart';
import 'package:college/controller/auth_controller.dart';
import 'package:college/posts/Feed_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../models/post_model.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  void deletePost(Post post,WidgetRef ref)async
  {
    ref.read(feedControllerProvider.notifier).deletePost(post);
  }

  void like(WidgetRef ref)async
  {
    ref.read(feedControllerProvider.notifier).like(post);
  }

  void navigateToComments(BuildContext context)
  {
    Routemaster.of(context).push("/post/${post.id}/comments");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminLog = ref.watch(adminProvider);
    final user = ref.watch(userProvider);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Pallete.lightModeAppTheme.scaffoldBackgroundColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ).copyWith(right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    child: Image.asset(
                                      "assets/images/Sivani_logo.jpg",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Sri Sivani College of engineering",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const Text(
                                          "Admin",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: IconButton(
                                      onPressed: () {
                                        deletePost(post, ref);

                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          GestureDetector(
                            onDoubleTap:(){return like(ref);},
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              width: double.infinity,
                              child: post.link?.isNotEmpty == true
                                  ? Image.network(post.link!,)
                                  : const Icon(Icons.image_not_supported),
                            ),
                          ),

                          Row(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      like(ref);
                                    },
                                    icon: post.likes.contains(user?.uid)
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(
                                            Icons.favorite_outline,
                                            size: 30,
                                          ),
                                  ),


                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            navigateToComments(context);
                                          },
                                          icon: Icon(Icons.comment, size: 30),
                                        ),
                                    
                                    
                                      ],
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18,
                            ).copyWith(top: 0, bottom: 0),
                            child: Text(
                              post.likes.length != 0
                                  ? post.likes.length.toString()
                                  : "Like",
                              style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                            ),
                          ),

                        ],

                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
