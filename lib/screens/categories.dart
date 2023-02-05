import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wordpress/apis/api.dart';
import 'package:flutter_wordpress/screens/post.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});
  static const routeName = 'pagecategories';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Posts Categorías'),
        backgroundColor: Colors.blue[0],
      ),
      body: FutureBuilder(
        future: getCategoryById(id.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var numpost = snapshot.data.length;
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemCount: numpost,
                itemBuilder: (context, index) {
                  Map post = snapshot.data[index];

                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(SinglePost.routeName, arguments: post),
                    child: Column(
                      children: [
                        //const SizedBox(height: 13),

                        Container(
                          padding: const EdgeInsets.all(21),
                          child: Column(
                            children: <Widget>[
                              Text(post['title']['rendered'],
                                  style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold)),
                              /*  HtmlWidget(
                                post['content']['rendered'],                              
                              ),
                             */
                              Html(
                                data: post['content']['rendered'],
                                style: {
                                  '#': Style(
                                    fontSize: const FontSize(13),
                                    maxLines: 3,
                                    // textOverflow: TextOverflow.ellipsis,
                                  ),
                                },
                              ),
                              const Text('Read More',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                              const Icon(Icons.more_horiz_outlined),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
