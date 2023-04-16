import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_new_request_count_state.dart';
part 'get_new_request_count_cubit.freezed.dart';

class GetNewRequestCountCubit extends Cubit<GetNewRequestCountState> {
  GetNewRequestCountCubit() : super(const GetNewRequestCountState.initial());

  getNewREquestCount() async {
    emit(const GetNewRequestCountState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? backEndStorageRequests = prefs.getStringList('backendStorageRequest');
    List? newRequests = prefs.getStringList('persistentLocalRequests');

    if (backEndStorageRequests == null) {
      emit(const GetNewRequestCountState.loaded('0'));
    } else {
      emit(GetNewRequestCountState.loaded(newRequests!.length.toString()));
    }
  }

  manageRequestCount() async {
    emit(const GetNewRequestCountState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');

    //LocalStorage
    List? localStorageRequests = prefs.getStringList('localStorageRequest');
    if (localStorageRequests == null) {
      prefs.setStringList('localStorageRequest', []);
    }

    //Backend storage
    List<String> backendStorage = [];
    List requests = await DiaspoCareAPis.getVendorQuoteRequests(token!);

    if (requests.isEmpty) {
      prefs.setStringList('backendStorageRequest', backendStorage);
      prefs.setStringList('localStorageRequest', []);
      emit(const GetNewRequestCountState.loaded('0'));
    } else {
      for (var request in requests) {
        backendStorage.add(request['name']);
      }
      prefs.setStringList('backendStorageRequest', backendStorage);
      backendStorage = [];

      List<String>? backendStorageRequest =
          prefs.getStringList('backendStorageRequest');
      List<String>? localStorageRequests =
          prefs.getStringList('localStorageRequest');

      List<String> difference = backendStorageRequest!
          .toSet()
          .difference(localStorageRequests!.toSet())
          .toList();
      prefs.setStringList('persistentLocalRequests', difference);

      emit(GetNewRequestCountState.loaded(difference.length.toString()));

      difference = [];
    }
  }
}
