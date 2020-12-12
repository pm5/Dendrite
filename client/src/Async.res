let let_ = (promise, callback) => Js.Promise.then_(callback, promise)
let resolve = Js.Promise.resolve
let reject = Js.Promise.reject

let async = x => Js.Promise.resolve(x)
let then_ = let_
let catch = (promise, callback) => Js.Promise.catch(callback, promise)
