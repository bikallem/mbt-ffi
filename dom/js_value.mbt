///|
#external
pub type JsValue

///|
pub(open) trait TJsValue {
  to_js(Self) -> JsValue
}

///|
#cfg(target="wasm-gc")
fn undefined_ffi() -> JsValue = "JsValue" "undefined"

///|
#cfg(target="js")
extern "js" fn undefined_ffi() -> JsValue =
  #| () => undefined

///|
pub fn JsValue::undefined() -> JsValue {
  undefined_ffi()
}

///|

///|
#cfg(target="wasm-gc")
fn null_ffi() -> JsValue = "JsNull" "null"

///|
#cfg(target="js")
extern "js" fn null_ffi() -> JsValue =
  #| () => null

///|
fn[T] cast(value : JsValue) -> T = "%identity"

///|
#as_free_fn(null)
pub fn[T] JsValue::null() -> T {
  cast(null_ffi())
}

///|
pub impl TJsValue for Bool with to_js(self : Bool) -> JsValue = "%identity"

// Array FFI

///|
#cfg(target="wasm-gc")
fn new_array_ffi() -> JsValue = "JsArray" "new"

///|
#cfg(target="js")
extern "js" fn new_array_ffi() -> JsValue =
  #| () => []

///|
pub fn[T] new_array() -> Array[T] {
  cast(new_array_ffi())
}

///|
#cfg(target="wasm-gc")
fn add_to_array_ffi(ar : JsValue, val : String) -> Unit = "JsArray" "push"

///|
#cfg(target="js")
extern "js" fn add_to_array_ffi(ar : JsValue, val : String) -> Unit =
  #| (ar, val) => ar.push(val)

///|
fn[T] cast_to(value : T) -> JsValue = "%identity"

///|
pub fn add_to_array(ar : Array[String], val : String) -> Unit {
  add_to_array_ffi(cast_to(ar), val)
}
