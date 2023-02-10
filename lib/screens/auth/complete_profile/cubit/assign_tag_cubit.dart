import 'package:bloc/bloc.dart';
import 'package:diasporacare/services/diaspocare_apis.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'assign_tag_state.dart';
part 'assign_tag_cubit.freezed.dart';

class AssignTagCubit extends Cubit<AssignTagState> {
  AssignTagCubit() : super(const AssignTagState.initial());

  assignTag(List<String> tags, userToken) async {
    emit(const AssignTagState.loading());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? facilityName = prefs.getString('facilityName');

    var resonse = await DiaspoCareAPis.assignTagToVendor(
      facilityName!,
      tags,
      userToken,
    );
    emit(AssignTagState.loaded(resonse));
  }
}
