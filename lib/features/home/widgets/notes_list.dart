import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/common/styles/global_text_style.dart';

class NotesList extends StatelessWidget {
  final QueryDocumentSnapshot note;
  final VoidCallback onDelete;

  const NotesList({super.key, required this.note, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = ValueNotifier(false);

    final noteText = note['note'] ?? '';
    final createdAt = note['createdAt'] != null
        ? (note['createdAt'] as Timestamp).toDate()
        : null;
    final formattedDate = createdAt != null
        ? DateFormat('dd MMM yyyy, hh:mm a').format(createdAt)
        : 'N/A';

    return Dismissible(
      key: Key(note.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: ValueListenableBuilder<bool>(
        valueListenable: isExpanded,
        builder: (context, expanded, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 20),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Top Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Created: $formattedDate",
                      style: getTextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Row(
                      children: [
                        /// Collapse / Expand Icon
                        GestureDetector(
                          onTap: () => isExpanded.value = !expanded,
                          child: Icon(
                            expanded
                                ? Icons.expand_less_rounded
                                : Icons.expand_more_rounded,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(width: 8),

                        /// Delete Button
                        GestureDetector(
                          onTap: onDelete,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                /// Note Content
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 16,
                      child: Icon(
                        Icons.note,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        firstChild: Text(
                          noteText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            lineHeight: 1.4 * 15,
                          ),
                        ),
                        secondChild: Text(
                          noteText,
                          style: getTextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            lineHeight: 1.4 * 15,
                          ),
                        ),
                        crossFadeState: expanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
