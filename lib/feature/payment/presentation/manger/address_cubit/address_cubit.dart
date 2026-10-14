import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_store/core/util/hive_boxes.dart';
import 'package:my_store/feature/payment/presentation/manger/address_cubit/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());
  String addressNickName = 'Home';
  String fullAddress = '';
  void addNewAddress(String addressNickName, String fullAddress) {
    this.addressNickName = addressNickName;
    this.fullAddress = fullAddress;
    Hive.box(
      HiveBoxes.basicBox,
    ).put(HiveBoxes.kAddressNickNameBox, addressNickName);
    Hive.box(HiveBoxes.basicBox).put(HiveBoxes.kFullAddressBox, fullAddress);
    emit(
      AddressSuccess(
        addressNickName: addressNickName,
        fullAddress: fullAddress,
      ),
    );
  }

  void getAddress() {
    addressNickName = Hive.box(
      HiveBoxes.basicBox,
    ).get(HiveBoxes.kAddressNickNameBox, defaultValue: 'Home');
    fullAddress = Hive.box(
      HiveBoxes.basicBox,
    ).get(HiveBoxes.kFullAddressBox, defaultValue: 'No address selected yet');
    emit(
      AddressSuccess(
        addressNickName: addressNickName,
        fullAddress: fullAddress,
      ),
    );
  }
}
