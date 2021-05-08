import 'package:flutter/material.dart';
class Comment extends StatelessWidget {
  final VoidCallback onBack;
  final Widget child;
  final String countComment;
  final VoidCallback onSubmit;
  final TextEditingController controllerAddComment;


  const Comment({Key key, this.onBack, this.countComment, this.child, this.onSubmit, this.controllerAddComment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white60,
              ),
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                      ),
                      onPressed: onBack),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Bình luận ",style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),),

                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Text(countComment.toString()),
                  )
                ],
              ),
            ),
            Expanded(
              child: child,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controllerAddComment,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Thêm bình luận.......",
                              hintStyle: TextStyle(
                                  fontSize: 13
                              )
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: onSubmit
                      ),
                    ],
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
