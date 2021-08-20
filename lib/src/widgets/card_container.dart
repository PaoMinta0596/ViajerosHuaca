import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer(
      {
      // Key? key,
      this.child});
  // : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: _createCardShape(),
          child: this.child,
        ),
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}
