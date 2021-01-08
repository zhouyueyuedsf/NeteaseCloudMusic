import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_cloud_music/pages/splash_page.dart';
import 'package:netease_cloud_music/provider/play_list_model.dart';
import 'package:netease_cloud_music/provider/play_songs_model.dart';
import 'package:netease_cloud_music/provider/user_model.dart';
import 'package:netease_cloud_music/route/navigate_service.dart';
import 'package:netease_cloud_music/route/routes.dart';
import 'package:netease_cloud_music/utils/net_utils.dart';
import 'package:provider/provider.dart';

import 'application.dart';
import 'utils/log_util.dart';

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  Application.setupLocator();
  LogUtil.init(tag: 'NETEASE_MUSIC');
//  AudioPlayer.logEnabled = true;
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>(
        create: (_) => UserModel(),
      ),
      ChangeNotifierProvider<PlaySongsModel>(
        create: (_) => PlaySongsModel()..init(),
      ),
      ChangeNotifierProvider<PlayListModel>(
        create: (_) => PlayListModel(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 设置是否显示debug的ui
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // 定义一个globalKey用于全局记录widget的状态
      navigatorKey: Application.getIt<NavigateService>().key,
      // 定义主题
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          splashColor: Colors.transparent,
          tooltipTheme: TooltipThemeData(verticalOffset: -100000)),
      home: SplashPage(),
      // 根据RouteSettings信息创建fluro框架路由
      onGenerateRoute: Application.router.generator,
    );
  }
}
