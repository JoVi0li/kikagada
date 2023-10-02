import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum TypeVoteRelevance { relevant, notRelevant, initial }

// ignore: must_be_immutable
class RankCardComponent extends StatefulWidget {
  RankCardComponent({
    super.key,
    required this.title,
    required this.onRatingUpdate,
    required this.onVoteRelevance,
    required this.typeVoteRelevance,
  });

  final String title;
  final void Function(double rating) onRatingUpdate;
  final void Function(bool isRelevant) onVoteRelevance;
  TypeVoteRelevance typeVoteRelevance = TypeVoteRelevance.initial;

  @override
  State<RankCardComponent> createState() => _RankCardComponentState();
}

class _RankCardComponentState extends State<RankCardComponent> {
  Widget itemBuild(BuildContext context, int index) {
    return const Icon(Icons.star, color: Colors.amber);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      titleTextStyle: Theme.of(context).textTheme.labelLarge,
      subtitle: RatingBar.builder(
        itemSize: 24,
        minRating: 1,
        itemCount: 5,
        itemBuilder: itemBuild,
        onRatingUpdate: widget.onRatingUpdate,
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_up,
              color: widget.typeVoteRelevance == TypeVoteRelevance.relevant
                  ? Colors.white
                  : Colors.white12,
            ),
            onTap: () {
              setState(() {
                widget.typeVoteRelevance = TypeVoteRelevance.relevant;
                widget.onVoteRelevance(true);
              });
            },
          ),
          GestureDetector(
            child: Icon(
              Icons.keyboard_arrow_down,
              color: widget.typeVoteRelevance == TypeVoteRelevance.notRelevant
                  ? Colors.white
                  : Colors.white12,
            ),
            onTap: () {
              setState(() {
                widget.typeVoteRelevance = TypeVoteRelevance.notRelevant;
                widget.onVoteRelevance(false);
              });
            },
          ),
        ],
      ),
    );
  }
}
