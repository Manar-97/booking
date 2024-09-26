import 'package:booking/ui/widgets/failures.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../model/hotel_dm.dart';
import '../../repositories/hotels/hotel_repository.dart';

// abstract class UseCase<Type, Params> {
//   Future<Either<Failures, Type>> call(Params params);
// }
//
// class NoParams {}
//
// @injectable
// class GetHotels implements UseCase<List<HotelDM>, NoParams> {
//   final HotelRepository repository;
//
//   GetHotels(this.repository);
//
//   @override
//   Future<Either<Failures, List<HotelDM>>> call(NoParams params) async {
//     return await repository.getHotels();
//   }
// }

@injectable
class GetHotelsUseCase {
  final HotelRepository repository;
  GetHotelsUseCase(this.repository);

  Future<Either<Failures, List<HotelDM>>> callHotels() {
    return repository.getHotels();
  }
}
