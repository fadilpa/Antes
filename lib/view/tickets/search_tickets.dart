import 'package:flutter/material.dart';
import 'package:mentegoz_technologies/controller/Provider/name_and_num_provider.dart';
import 'package:mentegoz_technologies/view/app_bars/tickets_app_bar.dart';
import 'package:provider/provider.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
String? name;
String? number;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserNameAndNumber>(context);
    userProvider.get_user_name_and_number();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          TicketAppBar(name: name, number: number, screenWidth: screenWidth),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenHeight / 20,
                  left: screenWidth / 50,
                  right: screenWidth / 50,
                  bottom: screenHeight / 40),
              child: Container(
                height: screenHeight / 1.3,
                color: Color.fromARGB(255, 233, 233, 233),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight / 30,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                            color: Colors.grey,
                          ),
                          hintText: 'Search Ticket',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: screenHeight / 60,
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: screenHeight / 7,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Services ${index + 1}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const Text(
                                            '9 minutes ago',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Lorem ipsum dolor sit amet consecteur',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            'Accepted ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.green),
                                          ),
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: Colors.green,
                                            child: Icon(
                                              Icons.done,
                                              size: 7,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: screenHeight / 50,
                          ),
                          itemCount: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
