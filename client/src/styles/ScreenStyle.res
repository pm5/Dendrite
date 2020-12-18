open ReactNative
open Style

let styles = StyleSheet.create({
  "background": viewStyle(
    ~backgroundColor="#000000",
    ~flex=1.,
    ~justifyContent=#center,
    ~alignItems=#center,
    ()),
  "text": textStyle(
    ~color="#ffffff",
    ()
    ),
})

