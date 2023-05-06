
import 'package:flutter/material.dart';
import 'package:webtoonapp/models/webtoon_edpisode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
  });

  final Future<List<WebtoonEpisodeModel>> episode;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: episode,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return  ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var episode = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(width : 100, height : 80 ,child: Image.network(episode.thumb  ),),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(episode.title),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.star_rounded , size: 15,)),
                              Text('${episode.rating}   ${episode.date}')
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
