import 'package:booking/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/di.dart';
import 'hotel_cubit.dart';

class HotelsScreen extends StatefulWidget {
  const HotelsScreen({super.key});
  static const String routeName = "hotels";

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
HotelCubit cubit= getIt<HotelCubit>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotels')),
      body: BlocProvider(
        create: (BuildContext context) => cubit..fetchHotels(),
        child: BlocConsumer<HotelCubit, HotelState>(
          listener: (context, state){
            if(state is HotelLoading){
              showLoading(context);
            }
          },
          builder: (context, state) {
            if (state is HotelSuccess) {
              return ListView.builder(
                itemCount: state.hotels.length,
                itemBuilder: (context, index) {
                  final hotel = state.hotels[index];
                  return ListTile(
                    title: Text(hotel.name),
                    subtitle: Text(hotel.location),
                    trailing: Text('${hotel.price} EGP/night'),
                  );
                },
              );
            } else if (state is HotelError) {
              hideLoading(context);
              ErrorWidget(state.failures.errorMessage);
            }
            return const Center(child: Text('No data'));
          },
        ),
      ),
    );
  }
}
