import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/tracking_provider.dart';
import 'package:provider/provider.dart';


class JourneyPage extends StatelessWidget {
  final  serviceId,firebase_id; // This should be passed from another page

  const JourneyPage({Key? key,required this.firebase_id ,required this.serviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JourneyProvider()..fetchJourneys(firebase_id: firebase_id,serviceId: serviceId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Journeys'),
        ),
        body: Consumer<JourneyProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.apiResponse == null) {
              return Center(child: Text('No data available'));
            }

            return ListView.builder(
              itemCount: provider.apiResponse!.data!.length,
              itemBuilder: (context, index) {
                final journey = provider.apiResponse!.data![index];
                return ListTile(
                  title: Text(journey.category),
                  subtitle: Text(journey.message),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
