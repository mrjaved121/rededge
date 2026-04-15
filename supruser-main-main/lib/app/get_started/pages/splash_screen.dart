import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:suprapp/app/core/constants/app_images.dart';
import 'package:suprapp/app/core/constants/shared_pref.dart';
import 'package:suprapp/app/core/constants/static_data.dart';
import 'package:suprapp/app/features/auth/model/user_model.dart';
import 'package:suprapp/app/get_started/widgets/auth_selection_sheet.dart';
import 'package:suprapp/app/routes/go_router.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;
  Future<void> checkLoginStatus() async {
    final loggedIn = await SharedPrefs.isLoggedIn();
    if (loggedIn) {
      final userData = await SharedPrefs.getUserProfile();
      if (userData != null) {
        StaticData.model = UserModel.fromMap(userData);
      }
      if (mounted) context.pushReplacementNamed(AppRoute.homePage);
    } else {
      if (mounted) context.pushReplacementNamed(AppRoute.splashScreen);
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    checkLoginStatus();
    _controller = VideoPlayerController.asset(AppVideos.splashVideo);
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(const Duration(milliseconds: 100), () {
        if (mounted) {
          _controller.play();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  _getVideoBackground() {
    return VideoPlayer(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: const AuthSelectionSheet(),
            ),
          ],
        ),
      ),
    );
  }
}
