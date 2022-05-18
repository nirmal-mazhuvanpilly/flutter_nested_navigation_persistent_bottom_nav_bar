import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/favorite_model.dart';
import 'package:flutter_test_application/models/home_model.dart';
import 'package:flutter_test_application/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class FavoriteIconWidget extends StatefulWidget {
  final FavoriteItem? favoriteItem;
  final Value? productItem;
  final bool isFavorite;
  const FavoriteIconWidget(
      {Key? key, this.favoriteItem, this.productItem, required this.isFavorite})
      : super(key: key);

  @override
  State<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _colorController;

  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _sizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 75));
    _sizeAnimation = Tween<double>(begin: 1, end: 1.5)
        .animate(CurvedAnimation(parent: _sizeController, curve: Curves.easeIn))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _sizeController.reverse();
        }
      });
    _colorController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 75));
    if (widget.isFavorite) {
      _colorAnimation = ColorTween(begin: Colors.grey, end: Colors.red)
          .animate(_colorController);
    } else {
      _colorAnimation = ColorTween(begin: Colors.red, end: Colors.grey)
          .animate(_colorController);
    }
  }

  @override
  void didUpdateWidget(covariant FavoriteIconWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite) {
      if (oldWidget.isFavorite) {
        _colorAnimation = ColorTween(begin: Colors.grey, end: Colors.red)
            .animate(_colorController);
      } else {
        _colorAnimation = ColorTween(begin: Colors.red, end: Colors.grey)
            .animate(_colorController);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sizeController.dispose();
    _colorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isFavorite) {
          _sizeController.forward();
          _colorController.forward();
          context
              .read<FavoritesProvider>()
              .addItemToFavorite(item: widget.productItem);
        } else {
          _sizeController.forward();
          _colorController.forward();
          context
              .read<FavoritesProvider>()
              .clearFromFavorites(id: widget.favoriteItem?.id);
        }
      },
      child: AnimatedBuilder(
        animation: _sizeController,
        builder: (context, child) => Icon(
          Icons.favorite,
          color: _colorAnimation.value,
          size: 30 * _sizeAnimation.value,
        ),
      ),
    );
  }
}
