import 'package:booking/ui/widgets/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/model/hotel_dm.dart';
import '../../../../domain/usecases/hotels/hotels_usecase.dart';

@injectable
class HotelCubit extends Cubit<HotelState> {
  final GetHotelsUseCase getHotelsUseCase;

  HotelCubit(this.getHotelsUseCase) : super(HotelInitial());

  Future<void> fetchHotels() async {
    emit(HotelLoading());
    final result = await getHotelsUseCase.callHotels();
    result.fold(
      (failure) => emit(HotelError(failure)),
      (hotels) => emit(HotelSuccess(hotels)),
    );
  }
}

// Cubit States
abstract class HotelState {}

class HotelInitial extends HotelState {}

class HotelLoading extends HotelState {}

class HotelSuccess extends HotelState {
  final List<HotelDM> hotels;
  HotelSuccess(this.hotels);
}

class HotelError extends HotelState {
  final Failures failures;
  HotelError(this.failures);
}
