import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/tracking_provider.dart';
import 'package:provider/provider.dart';


class TicketTracking extends StatelessWidget {
  final  ticket_id; // This should be passed from another page

  const TicketTracking({Key? key,required this.ticket_id }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JourneyProvider()..fetchTicketTracking(ticket_id: ticket_id),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Activity Status',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
        ),
        body: Consumer<JourneyProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.ticketTracking==null||provider.ticketTracking!.data!.isEmpty) {
              return Center(child: Text('No data available'));
            }

            return ListView.builder(
              itemCount: provider.ticketTracking!.data!.length,
              itemBuilder: (context, index) {
                final tickets = provider.ticketTracking!.data![index];
                 return TicketCard(tickets_status: tickets);
              },
            );
          },
        ),
      ),
    );
  }
}
class TicketCard extends StatelessWidget {
  final  tickets_status;

  const TicketCard({Key? key, required this.tickets_status}) : super(key: key);

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
                tickets_status.category,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                tickets_status.message,
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
                    tickets_status.type.toUpperCase(),
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