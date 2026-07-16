import 'package:flutter/material.dart';
import '../services/api_service.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() =>
      _KnowledgeScreenState();
}

class _KnowledgeScreenState
    extends State<KnowledgeScreen> {

  late Future<List<dynamic>> articles;

  final titleController =
      TextEditingController();

  final categoryController =
      TextEditingController();

  final contentController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    articles =
        ApiService.getKnowledgeArticles();
  }

  Future<void>
      _showCreateArticleDialog() async {

    await showDialog(
      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Create Article",
          ),

          content:
              SingleChildScrollView(

            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                TextField(
                  controller:
                      titleController,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Title",
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextField(
                  controller:
                      categoryController,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Category",
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                TextField(
                  controller:
                      contentController,

                  maxLines: 5,

                  decoration:
                      const InputDecoration(
                    labelText:
                        "Content",
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                    context);
              },
              child: const Text(
                  "Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {

                await ApiService
                    .createArticle(
                  titleController.text,
                  categoryController.text,
                  contentController.text,
                );

                Navigator.pop(
                    context);

                setState(() {
                  articles =
                      ApiService
                          .getKnowledgeArticles();
                });
              },

              child:
                  const Text(
                "Save",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Knowledge Vault",
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        onPressed: () {
          _showCreateArticleDialog();
        },

        child: const Icon(
          Icons.add,
        ),
      ),

      body:
          FutureBuilder<List<dynamic>>(

        future: articles,

        builder:
            (context, snapshot) {

          if (snapshot
                  .connectionState ==
              ConnectionState
                  .waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error
                    .toString(),
              ),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!
                  .isEmpty) {

            return const Center(
              child: Text(
                "No Articles Found",
              ),
            );
          }

          final data =
              snapshot.data!;

          return ListView.builder(

            itemCount:
                data.length,

            itemBuilder:
                (context, index) {

              final article =
                  data[index];

              return Card(

                margin:
                    const EdgeInsets.all(
                        10),

                child: ListTile(

                  leading:
                      const Icon(
                    Icons.menu_book,
                  ),

                  title: Text(
                    article["title"],
                  ),

                  subtitle: Text(
                    article["category"],
                  ),

                  onTap: () {

                    showDialog(

                      context:
                          context,

                      builder:
                          (context) {

                        return AlertDialog(

                          title:
                              Text(
                            article[
                                "title"],
                          ),

                          content:
                              SingleChildScrollView(
                            child:
                                Text(
                              article[
                                  "content"],
                            ),
                          ),

                          actions: [

                            TextButton(
                              onPressed:
                                  () {
                                Navigator.pop(
                                    context);
                              },

                              child:
                                  const Text(
                                "Close",
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}