// import 'package:flutter/material.dart';
// import 'package:newsap/news_api/news_api_screen.dart';
//
// class NewsScreen extends StatefulWidget {
//   @override
//   _NewsScreenState createState() => _NewsScreenState();
// }
//
// class _NewsScreenState extends State<NewsScreen> {
//   final NewsService newsService = NewsService();
//   final TextEditingController searchCtrl = TextEditingController();
//   List<dynamic> newsList = [];
//   bool loading = false;
//
//   List<String> categories = [
//     "Top",
//     "Sports",
//     "Technology",
//     "Business",
//     "Health",
//     "World",
//     "Ary news",
//     "Geo news",
//     "hum Tv"
//   ];
//
//   String selectedCategory = "Top";
//
//   fetchNews() async {
//     if (searchCtrl.text.trim().isEmpty && selectedCategory == "Top") return;
//
//     setState(() => loading = true);
//
//     final query = searchCtrl.text.isEmpty ? selectedCategory : searchCtrl.text;
//
//     final data = await newsService.fetchNews(query);
//
//     setState(() {
//       newsList = data;
//       loading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchNews();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "GNews App",
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             // 🔍 SEARCH BAR UI
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: TextField(
//                 controller: searchCtrl,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                   border: InputBorder.none,
//                   hintText: "Search latest news...",
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.search),
//                     onPressed: fetchNews,
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 15),
//
//             // ⭐ CATEGORY CHIPS
//             SizedBox(
//               height: 40,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: categories.length,
//                 itemBuilder: (context, index) {
//                   final cat = categories[index];
//                   final isSelected = selectedCategory == cat;
//
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: ChoiceChip(
//                       label: Text(cat),
//                       selected: isSelected,
//                       onSelected: (value) {
//                         setState(() {
//                           selectedCategory = cat;
//                           searchCtrl.clear();
//                         });
//                         fetchNews();
//                       },
//                       selectedColor: Colors.blue,
//                       backgroundColor: Colors.grey.shade300,
//                       labelStyle: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             SizedBox(height: 15),
//
//             // 📃 NEWS LIST
//             Expanded(
//               child: loading
//                   ? Center(child: CircularProgressIndicator())
//                   : newsList.isEmpty
//                   ? Center(child: Text("No news found"))
//                   : ListView.builder(
//                 itemCount: newsList.length,
//                 itemBuilder: (context, index) {
//                   final item = newsList[index];
//                   return Card(
//                     margin: EdgeInsets.only(bottom: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: item['image'] != null
//                                 ? Image.network(
//                               item['image'],
//                               width: 100,
//                               height: 80,
//                               fit: BoxFit.cover,
//                             )
//                                 : Container(
//                               width: 100,
//                               height: 80,
//                               color: Colors.grey.shade300,
//                               child: Icon(Icons.image),
//                             ),
//                           ),
//
//                           SizedBox(width: 12),
//
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   item['title'] ?? "No Title",
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 SizedBox(height: 6),
//                                 Text(
//                                   item['description'] ??
//                                       "No Description",
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:newsap/news_api/news_api_screen.dart';
import 'package:newsap/news_screen/vedio_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService newsService = NewsService();
  final TextEditingController searchCtrl = TextEditingController();
  List<dynamic> newsList = [];
  bool loading = false;

  List<String> categories = [
    "Top",
    "Sports",
    "Technology",
    "Business",
    "Health",
    "World",
    "Ary news",
    "Geo news",
    "Hum Tv"
  ];

  String selectedCategory = "Top";

  fetchNews() async {
    setState(() => loading = true);

    final query = searchCtrl.text.isEmpty ? selectedCategory : searchCtrl.text;

    final data = await newsService.fetchNews(query);

    setState(() {
      newsList = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  bool hasVideo(String url) {
    return url.endsWith(".mp4") ||
        url.contains("youtube.com") ||
        url.contains("youtu.be");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GNews App",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔍 SEARCH BAR
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  hintText: "Search latest news...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: fetchNews,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            // ⭐ CATEGORY CHIPS
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = cat;
                          searchCtrl.clear();
                        });
                        fetchNews();
                      },
                      selectedColor: Colors.blue[700],
                      backgroundColor: Colors.grey.shade300,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 15),

            // 📃 NEWS LIST
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final item = newsList[index];
                  final hasVid = hasVideo(item['url']);

                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item['image'] != null
                                ? Image.network(
                              item['image'],
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              height: 180,
                              width: double.infinity,
                              color: Colors.grey.shade400,
                              child: Icon(Icons.image),
                            ),
                          ),

                          SizedBox(height: 10),

                          // TITLE
                          Text(
                            item['title'] ?? "No Title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 6),

                          // DESCRIPTION
                          Text(
                            item['description'] ?? "No Description",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),

                          SizedBox(height: 10),

                          // 🎥 VIDEO BUTTON IF VIDEO EXISTS
                          if (hasVid)
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => VideoPlayerScreen(
                                        videoUrl: item['url']),
                                  ),
                                );
                              },
                              icon: Icon(Icons.play_circle_fill),
                              label: Text("Watch Video"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
