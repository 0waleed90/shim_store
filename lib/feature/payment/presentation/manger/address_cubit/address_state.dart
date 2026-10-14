abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressSuccess extends AddressState {
  final String addressNickName ;
 final String fullAddress;

  AddressSuccess({required this.addressNickName, required this.fullAddress});
}

class AddressFailure extends AddressState {}
