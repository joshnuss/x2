# X2

A tiny functional language with pattern matching

## Example

```
fn fib
  0 -> 0
  1 -> 1
  n -> fib(n-1) + fib(n-2)
end

print fib(100)
```
