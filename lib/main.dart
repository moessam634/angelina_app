import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/bloc_observer/app_bloc_observer.dart';
import 'core/utils/notification_service.dart';
import 'core/utils/service_locator.dart';
import 'fearures/cart/cubit/cart_cubit.dart';
import 'fearures/favorite/cubit/favorite_cubit.dart';
import 'fearures/profile/cubit/order_history_cubit.dart';
import 'my_app.dart';
import 'package:timezone/data/latest_all.dart' as tz;


void main() async {
  // runApp(const MyApp());
  // debugPrintRebuildDirtyWidgets = true;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  tz.initializeTimeZones();
  await NotificationService().init();
  await requestNotificationPermission();
  setupServiceLocator();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()..loadCart()),
        BlocProvider(create: (_) => FavoriteCubit()..loadFavorites()),
        BlocProvider(create: (_) => OrderHistoryCubit()..loadOrderHistory()),
      ],
      child: MyApp(),
    ),
  ));
}


Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}
