part of '../widgets.dart';

class ManagementCards extends StatelessWidget {
  final String cardTitle;
  final IconData cardIcon;
  final String cardRoute;
  const ManagementCards({
    Key? key,
    required this.cardTitle,
    required this.cardIcon,
    required this.cardRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.push(cardRoute);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Icon(
                cardIcon,
                size: 25,
                color: colors.primary,
              ),
              const SizedBox(height: 5),
              Text(
                cardTitle,
                style: textTheme.titleSmall!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
