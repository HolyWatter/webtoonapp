import 'package:flutter/material.dart';
import 'package:webtoonapp/models/webtoon_model.dart';
import 'package:webtoonapp/services/api_service.dart';
import 'package:webtoonapp/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        elevation: 2,
        title: const Text("Seongsu's Webtoons", style : TextStyle(fontSize: 20, fontWeight:  FontWeight.w600)),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder:(context, snapshot) {
          if(snapshot.hasData){
            return Column(
              children: [
                const SizedBox(height: 30,),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder :(context, index) {
              var webtoon = snapshot.data![index];
              return WebtoonWidget(
                title: webtoon.title
              , thumb: webtoon.thumb,
                id: webtoon.id,
                );
            },
            separatorBuilder: (context, index) => const SizedBox( width: 40,),
          );
  }
}