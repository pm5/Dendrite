open ReactNative

@react.component
let make = () =>
  <Image
    source={Image.Source.fromRequired(Packager.require("../images/logo.png"))}
    />
