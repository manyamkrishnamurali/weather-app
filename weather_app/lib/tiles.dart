import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class tiles extends StatelessWidget {
  final String time;
  final String temparature;
  final IconData icon;

   tiles({
    super.key, 
    required this.time,
     required this.temparature,
     required this.icon,
   });


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                  width: 105,
                  child: Card(
                    elevation: 6,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8,),
                          Icon(
                            icon,
                            size: 32,
                          ),
                          SizedBox(height: 8,),
                          Text(
                            temparature,
                          )

                        ],
                      ),
                    ),
                  ),
                );

  }
}