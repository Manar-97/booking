import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/model/hotel.dart';
import '../../../domain/model/hotel_dm.dart';
import '../../../ui/widgets/failures.dart';

abstract class HotelRemoteDataSource {
  Future<Either<Failures, List<Hotel>>> getHotels();
}

@Injectable(as: HotelRemoteDataSource)
class HotelRemoteDataSourceImpl extends HotelRemoteDataSource {
  final FirebaseFirestore firestore;

  HotelRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failures, List<Hotel>>> getHotels() async {
    try {
      QuerySnapshot snapshot =
          await firestore.collection(Hotel.collectionName).get();
      final hotels = snapshot.docs
          .map((doc) =>
              HotelDM.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
      return Right(hotels);
    } catch (e) {
      throw Left(Failures(e.toString()));
    }
  }
}
