import 'package:flutter/material.dart';

import '../models/Note.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    Key? key,
    required this.note,
    required this.onDelete,
    required this.onEdited,
  }) : super(key: key);

  final Note note;
  final void Function() onDelete;
  final void Function(String newNote) onEdited;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.note.text);
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: theme.colorScheme.surface, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: Offset(0,5))
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              style: theme.textTheme.headline6,
              decoration: InputDecoration(border: InputBorder.none),
              maxLength: 300,
              minLines: 1,
              maxLines: 5,
              controller: textEditingController,
              onChanged: (s) => widget.onEdited(s),

            ),
          ),
          IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
