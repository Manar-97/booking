import 'package:booking/domain/model/hotel_dm.dart';
import 'package:booking/ui/widgets/failures.dart';
import 'package:either_dart/either.dart';

abstract class HotelRepository{
  Future<Either<Failures,List<HotelDM>>> getHotels();
}