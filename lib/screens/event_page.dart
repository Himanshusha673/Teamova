import 'package:flutter/material.dart';

// class EventPage extends StatefulWidget {
//   @override
//   _EventPageState createState() => _EventPageState();
// }

// class _EventPageState extends State<EventPage> {
//   bool _isGoing = false;
//   bool _isInterested = false;
//   int _attendees = 0;
//   int _interested = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           AspectRatio(
//             aspectRatio: 16 / 9,
//             child: Container(
//               color: Colors.grey[300],
//               child: Center(
//                 child: Text(
//                   'Event Image',
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               'Event Title',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               'Event Description',
//               style: TextStyle(
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 child: Text(_isGoing ? 'Going' : 'Not Going'),
//                 onPressed: () {
//                   setState(() {
//                     _isGoing = !_isGoing;
//                     if (_isGoing) {
//                       _attendees++;
//                     } else {
//                       _attendees--;
//                     }
//                   });
//                 },
//               ),
//               ElevatedButton(
//                 child: Text(_isInterested ? 'Interested' : 'Not Interested'),
//                 onPressed: () {
//                   setState(() {
//                     _isInterested = !_isInterested;
//                     if (_isInterested) {
//                       _interested++;
//                     } else {
//                       _interested--;
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: 8.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: [
//                 Icon(Icons.people),
//                 SizedBox(width: 8.0),
//                 Text('$_attendees going'),
//                 SizedBox(width: 16.0),
//                 Icon(Icons.favorite),
//                 SizedBox(width: 8.0),
//                 Text('$_interested interested'),
//               ],
//             ),
//           ),
//           SizedBox(height: 16.0),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.blue,
//                     child: Text('${index + 1}'),
//                   ),
//                   title: Text('Attendee ${index + 1}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> events = [
    Event(
        name: 'Scavenger Hunt',
        location: 'Central Park',
        date: 'May 15, 2023',
        time: '2:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZXZlbnR8ZW58MHx8MHx8&w=1000&q=80'),
    Event(
        name: 'Escape Room',
        location: 'Escape the Room',
        date: 'May 22, 2023',
        time: '7:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZXZlbnR8ZW58MHx8MHx8&w=1000&q=80'),
    Event(
        name: 'Karaoke Night',
        location: 'The Lion\'s Den',
        date: 'May 29, 2023',
        time: '8:00 PM',
        imageUrl:
            'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZXZlbnR8ZW58MHx8MHx8&w=1000&q=80'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EventDetailsPage(event: events[index])));
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Image.network(
                      events[index].imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          events[index].name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          events[index].location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${events[index].date} at ${events[index].time}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateEventPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Event {
  final String name;
  final String location;
  final String date;
  final String time;
  final String imageUrl;

  Event({
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.imageUrl,
  });
}

class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(event.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${event.location}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${event.date}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Time: ${event.time}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add join event functionality
                    },
                    child: const Text('Join Event'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter event name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name for the event';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  hintText: 'Enter event location',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a location for the event';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  hintText: 'Enter event date',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a date for the event';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  hintText: 'Enter event time',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a time for the event';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  hintText: 'Enter event image URL',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL for the event';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final event = Event(
                        name: _nameController.text,
                        location: _locationController.text,
                        date: _dateController.text,
                        time: _timeController.text,
                        imageUrl: _imageUrlController.text,
                      );
                      Navigator.pop(context, event);
                    }
                  },
                  child: const Text('Create Event'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
