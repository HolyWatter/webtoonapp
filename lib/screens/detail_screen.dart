import 'package:flutter/material.dart';
import 'package:webtoonapp/models/webtoon_detail_model.dart';
import 'package:webtoonapp/models/webtoon_edpisode_model.dart';
import 'package:webtoonapp/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, id, thumb;

  const DetailScreen({super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> detail;
  late Future<List<WebtoonEpisodeModel>> episode;

  @override
  void initState() {
    super.initState();
    detail = ApiService.getWebtoonDetail(widget.id);
    episode = ApiService.getWebtoonEpisode(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text(widget.title , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
      ),
      body: 
        SingleChildScrollView(
          child: Flexible(
            flex: 1,
            child: Hero(
            tag: widget.id,
            child: Column(
              children: [
                Image.network(widget.thumb,),
                 FutureBuilder(
              future: detail,
              builder: (context, snapshot) {
                var detailInfo = snapshot.data;
              if(snapshot.hasData){
                return Padding(padding : const EdgeInsets.symmetric(horizontal: 20, vertical: 20 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Text('${detailInfo!.genre} / ${detailInfo.age}'),
                    const SizedBox(height: 10,),
                    Text(detailInfo.about),
                  ],
                ));
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
            SizedBox(
              height: 500,
              child: FutureBuilder(
                future: episode,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return  ListView.builder(
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
                                   child: Column(children: [ 
                                    Text(episode.title),
                                    Row(
                                      children: [
                                        const Icon(Icons.star_rounded , size: 15,),
                                        Text('${episode.rating}   ${episode.date}')
                                      ],
                                    )
                                    
                                    ],),
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
              ),
            )
              ],
            )
            ),
          ),
        )
      );
  }
}
