import 'apis/api.dart';
import 'package:flutter_wordpress/screens/categories.dart';
import 'package:flutter_wordpress/screens/post.dart';
import 'package:flutter_wordpress/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (BuildContext contex) => const HomePage(),
        SinglePost.routeName: (BuildContext context) => const SinglePost(),
        Categories.routeName: (BuildContext context) => const Categories()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: Menu()),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Wordpress Api Flutter'),
      ),
      body: FutureBuilder(
        future: getPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var numpost = snapshot.data.length;
              return ListView.separated(
                  padding: const EdgeInsets.all(21),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: numpost,
                  itemBuilder: (context, index) {
                    Map post = snapshot.data[index];

                    return GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(SinglePost.routeName, arguments: post),
                      child: Column(
                        children: [
                          const SizedBox(height: 21),
                          Text(post['title']['rendered'],
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 13),
                          if (post["_embedded"]["wp:featuredmedia"][0]
                                  ["media_details"]["sizes"]["thumbnail"] !=
                              null) ...[
                            FadeInImage(
                                placeholder:
                                    const AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(post["_embedded"]
                                        ["wp:featuredmedia"][0]["media_details"]
                                    ["sizes"]["thumbnail"]["source_url"]),
                                width: 300,
                                fit: BoxFit.cover),
                          ],
                          /*
                          else ...[
                            FadeInImage(
                                placeholder: const AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(post["_embedded"]["wp:featuredmedia"][0]['source_url']),
                                width: 300,
                                fit: BoxFit.cover
                            ),
                          ],
                          */
                          Column(
                            children: <Widget>[
                              Text(
                                parse(post['content']['rendered'])
                                    .documentElement!
                                    .text,
                                maxLines: 3,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Icon(Icons.more_horiz_outlined),
                              const Text('Read More',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                              const SizedBox(height: 13),
                            ],
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
