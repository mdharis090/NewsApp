// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ArticleScreen extends StatelessWidget {
//   final Map<String, dynamic> article;
//   ArticleScreen({required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     final title = article['title'] ?? "No Title";
//     final description = article['description'] ?? "No Description";
//     final image = article['image'];
//     final url = article['url'];
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Article")),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             image != null
//                 ? Image.network(image, width: double.infinity, fit: BoxFit.cover)
//                 : Container(height: 200, color: Colors.grey.shade300, child: Icon(Icons.image, size: 50)),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   Text(description, style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () async {
//                       if (url != null && await canLaunchUrl(Uri.parse(url))) {
//                         await launchUrl(Uri.parse(url));
//                       }
//                     },
//                     child: Text("Read Full Article"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatelessWidget {
  final Map<String, dynamic> article;
  ArticleScreen({required this.article});

  void openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print("Could not launch $url");
      }
    } catch (e) {
      print("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = article['title'] ?? "No Title";
    final description = article['description'] ?? "No Description";
    final image = article['image'];
    final source = article['source'] != null ? article['source']['name'] : "Unknown";
    final url = article['url'];

    return Scaffold(
      appBar: AppBar(title: Text("Article")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ARTICLE IMAGE
            image != null
                ? Image.network(
              image,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            )
                : Container(
              height: 220,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Icon(Icons.image, size: 50),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ARTICLE TITLE
                  Text(
                    title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // ARTICLE SOURCE
                  Text(
                    "Source: $source",
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 12),

                  // ARTICLE DESCRIPTION
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),

                  // READ FULL ARTICLE BUTTON
                  url != null
                      ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        openUrl(url);
                      },
                      child: Text("Read Full Article"),
                    ),
                  )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
