# Failing compilation of cairo native

When trying to compile with cairo native (with LLVM-18 installed), the following error is thrown:

```
thread 'main' panicked at /cairo_native/src/libfuncs.rs:304:51:
index out of bounds: the len is 0 but the index is 0
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
``` 

This error is originates from some_component.cairo, which has no Events, but they're exported in the main contract.cairo
file.

To remove the error, the SomeComponent must be removed from the main contract file.

---

This example is a minimal reproduction of the issue that arose when trying to compile
braavos [account contract](https://github.com/myBraavos/braavos-account-cairo/blob/696405f83c040bb16f102e3cc3274e488a410b4c/src/presets/braavos_account.cairo).

The following components (that have no events) break the compilation:

- [SRC5Component](https://github.com/myBraavos/braavos-account-cairo/blob/696405f83c040bb16f102e3cc3274e488a410b4c/src/introspection/src5.cairo)
- [RateComponent](https://github.com/myBraavos/braavos-account-cairo/blob/e8753ad1eaba0f96abe1f85684c27c3223eaa062/src/dwl/rate_service.cairo)
- [OutsideExecEvt](https://github.com/myBraavos/braavos-account-cairo/blob/696405f83c040bb16f102e3cc3274e488a410b4c/src/outside_execution/outside_execution.cairo)
