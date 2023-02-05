import 'package:flutter_wordpress/apis/api.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  static const routeName = 'pagecategories';
  @override
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías')
      ),

      body: FutureBuilder(
        future: getCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var numpost = snapshot.data.length;
              return ListView.separated(
                padding: const EdgeInsets.all(21),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: numpost,
                itemBuilder: (context, index) {
                  Map post = snapshot.data[index];
                  if (post['count'] == 0) {
                    //Remove category empty not work
                  }

                  return GestureDetector(
                    //onTap: ()=> Navigator.of(context).pushNamed(routeName, arguments: post),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, routeName,
                                      arguments: post['id']);
                                },
                                child: Text(post['name']),
                              ),
                            ),
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
