import 'package:flutter/material.dart';
import 'package:webtoonapp/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget{
  final String title, thumb, id;

  const WebtoonWidget({super.key, required this.title, required this.thumb, required this.id });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => DetailScreen(thumb: thumb, id :id , title : title),
          // fullscreenDialog: true,
          ),);
      },
      child: Column(
                  children: [
                    Hero(
                      tag: id,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset: const Offset(10, 10),
                              color: Colors.black.withOpacity(.5)
                            )
                          ]
                        ) ,
                        clipBehavior: Clip.hardEdge,
                        width: 250,
                        child: Image.network(thumb),),
                    ),
                      const SizedBox(height: 10,),
                    Text(title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
                  ],
                ),
    );
  }

}