// RUN: %target-swiftxx-frontend -I %S/Inputs -emit-silgen %s | %FileCheck --dump-input-filter=all %s

// REQUIRES: OS=macosx || OS=linux-android

import Closure

// CHECK: sil [ossa] @$s4main14testNonTrivialyyF : $@convention(thin) () -> () {
// CHECK: %[[V0:.*]] = alloc_stack $NonTrivial
// CHECK: %[[V2:.*]] = function_ref @_ZN10NonTrivialC1Ev : $@convention(c) () -> @out NonTrivial
// CHECK: %[[V3:.*]] = apply %[[V2]](%[[V0]]) : $@convention(c) () -> @out NonTrivial
// CHECK: %[[V4:.*]] = function_ref @_Z5cfunc10NonTrivial : $@convention(c) (@in_cxx NonTrivial) -> ()
// CHECK: %[[V7:.*]] = apply %[[V4]](%[[V0]]) : $@convention(c) (@in_cxx NonTrivial) -> ()
// CHECK: destroy_addr %[[V0]] : $*NonTrivial
// CHECK: dealloc_stack %[[V0]] : $*NonTrivial

public func testNonTrivial() {
  cfunc(NonTrivial());
}

// CHECK: sil [ossa] @$s4main29testNonTrivialFunctionPointeryyF : $@convention(thin) () -> () {
// CHECK: %[[V0:.*]] = function_ref @_Z8getFnPtrv : $@convention(c) () -> @convention(c) (@in_cxx NonTrivial) -> ()
// CHECK: %[[V1:.*]] = apply %[[V0]]() : $@convention(c) () -> @convention(c) (@in_cxx NonTrivial) -> ()
// CHECK: %[[V3:.*]] = alloc_stack $NonTrivial
// CHECK: %[[V7:.*]] = function_ref @_ZN10NonTrivialC1Ev : $@convention(c) () -> @out NonTrivial
// CHECK: apply %[[V7]](%[[V3]]) : $@convention(c) () -> @out NonTrivial
// CHECK: apply %[[V1]](%[[V3]]) : $@convention(c) (@in_cxx NonTrivial) -> ()
// CHECK: destroy_addr %[[V3]] : $*NonTrivial
// CHECK: dealloc_stack %[[V3]] : $*NonTrivial

public func testNonTrivialFunctionPointer() {
  let f = getFnPtr()
  f(NonTrivial())
}
