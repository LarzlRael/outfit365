part of '../widgets.dart';

class MultipleChoiceChip extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;

  MultipleChoiceChip({required this.options, required this.onSelectionChanged});

  @override
  _MultipleChoiceChipState createState() => _MultipleChoiceChipState();
}

class _MultipleChoiceChipState extends State<MultipleChoiceChip> {
  @override
  Widget build(BuildContext context) {
    final mapsFinderProvider = Provider.of<MapsFinderProvider>(context);
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
            selected: mapsFinderProvider.selectedPlaces.contains(choice),
            onSelected: (selected) {
              setState(() {
                widget.onSelectionChanged(mapsFinderProvider.selectedPlaces);
              });
              mapsFinderProvider.addOrRemoveElement(choice);
            },
          ),
        );
      }).toList(),
    );
  }
}
