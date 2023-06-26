part of '../widgets.dart';

class CircleButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final String imageSrc;
  const CircleButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final borderRadius = BorderRadius.circular(10.0);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          height: 180.0,
          /* margin: const EdgeInsets.all(15.0), */
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: borderRadius,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: FadeInImage(
                    placeholder:
                        AssetImage('assets/loadings/makeup_loading.gif'),
                    image: NetworkImage(imageSrc),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                    stops: [0.5, 1.0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Hero(
                  tag: text,
                  child: SimpleText(
                    text: text,
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
