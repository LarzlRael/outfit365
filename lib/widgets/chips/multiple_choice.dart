part of '../widgets.dart';

class MultipleChoiceChip extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;

  MultipleChoiceChip({required this.options, required this.onSelectionChanged});

  @override
  _MultipleChoiceChipState createState() => _MultipleChoiceChipState();
}

class _MultipleChoiceChipState extends State<MultipleChoiceChip> {
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.options.map((String choice) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: ChoiceChip(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            avatar: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                imageMap[choice]!,
                fit: BoxFit.cover,
              ),
            ),
            label: Text(
              choice.toCapitalize(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
            selected: selectedChoices.contains(choice),
            onSelected: (selected) {
              setState(() {
                selected
                    ? selectedChoices.add(choice)
                    : selectedChoices.remove(choice);
                widget.onSelectionChanged(selectedChoices);
              });
            },
          ),
        );
      }).toList(),
    );
  }
}
