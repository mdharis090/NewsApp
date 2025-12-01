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

  List<String> categories = [
    "Top",
    "Sports",
    "Technology",
    "Business",
    "Health",
    "World",
  ];

  String selectedCategory = "Top";

  fetchNews() async {
    if (searchCtrl.text.trim().isEmpty && selectedCategory == "Top") return;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔍 SEARCH BAR UI
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                  hintText: "Search latest news...",
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
                      selectedColor: Colors.blue,
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
                  : newsList.isEmpty
                  ? Center(child: Text("No news found"))
                  : ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final item = newsList[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item['image'] != null
                                ? Image.network(
                              item['image'],
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              width: 100,
                              height: 80,
                              color: Colors.grey.shade300,
                              child: Icon(Icons.image),
                            ),
                          ),

                          SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
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
                                Text(
                                  item['description'] ??
                                      "No Description",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
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
