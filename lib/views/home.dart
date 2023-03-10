import 'package:flutter/material.dart';
import 'package:recipe_apps/model/resep_api.dart';
import 'package:recipe_apps/views/detail_resep.dart';
import 'package:recipe_apps/views/widget/resep_card.dart';
import 'package:recipe_apps/model/resep.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Resep> _resep;

  bool _isLoading = true;

  void initState() {
    super.initState();
    getResep();
  }

  Future<void> getResep() async {
    _resep = await ResepApi.getResep();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              Text('Resep.IN'),
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10)
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _resep.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    child: ResepCard(
                      name: _resep[index].name,
                      coockTime: _resep[index].totalTime,
                      rating: _resep[index].rating.toString(),
                      thumbnailUrl: _resep[index].images,
                      videoUrl: _resep[index].videoUrl,
                    ),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailResep(
                              name: _resep[index].name,
                              totalTime: _resep[index].totalTime,
                              rating: _resep[index].rating.toString(),
                              images: _resep[index].images,
                              description: _resep[index].description,
                              videoUrl: _resep[index].videoUrl,
                              instructions: _resep[index].instructions,
                              sections: _resep[index].sections,
                            ),
                          ))
                    },
                  );
                }),
              ));
  }
}
