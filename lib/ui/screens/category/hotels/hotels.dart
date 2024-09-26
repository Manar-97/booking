import 'package:booking/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../di/di.dart';
import 'hotel_cubit.dart';

class HotelsScreen extends StatelessWidget {
  HotelsScreen({super.key});
  static const String routeName = "hotels";

  HotelCubit cubit = getIt.get<HotelCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hotels')),
      body: BlocProvider(
        create: (BuildContext context) => cubit..fetchHotels(),
        child: BlocConsumer<HotelCubit, HotelState>(
          listener: (context, state) {
            try{if (state is HotelLoading) {
              showLoading(context);
            }}
                catch(e){
              print("Error==============${e.toString()}");
                }
          },
          builder: (context, state) {
            if (state is HotelSuccess) {
              return ListView.builder(
                itemCount: state.hotels.length,
                itemBuilder: (context, index) {
                  final hotel = state.hotels[index];
                  return ListTile(
                    title: Text(hotel.name!),
                    subtitle: Text(hotel.description!),
                    trailing: Text('${hotel.price!} EGP/night'),
                  );
                },
              );
            } else if (state is HotelError) {
              ErrorWidget(Center(child: Text(state.failures.errorMessage)));
            } else {
              return const Center(child: Text('No data'));
            }
            return const Text("======================Error");
          },
        ),
      ),
    );
  }
}
