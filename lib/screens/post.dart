import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class SinglePost extends StatelessWidget {
  const SinglePost({super.key});
  static const routeName = 'detalle';
  @override
    Widget build(BuildContext context) {

    final Map post = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar:  AppBar(
        title: Text(post['title']['rendered'])
      ),
      
      body: ListView(
        padding: const EdgeInsets.all(21),
        children: [
          /* La imágen destacada
           if (post["_embedded"]["wp:featuredmedia"][0]["media_details"]["sizes"]["thumbnail"] !=null) 
              ...[
                FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(post["_embedded"]["wp:featuredmedia"][0]["media_details"]["sizes"]["thumbnail"]["source_url"]),
                  width: 300,
                  fit: BoxFit.cover
        
                ),
              ] else ...[
                FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(post["_embedded"]["wp:featuredmedia"][0]['source_url']),
                    width: 300,
                    fit: BoxFit.cover
                ),
              ],
              */
              Text(
                post['title']['rendered'],
                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)
                
              ),
              HtmlWidget(
                post['content']['rendered'],
              ),
        ],

      ),
      
    );
    
    
  }
}

