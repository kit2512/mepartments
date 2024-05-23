import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mepartments/src/data/models/attachment.dart';
import 'package:mepartments/src/data/models/post.dart';
import 'package:mepartments/src/data/models/user.dart';
import 'package:mepartments/src/data/repositories/post_repositories.dart';
import 'package:mepartments/src/pages/news/photo_grid.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _postRepository = Get.find<PostRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: StreamBuilder<List<PostModel>>(
        stream: _postRepository.postStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return PostItem(post: post);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PostHeaderView(
              userRef: post.createdBy,
              createdAt: post.createdAt,
            ),
            const SizedBox(
              height: 16,
            ),
            ReadMoreText(
              post.description,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimExpandedText: ' read less',
            ),
            if (post.images.isNotEmpty) ...[
              const SizedBox(
                height: 16,
              ),
              PostPhotoGridView(images: post.images),
              const SizedBox(
                height: 16,
              )
            ],
            Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: PostAttachmentsView(
                postId: post.uuid,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PostPhotoGridView extends StatelessWidget {
  const PostPhotoGridView({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return PhotoGrid(
      imageUrls: images,
      onImageClicked: (index) {
        Get.to(
          FullImageView(
            path: images[index],
          ),
        );
      },
      onExpandClicked: () {},
    );
  }
}

class PostHeaderView extends StatelessWidget {
  const PostHeaderView({super.key, required this.userRef, required this.createdAt});

  final DocumentReference userRef;
  final Timestamp createdAt;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userRef.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = UserModel.fromDocumentData(userRef.id, snapshot.data!.data() as Map<String, dynamic>);
          final createdAt = DateFormat('dd-MM-yyyy HH:mm').format(this.createdAt.toDate());
          return Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.fullName),
                  Text(
                    createdAt,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ],
          );
        }
        return Shimmer(
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.white],
          ),
          child: Row(
            children: [
              const CircleAvatar(),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 50,
                    height: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class PostAttachmentsView extends StatelessWidget {
  PostAttachmentsView({
    super.key,
    required this.postId,
  });

  final String postId;

  final PostRepository _postRepository = Get.find<PostRepository>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AttachmentModel>>(
      stream: _postRepository.attachmentsStream(postId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: snapshot.data!.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.attachment, color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        e.name,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final url = await FirebaseStorage.instance.ref().child(e.url).getDownloadURL();
                        if (await canLaunchUrlString(url)) {
                          launchUrlString(url);
                        }
                      },
                      child: Text(
                        'View',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class FullImageView extends StatelessWidget {
  const FullImageView({
    super.key,
    required this.path,
    this.fit,
  });

  final String path;
  final BoxFit? fit;

  Future<String> getImageUrl() async {
    final ref = FirebaseStorage.instance.ref().child(path);
    final url = await ref.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<String>(
        future: getImageUrl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.network(
              snapshot.data as String,
              fit: fit,
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }
}

class FullImageListView extends StatefulWidget {
  const FullImageListView({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<FullImageListView> createState() => _FullImageListViewState();
}

class _FullImageListViewState extends State<FullImageListView> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                imageIndex = index;
              });
            },
            children: widget.images.map((e) {
              return FullImageView(path: e);
            }).toList(),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(
                '${imageIndex + 1}/${widget.images.length}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
