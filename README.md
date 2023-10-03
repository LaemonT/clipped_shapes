# Convenient widgets with a shaped border

This package provides you with two widgets, the `ShapedBox` and `ShapeButton`.

## Features

- `ShapedBox` is a convenient widget that will clip its child widget within the desired shape, and allows you to customise the border easily.
- `ShapeButton` is the core feature of this package, that is used to provide a quick solution to buttons with a background that eventually blocks the ripple effect on Material buttons.

## Getting Started

First add the following line to your pubspec.yaml dependencies:
```
clipped_shapes: ^[latest_version]
```

## Usage

```dart
const bubbleBtn = ShapedButton.bubble(
  shapeStyle: ShapedButtonStyle.material,
  borderSide: const BorderSide(
    color: Colors.indigo,
    width: 3,
  ),
  shadows: const [
    BoxShadow(
      color: Colors.grey,
      offset: Offset(3, 3),
      blurRadius: 3,
    ),
  ],
  onPressed: () {},
  child: Container(
    color: Colors.redAccent,
    padding: const EdgeInsets.all(8.0),
    child: Text(
      'Simple button',
      style: TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    ),
  ),
);
```

## More Information

More examples are available under the `/example` folder. You may run the example app and see how it works.