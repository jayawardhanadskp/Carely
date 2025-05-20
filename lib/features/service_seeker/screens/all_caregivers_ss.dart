import 'package:carely/providers/caregivers_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carely/features/service_seeker/widgets/caregiver_card_widget_ss.dart';

class AllCaregiversListScreenSs extends StatefulWidget {
  const AllCaregiversListScreenSs({super.key});

  @override
  State<AllCaregiversListScreenSs> createState() =>
      _AllCaregiversListScreenSsState();
}

class _AllCaregiversListScreenSsState extends State<AllCaregiversListScreenSs> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CaregiversListProvider>(
        context,
        listen: false,
      ).fetchCaregivers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Caregivers'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<CaregiversListProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          final caregivers = provider.caregivers;

          return ListView.builder(
            itemCount: caregivers.length,
            itemBuilder: (context, index) {
              final caregiver = caregivers[index];
              return CaregiverCardSs(
                name: caregiver.fullName,
                imageUrl: caregiver.profileImageUrl,
                specialty: caregiver.qualifications,
                rating: 4.8,
                onViewProfile: () {
                  Navigator.pushNamed(
                    context,
                    '/seeker/caregiverProView',
                    arguments: caregiver,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
