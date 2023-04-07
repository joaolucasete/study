function bar() {
  return "Hello World!"
}

try {
  const foo = bar();
} catch (e) {
}
console.log(foo); // use of undeclared variable
