import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils.dart';

abstract class Event {
  Event(this.time);

  final DateTime time;
}

class UpdateEvent extends Event {
  UpdateEvent(DateTime time, this.path, this.update) : super(time);

  final List<String> path;
  final String update;
}

class CompactEvent extends Event {
  CompactEvent(DateTime time) : super(time);
}

class OpenEvent extends Event {
  OpenEvent(DateTime time) : super(time);
}

// Widgets.

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: EventTimeline([
            CompactEvent(DateTime.now()),
            UpdateEvent(DateTime.now(), ['path', 'subpath'], 'blub'),
            CompactEvent(DateTime.now()),
            OpenEvent(DateTime.now()),
          ]),
        ),
        Expanded(
          flex: 2,
          child: DataCard(),
        ),
      ],
    );
  }
}

class EventTimeline extends StatelessWidget {
  const EventTimeline(this.events, {Key key}) : super(key: key);

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => _buildEvent(events[index]),
      ),
    );
  }

  Widget _buildEvent(Event event) {
    if (event is OpenEvent) return OpenEventView(event);
    if (event is CompactEvent) return CompactEventView(event);
    if (event is UpdateEvent) return UpdateEventView(event);
    throw 'Unknown event type ${event.runtimeType}. Event: $event';
  }
}

class OpenEventView extends StatelessWidget {
  const OpenEventView(this.event, {Key key}) : super(key: key);

  final OpenEvent event;

  @override
  Widget build(BuildContext context) {
    return EventScaffold(
      icon: Icon(Icons.open_in_browser),
      child: Text('Chest opened'),
    );
  }
}

class CompactEventView extends StatelessWidget {
  const CompactEventView(this.event, {Key key}) : super(key: key);

  final CompactEvent event;

  @override
  Widget build(BuildContext context) {
    return EventScaffold(
      icon: Icon(Icons.view_compact),
      child: Text('Compacted'),
    );
  }
}

class UpdateEventView extends StatelessWidget {
  const UpdateEventView(this.event, {Key key}) : super(key: key);

  final UpdateEvent event;

  @override
  Widget build(BuildContext context) {
    return EventScaffold(
      child: RichText(
        text: TextSpan(
          text: 'Updated ',
          children: [
            TextSpan(
              text: event.path.join(' › '),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: ' to '),
            TextSpan(
              text: event.update,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class EventScaffold extends StatelessWidget {
  const EventScaffold({
    Key key,
    this.icon,
    @required this.child,
  }) : super(key: key);

  final Widget icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: Colors.black45)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: child,
        ),
        if (icon != null) icon,
      ],
    );
  }
}

class DataCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(width: 16),
              Text(
                'Data',
                style: GoogleFonts.rajdhani(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('›', style: TextStyle(color: Colors.black45)),
              ),
              Text('path'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('›', style: TextStyle(color: Colors.black45)),
              ),
              Text('other'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('›', style: TextStyle(color: Colors.black45)),
              ),
              Text('subpath'),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 8),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Fruit(color: Colors.yellow)'),
          ),
          Divider(),
          MapCard(
            map: {
              'blub': 'kling',
              'hey': 'kling',
              'snop': 'kling',
            },
          ),
          BytesCard(
            bytes: [1, 2, 3, 4, 5, 123, 124, 125, 126],
          ),
        ],
      ),
    );
  }
}

class MapCard extends StatelessWidget {
  const MapCard({Key key, @required this.map}) : super(key: key);

  final Map<String, String> map;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in map.entries)
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: '${entry.key}: ',
                  children: [
                    TextSpan(
                      text: entry.value,
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class BytesCard extends StatelessWidget {
  const BytesCard({Key key, this.bytes}) : super(key: key);

  final List<int> bytes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SelectableText(
        bytes.map((it) => it.toRadixString(16).padLeft(2, '0')).join(' '),
        style: GoogleFonts.robotoMono(),
      ),
    );
  }
}
