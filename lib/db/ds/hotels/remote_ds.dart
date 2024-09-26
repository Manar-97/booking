import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/model/hotel_dm.dart';
import '../../../ui/widgets/failures.dart';

abstract class HotelRemoteDataSource {
  Future<Either<Failures, List<HotelDM>>> getHotels();
}

@Injectable(as: HotelRemoteDataSource)
class HotelRemoteDataSourceImpl extends HotelRemoteDataSource {
  final FirebaseFirestore firestore;

  HotelRemoteDataSourceImpl(this.firestore);

  @override
  Future<Either<Failures, List<HotelDM>>> getHotels() async {
    try {
      QuerySnapshot snapshot =
          await firestore.collection(HotelDM.collectionName).get();
      List<HotelDM> hotels =
          snapshot.docs.map((doc) => HotelDM.fromFirestore(doc)).toList();
      return Right(hotels);
    } catch (e) {
      print("Data Source Error===========================${e.toString()}");
      return Left(Failures(e.toString()));
    }
  }
}
