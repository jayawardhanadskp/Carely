import 'package:carely/models/caregiver_model.dart';
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
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CaregiversListProvider>(
        context,
        listen: false,
      ).fetchCaregivers();
    });

    searchController.addListener(() {
      setState(() {});
    });
  }

  List<CaregiverProfile> _filterCareGivers(List<CaregiverProfile> careGivers) {
    final queary = searchController.text.toLowerCase();
    if (queary.isEmpty) return careGivers;
    return careGivers
        .where((careGiver) => careGiver.fullName.toLowerCase().contains(queary))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Caregivers'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 50),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SearchBar(
              controller: searchController,
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(6),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              hintText: 'Search Care Giver by name',
              hintStyle: WidgetStatePropertyAll(
                TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Consumer<CaregiversListProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }
        
            final caregivers = _filterCareGivers(provider.caregivers);
        
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
      ),
    );
  }
}
