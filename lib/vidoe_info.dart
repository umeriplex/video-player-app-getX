// ignore_for_file: prefer_conditional_assignment

import 'dart:convert';
import 'dart:math';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'colors.dart' as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool isPlay = false;
  bool isPlaying = true;
  bool visibility = false;
  bool disposed = false;
  int selectedIndex = -1;
  Duration? _duration;
  Duration? _position;
  VideoPlayerController? _controller;

  _loadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((s) {
      setState(() {
        videoInfo = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    _loadData();
    setState(() {
      super.initState();
    });
  }

  @override
  void dispose() {
    disposed = true;
    _controller!.pause();
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
            colors: [
              color.AppColor.gradientFirst.withOpacity(0.8),
              color.AppColor.gradientSecond.withOpacity(1),
            ],
          ),
        ),
        child: Column(
          children: [
            isPlay == false
                ? Container(
                    margin: const EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 20),
                    //color: Colors.redAccent.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        Text('Legs Toning\nand Gluts Workout',
                            maxLines: 2,
                            style: TextStyle(
                                color: color.AppColor.secondPageTitleColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w500)),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: isPlay == false
                                    ? LinearGradient(
                                        colors: [
                                            color.AppColor
                                                .secondPageContainerGradient1stColor,
                                            color.AppColor
                                                .secondPageContainerGradient2ndColor,
                                          ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight)
                                    : LinearGradient(colors: [
                                        color.AppColor
                                            .secondPageContainerGradient2ndColor
                                      ]),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer_outlined,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '30 min',
                                    style: TextStyle(
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            Container(
                              height: 30,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [
                                      color.AppColor
                                          .secondPageContainerGradient1stColor,
                                      color.AppColor
                                          .secondPageContainerGradient2ndColor,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.handyman_outlined,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Resistant Bend, kettleBelt',
                                    style: TextStyle(
                                        color:
                                            color.AppColor.secondPageIconColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    color: color.AppColor.secondPageContainerGradient2ndColor,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 50, bottom: 10),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(child: Container()),
                              const Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _playView(context),
                        visibility == false
                            ? Container()
                            : _controlView(context),
                      ],
                    ),
                  ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Circuit 1 : Legs Tuning',
                          style: TextStyle(
                              color: color.AppColor.circuitsColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.loop,
                              color: color.AppColor.loopColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '3 Sets',
                              style: TextStyle(
                                  color: color.AppColor.circuitsColor),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: _listViewBuilder(),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      visibility = true;
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_controller!),
      );
    } else {
      visibility = false;
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
            child: SpinKitThreeBounce(
              color: color.AppColor.homePageBackground,
            ),
          ));
    }

  }

  String convertTwo(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60);
    final secs = convertTwo(remained % 60);

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      color: color.AppColor.gradientSecond,
      child: Column(
        children: [
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: color.AppColor.loopColor,
                inactiveTrackColor: color.AppColor.secondPageTitleColor,
                trackShape: const RoundedRectSliderTrackShape(),
                trackHeight: 2.0,
                valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                tickMarkShape: const RoundSliderTickMarkShape(),
                inactiveTickMarkColor: color.AppColor.gradientSecond,
                thumbColor: color.AppColor.circuitsColor,
                valueIndicatorColor: color.AppColor.homePageBackground,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
                overlayColor: color.AppColor.setsColor,
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
                valueIndicatorTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: max(0, min(_progress * 100, 100)),
                min: 0,
                max: 100,
                divisions: 100,
                label: _positionn.toString().split('.')[0],
                onChanged: (value) {
                  setState(() {
                    _progress = value * 0.01;
                  });
                },
                onChangeStart: (value) {
                  _controller!.pause();
                },
                onChangeEnd: (value) {
                  final duration = _controller!.value.duration;
                    if (duration != null) {
                    var newValue = max(0, min(value, 99)) * 0.01;
                    var milis = (duration.inMilliseconds * newValue).toInt();
                    _controller!.seekTo(Duration(milliseconds: milis));
                    _controller!.play();
                  }
                },
              ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Padding(
                    padding : const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                    child : Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 7,
                                color: Color.fromARGB(50, 0, 0, 0)
                            )
                          ]
                      ),
                      child: noMute == true ? const Icon(
                        Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 24,
                      ) : const Icon(Icons.volume_off_outlined, color: Colors.white, size: 24,),
                    )
                ),
                onTap: () {
                  setState(() {
                    if(noMute == true){
                      _controller!.setVolume(0);
                    }else{
                      _controller!.setVolume(1.0);
                    }
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  int index = selectedIndex - 1;
                  if(index >= 0 && videoInfo.length >=0){
                    _onTapVideo(index);
                  }else{
                    Get.snackbar('Message', 'No more videos!');
                  }
                },
                child: const Icon(
                  Icons.fast_rewind_outlined,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (isPlaying) {
                    setState(() {
                      isPlaying = false;
                    });
                    _controller!.pause();
                  } else {
                    setState(() {
                      isPlaying = true;
                    });
                    _controller!.play();
                  }
                },
                child: Icon(
                  isPlaying == true ? Icons.pause : Icons.play_arrow_outlined,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              TextButton(
                onPressed: () async {
                  int index = selectedIndex + 1;
                  if(index < videoInfo.length-1){
                    _onTapVideo(index);
                  }else{
                    Get.snackbar('Message', 'No more videos!');
                  }
                },
                child: const Icon(
                  Icons.fast_forward_outlined,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              Text(
                '$mins:$secs',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  var _onUpdateControlTime;
  Duration? _durationn;
  Duration? _positionn;
  var _progress = 0.0;
  _onControllerUpdate() async {
    if(disposed){
      return;
    }
    _onUpdateControlTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControlTime > now) {
      return;
    }
    _onUpdateControlTime = now + 500;
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if(_durationn == null){
      _durationn = controller.value.duration;
    }
    var duration = _durationn;
    if (duration == null) {
      return;
    }
    var position = await controller.position;
    _positionn = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      if (disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() / duration.inMilliseconds.ceilToDouble();
      });
    }
    isPlaying = playing;
  }

  _onTapVideo(int index) {
    VideoPlayerController controller = VideoPlayerController.network(videoInfo[index]['videoUrl']);
    final old = _controller;
    _controller = controller;
    if(old != null){
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        selectedIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _listViewBuilder() {
    return ListView.builder(
        itemCount: videoInfo.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _onTapVideo(index);
                if (isPlay == false) {
                  isPlay = true;
                }
              });
            },
            child: _buildCard(index),
          );
        });
  }

  _buildCard(int index) {
    return Container(
      //margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5,top: 5),
      height: 150,
      //color: Colors.redAccent.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(videoInfo[index]['thumbnail']),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    videoInfo[index]['title'],
                    style: TextStyle(
                        color: color.AppColor.circuitsColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    videoInfo[index]['time'],
                    style: TextStyle(
                        color: color.AppColor.circuitsColor, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 25,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffeaeefc),
                ),
                child: Center(
                    child: Text(
                  '15s rest',
                  style: TextStyle(color: color.AppColor.circuitsColor),
                )),
              ),
              Row(
                children: [
                  for (int i = 0; i < 125; i++)
                    i.isEven
                        ? Container(
                            width: 2,
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Color(0xff839fed),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                          )
                        : Container(
                            width: 2,
                            height: 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                          ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

}
