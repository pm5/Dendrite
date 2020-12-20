let useLoading = () => {
  let (count, setCount) = React.useState(() => 1)
  React.useEffect0(() => {
    let task = Js.Global.setInterval(() => {
      setCount(c => c > 20 ? 1 : c + 1)
    }, 1200)
    Some(() => Js.Global.clearInterval(task))
  })
  count
}
