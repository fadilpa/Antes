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
          title: Text('Activity Status',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
        ),
        body: Consumer<JourneyProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.apiResponse==null||provider.apiResponse!.data!.isEmpty) {
              return Center(child: Text('No data available'));
            }

            return ListView.builder(
              itemCount: provider.apiResponse!.data!.length,
              itemBuilder: (context, index) {
                final journey = provider.apiResponse!.data![index];
                 return JourneyCard(journey: journey);
              },
            );
          },
        ),
      ),
    );
  }
}
class JourneyCard extends StatelessWidget {
  final  journey;

  const JourneyCard({Key? key, required this.journey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0,right: 8),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        elevation: 4.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                journey.category,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                journey.message,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    journey.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}