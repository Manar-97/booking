import 'package:booking/db/ds/hotels/remote_ds.dart';
import 'package:booking/domain/model/hotel_dm.dart';
import 'package:booking/ui/widgets/failures.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../domain/model/hotel.dart';
import '../../../domain/repositories/hotels/hotel_repository.dart';

@Injectable(as: HotelRepository)
class HotelRepositoryImpl extends HotelRepository {
  final HotelRemoteDataSource hotelRemoteDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  HotelRepositoryImpl(
      this.hotelRemoteDataSource, this.internetConnectionChecker);

  @override
  Future<Either<Failures, List<Hotel>>> getHotels() async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final hotels = await hotelRemoteDataSource.getHotels();
        return Right(hotels.right);
      } catch (e) {
        print("Repository Error ===========================${e.toString()}");
        return Left(Failures(e.toString()));
      }
    } else {
      return Left(ConnectionFailures());
    }
  }
}
