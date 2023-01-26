import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uit_video_player/vidoe_info.dart';
import 'colors.dart' as color;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List info = [];

  _loadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/info.json")
        .then((s) {
      setState(() {
        info = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.homePageBackground,
      body: Container(
        margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text("Training",
                    style: TextStyle(
                        color: color.AppColor.homePageTitle,
                        fontSize: 35,
                        fontWeight: FontWeight.w700)),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  color: color.AppColor.homePageTitle,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: color.AppColor.homePageTitle,
                ),
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color.AppColor.homePageTitle,
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              children: [
                Text("Your Program",
                    style: TextStyle(
                        color: color.AppColor.homePageSubtitle,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
                Expanded(child: Container()),
                Text('Details',
                    style: TextStyle(
                        color: color.AppColor.homePageDetail,
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: (){
                    Get.to(() => const VideoInfo());
                  },
                  child: Icon(
                    Icons.arrow_forward,
                    color: color.AppColor.homePageTitle,
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(80),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight,
                      colors: [
                        color.AppColor.gradientFirst.withOpacity(0.7),
                        color.AppColor.gradientSecond.withOpacity(0.9)
                      ]),
                  boxShadow: [
                    BoxShadow(
                        color: color.AppColor.gradientFirst.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(5, 10)
                    )
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text('Next workout',
                       style: TextStyle(
                           color: color.AppColor.homePageContainerTextSmall,
                           fontSize: 20,
                           fontWeight: FontWeight.w400)
                   ),
                   const SizedBox(height: 6,),
                   Text('Legs Toning and Gluts Workout',
                       maxLines: 2,
                       style: TextStyle(
                           color: color.AppColor.homePageContainerTextBig,
                           fontSize: 25,
                           fontWeight: FontWeight.w500)
                   ),
                   Expanded(child: Container()),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_outlined,color: color.AppColor.homePageContainerTextBig,),
                          const SizedBox(width: 10,),
                          Text('60 minutes',
                              style: TextStyle(
                                  color: color.AppColor.homePageContainerTextSmall,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300)
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.AppColor.homePageContainerTextBig,
                          boxShadow: [
                            BoxShadow(
                                color: color.AppColor.gradientFirst.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(5, 10)
                            )
                          ],
                        ),
                        child: Icon(Icons.play_arrow_rounded, color: color.AppColor.gradientFirst, size: 40,),
                      )

                    ],
                  ),
                  ],
              ),
                ),

            ),
            const SizedBox(height: 5,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              //color: Colors.cyan.withOpacity(0.5),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [BoxShadow(
                            color: color.AppColor.gradientSecond.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(5, 7)
                        )],
                      image: const DecorationImage(
                        image: AssetImage('assets/card.jpg'),
                        fit: BoxFit.fill
                      )
                    ),
                  ),
                  Container(
                    height: 140 ,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 180,bottom: 30),
                    decoration:  const BoxDecoration(
                      //color: Colors.redAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage('assets/figure.png'),
                            //fit: BoxFit.fill
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 120,top: 40),
                    width: double.infinity,
                    height: 100,
                    //color: Colors.redAccent.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('You are doing great',
                            style: TextStyle(
                                color: color.AppColor.homePageDetail,
                                fontSize: 18,
                                fontWeight: FontWeight.w500)
                        ),
                        const SizedBox(height: 5,),
                        Text('Keep it up\nStick to your plan',
                            style: TextStyle(
                                color: color.AppColor.homePagePlanColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text("Area of  focus",
                    style: TextStyle(
                        color: color.AppColor.homePageSubtitle,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Expanded(
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      itemCount: (info.length.toDouble()/2).toInt(),
                        itemBuilder: (context,index){
                        int a = index * 2;
                        int b = index * 2 + 1;
                          return Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  margin: const EdgeInsets.all(10),
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [BoxShadow(
                                        color: color.AppColor.gradientSecond.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(5, 7)
                                    )],
                                    image: DecorationImage(
                                        image: AssetImage(
                                          info[a]["img"].toString(),
                                        ),

                                    )
                                  ),
                                  child: Center(
                                    child:Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(info[a]["title"].toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: color.AppColor.homePageDetail,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  margin: const EdgeInsets.all(10),
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    boxShadow: [BoxShadow(
                                        color: color.AppColor.gradientSecond.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(5, 7)
                                    )],
                                    image: DecorationImage(
                                        image: AssetImage(
                                          info[b]["img"].toString(),
                                        ),

                                    )
                                  ),
                                  child: Center(
                                    child:Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(info[b]["title"].toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: color.AppColor.homePageDetail,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
