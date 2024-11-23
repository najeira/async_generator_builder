# async_generator_builder

This package provides `FutureGeneratorBuilder` and `StreamGeneratorBuilder`.

These are similar to FutureBuilder and StreamBuilder,
but without the boilerplate of initializing Future and Stream.

## How to use

### Installing

```yaml
dependencies:
  async_generator_builder:
    git:
      url: https://github.com/najeira/flutter_async_generator_builder
      ref: v0.0.1
```

### Import

```dart
import 'package:async_generator_builder/async_generator_builder.dart';
```

## Example

### Future

```dart
FutureGeneratorBuilder(
  generator: () => _returnFuture(),
  waiting: (_) => const Text('loading...'),
  done: (_, value) => Text('value is $value'),
  error: (_, error, __) => Text('error is $error'),
)
```

### Stream

```dart
StreamGeneratorBuilder(
  generator: () => _returnStream(),
  waiting: (_) => const Text('loading...'),
  active: (_, value) => Text('value is $value'),
  done: (_, value) => Text('value is $value'),
  error: (_, error, __) => Text('error is $error'),
)
```
