import 'package:flutter/material.dart';
import 'package:newsap/news_api/news_api_screen.dart';


class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService newsService = NewsService();
  final TextEditingController searchCtrl = TextEditingController();
  List<dynamic> newsList = [];
  bool loading = false;

  fetchNews() async {
    setState(() => loading = true);

    final data = await newsService.fetchNews(searchCtrl.text.trim());
    setState(() {
      newsList = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GNews App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Search news...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: fetchNews,
                ),
              ),
            ),
            SizedBox(height: 20),
            loading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final item = newsList[index];
                  return Card(
                    child: ListTile(
                      leading: item['image'] != null
                          ? Image.network(item['image'], width: 70)
                          : Icon(Icons.image),
                      title: Text(item['title'] ?? "No Title"),
                      subtitle: Text(item['description'] ?? "No Description"),
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
