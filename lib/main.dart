import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer/app_bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'fearures/cart/cubit/cart_cubit.dart';
import 'fearures/favorite/cubit/favorite_cubit.dart';
import 'my_app.dart';

void main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  setupServiceLocator();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartCubit()..loadCart()),
        BlocProvider(create: (_) => FavoriteCubit()..loadFavorites()),
      ],
      child: MyApp(),
    ),
  ));
}
