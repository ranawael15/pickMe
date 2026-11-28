
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../logic/clients_cubit.dart';
import '../../logic/clients_state.dart';
import '../../data/repos/clients_repo.dart';
import '../../data/models/client_model.dart';

import 'client_information_screen.dart';
import 'package:pick_me/features/admin/clients/presentation/screens/client_details_screen.dart';

import '../widgets/clients_header.dart';
import '../widgets/clients_search_bar.dart';
import '../widgets/client_card.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  String searchQuery = '';

  void _openClientDetails(ClientModel client, ClientsCubit cubit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: cubit,
          child: ClientDetailsScreen(
            name: client.fullName,
            email: client.email,
            imageUrl: '',
            tripsCompleted: 0,
            totalSpent: '—',
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: ClientInformationScreen(
                      clientId: client.id,
                      name: client.fullName,
                      email: client.email,
                      phone: client.phone,
                      city: '',
                      imageUrl: '',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientsCubit(
        clientsRepo: ClientsRepo(Supabase.instance.client),
      )..getClients(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFAF6),
        body: SafeArea(
          child: BlocBuilder<ClientsCubit, ClientsState>(
            builder: (context, state) {
              final cubit = context.read<ClientsCubit>();
              final filteredClients = cubit.searchClients(searchQuery);

              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        20.w,
                        42.h,
                        20.w,
                        20.h,
                      ),
                      children: [
                        const ClientsHeader(),

                        SizedBox(height: 22.h),

                        ClientsSearchBar(
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                        ),

                        SizedBox(height: 20.h),

                        if (state.isLoading && state.clients.isEmpty)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else if (state.errorMessage != null &&
                            state.clients.isEmpty)
                          Center(
                            child: Column(
                              children: [
                                const Text(
                                  'Something went wrong while loading clients.',
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 10.h),
                                TextButton(
                                  onPressed: () {
                                    cubit.getClients();
                                  },
                                  child: const Text('Try Again'),
                                ),
                              ],
                            ),
                          )
                        else if (filteredClients.isEmpty)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 30.h,
                                ),
                                child: Text(
                                  searchQuery.isEmpty
                                      ? 'No clients found.'
                                      : 'No matching clients found.',
                                ),
                              ),
                            )
                          else
                            ...filteredClients.map((client) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 14.h),
                                child: ClientCard(
                                  name: client.fullName,
                                  email: client.email,
                                  imageUrl: '',
                                  bookedTrips: 0,
                                  totalSpent: '—',
                                  onViewDetails: () {
                                    _openClientDetails(client, cubit);
                                  },
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
