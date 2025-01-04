import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../Components/AppTheme.dart';

class CounterWidget extends StatefulWidget {
  final VoidCallback incrementCounter;
  final VoidCallback decrementCounter;
  final RxInt counter; // RxInt for counter

  const CounterWidget({
    Key? key,
    required this.incrementCounter,
    required this.decrementCounter,
    required this.counter,
  }) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  bool isAdded = false; // Flag to track whether the Add button was clicked

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // If the counter is not added, show the "Add" button
        if (!isAdded)
          InkWell(
            onTap: () {
              setState(() {
                isAdded = true; // Switch to show counter buttons after Add is clicked
                widget.incrementCounter(); // Call increment function to initialize the counter
              });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppTheme.Buttoncolor, // Initial button color
              ),
              child: Icon(
                CupertinoIcons.add,
                color: Colors.white,
                size: 15,
              ),
            ),
          )
        // If the counter is added, show increment and decrement buttons
        else ...[
          InkWell(
            onTap: widget.decrementCounter,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: widget.counter.value == 1 ? AppTheme.IconBackground : Colors.red,
              ),
              child: Icon(
                CupertinoIcons.minus,
                color: widget.counter.value == 1 ? AppTheme.Buttoncolor : Colors.white,
                size: 15,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Text(
            widget.counter.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: widget.counter.value > 1 ? Colors.black : Colors.red,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          InkWell(
            onTap: widget.incrementCounter,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppTheme.Buttoncolor,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
