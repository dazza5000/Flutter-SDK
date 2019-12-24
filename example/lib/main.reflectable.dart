// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';
import 'package:backendless_sdk/backendless_sdk.dart' as prefix0;
import 'person.dart' as prefix1;

// ignore_for_file: unnecessary_const
// ignore_for_file: prefer_collection_literals
// ignore_for_file: prefer_adjacent_string_concatenation

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Reflector(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'Person',
            r'.Person',
            7,
            0,
            const prefix0.Reflector(),
            const <int>[0, 1, 6, 7],
            const <int>[8, 9, 10, 11, 12, 2, 3, 4, 5],
            const <int>[],
            -1,
            {},
            {},
            {
              r'': (b) => () => b ? prefix1.Person() : null,
              r'params': (b) =>
                  (name, age) => b ? prefix1.Person.params(name, age) : null
            },
            -1,
            -1,
            const <int>[-1],
            const <Object>[prefix0.reflector],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'name', 32773, 0, const prefix0.Reflector(), -1,
            1, 1, null, const []),
        r.VariableMirrorImpl(r'age', 32773, 0, const prefix0.Reflector(), -1, 2,
            2, null, const []),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 0, 2),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 0, 3),
        r.ImplicitGetterMirrorImpl(const prefix0.Reflector(), 1, 4),
        r.ImplicitSetterMirrorImpl(const prefix0.Reflector(), 1, 5),
        r.MethodMirrorImpl(r'', 0, 0, -1, 0, 0, null, const <int>[],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'params', 0, 0, -1, 0, 0, null, const <int>[0, 1],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'==', 131074, null, -1, 3, 3, null, const <int>[4],
            const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'toString', 131074, null, -1, 1, 1, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'noSuchMethod', 65538, null, null, null, null, null,
            const <int>[5], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'hashCode', 131075, null, -1, 2, 2, null,
            const <int>[], const prefix0.Reflector(), const []),
        r.MethodMirrorImpl(r'runtimeType', 131075, null, -1, 4, 4, null,
            const <int>[], const prefix0.Reflector(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(r'name', 32774, 7, const prefix0.Reflector(), -1,
            1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'age', 32774, 7, const prefix0.Reflector(), -1,
            2, 2, null, const [], null, null),
        r.ParameterMirrorImpl(r'_name', 32870, 3, const prefix0.Reflector(), -1,
            1, 1, null, const [], null, null),
        r.ParameterMirrorImpl(r'_age', 32870, 5, const prefix0.Reflector(), -1,
            2, 2, null, const [], null, null),
        r.ParameterMirrorImpl(r'other', 16390, 8, const prefix0.Reflector(),
            null, null, null, null, const [], null, null),
        r.ParameterMirrorImpl(r'invocation', 32774, 10,
            const prefix0.Reflector(), -1, 5, 5, null, const [], null, null)
      ],
      <Type>[prefix1.Person, String, int, bool, Type, Invocation],
      1,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'name': (dynamic instance) => instance.name,
        r'age': (dynamic instance) => instance.age
      },
      {
        r'name=': (dynamic instance, value) => instance.name = value,
        r'age=': (dynamic instance, value) => instance.age = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}