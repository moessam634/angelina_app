import 'package:angelinashop/core/utils/pay_mob_service.dart';
import 'package:angelinashop/fearures/check_out/cubit/check_out_cubit.dart';
import 'package:angelinashop/fearures/home/home_cubit/products_cubit/product_cubit.dart';
import 'package:angelinashop/fearures/product_details/cubit/product_details_cubit.dart';
import 'package:angelinashop/fearures/product_details/model/data/product_details_data.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../fearures/check_out/cubit/pay_mob_cubit/pay_mob__cubit.dart';
import '../../fearures/check_out/model/data/check_out_data.dart';
import '../../fearures/home/home_cubit/categories_cubit/categories_cubit.dart';
import '../../fearures/home/model/data/home_data.dart';
import '../../fearures/profile/cubit/order_history_cubit.dart';
import '../../fearures/switcher/cubit/switcher_cubit.dart';
import 'notification_service.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  final dio = Dio();
  sl.registerSingleton(dio);
  sl.registerLazySingleton(() => HomeData(sl()));
  sl.registerLazySingleton(() => PaymobManager(sl()));
  sl.registerLazySingleton(() => ProductDetailsData(sl()));
  sl.registerLazySingleton(() => OrdersData(sl()));
  sl.registerLazySingleton<SwitcherCubit>(() => SwitcherCubit());

  sl.registerFactory(() => CategoriesCubit(sl<HomeData>()));
  sl.registerFactory(() => ProductsCubit(sl<HomeData>()));
  sl.registerFactory(() => PayMobCubit(sl<PaymobManager>()));
  sl.registerFactory(() => ProductDetailsCubit(sl<ProductDetailsData>()));
  sl.registerFactory(() => CheckOutCubit(sl<OrdersData>()));
  sl.registerFactory(() => OrderHistoryCubit());
}
