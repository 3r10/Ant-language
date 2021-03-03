# `Ant` language

## Introduction

**ant_language** provides :
* A **compiler** for a simple educative language : `Ant`.
  * `Ant` language aims at teaching basic compilation skills.
  * Based on `ocamllex` and `ocamlyacc`.
  * Outputs a custom assembly code.
* A **virtual machine** `antvm.html` :
  * Written in *very vanilla* `javascript`.
  * Runs the custom assembly code.

**Test the virtual machine at :** https://3r10.github.io/Ant-language/antvm/antvm.html

`Ant` language is inspired by Langton's ant :

https://en.wikipedia.org/wiki/Langton%27s_ant

It provides several primitives (`paint`, `pick`, `move`, `turn`, ...) that allow
to control a single ant on a pixel map.

The custom assembly code is based on a machine with an infinite number of registers.

## Building

`./make_all.sh`

`./make_samples.sh`

## Usage

`./antcc < file.ant > file.s`

The destination file contains :
* An **abstract syntax tree** in ASCII format.
* The **assembly code** itself to be run on the virtual machine `antvm.html`

## `Ant` grammar

### Reference

```
<top>::= <statement_eol>* EOF

<statement_eol>::=
  | EOL
  | <statement> EOL

<statement>::=
  | ID := <expression>
  | ID @ <value>
  | if <condition> then EOL <statements_eol>* end
  | if <condition> then EOL <statements_eol>* else EOL <statements_eol>* end
  | while <condition> do EOL <statements_eol>* end
  | for ID in <expression>:<expression>:<expression> do EOL <statements_eol>* end

<condition>::=
  | <expression> == <expression>
  | <expression> != <expression>
  | <expression> >= <expression>
  | <expression> <= <expression>
  | <expression> > <expression>
  | <expression> < <expression>

<expression>:
  | <value>
  | - <value>
  | <expression> + <value>
  | <expression> - <value>

<value>:
  | INT
  | ID
```

### Examples

**Langton's ant**

```
right := -1
left := 1
for step in 1:1:30000 do
  pick @ color
  if color==0 then
    turn @ right
    paint @ 1
  else
    turn @ left
    paint @ 0
  end
  move @ 1
end
```

**Other examples**

See `.ant` files in the `samples` directory for some other examples.

## Custom assembly instruction set

### Reference

This custom assembly code is based on a machine with an **infinite number** of
registers `r0`, `r1`, `r2` ...
Immediate values are indicated with a `#`.

In the following instructions :

* `<name>` parameter should be a valid name `[a-zA-Z_][a-zA-Z0-9_]*`
* value parameters (*i.e.* `<value>`, `value1`, `value2`) may be either an
immediate value `#...` or a register content `r...`.
* `<dest>` is the destination register number.

**Instructions :**

* `label <name>` : sets a label with **unique name** `<name>`.
* `goto <name> <value>` : instruction pointer will be set to `label <name>` iff `<value>` **is 0**
* `call <name> <value>` : calls the function `<name>` with the parameter `<value>` (if the function is a *getter*)
* `call <name> r<dest>` : calls the function `<name>` and puts its result in register `<dest>` (if the function is a *setter*)
* `stop` : stops the machine

function `<name>` should be one of the predefined external functions (*see infra*)

* `set r<dest> <value>` : sets register `<dest>` with a value.
* `add r<dest> <value1> <value2>` : sets register `<dest>` with the sum of 2 values.
* `sub r<dest> <value1> <value2>` : sets register `<dest>` with the differences between 2 values.
* `test_eq r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the 2 values are equal, else to `0`.
* `test_ne r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the 2 values are different, else to `0`.
* `test_ge r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is greater or equal to `<value2>` , else to `0`.
* `test_gt r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is greater than `<value2>` , else to `0`.
* `test_le r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is less or equal to `<value2>` , else to `0`.
* `test_lt r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is less than `<value2>` , else to `0`.

### External functions

**Getters :**

* `call paint <value>` : paints current ant's cell with color `<value>`.
* `call move <value>` : makes `<value>` steps in current direction.
* `call turn <value>` : turns `<value>` times 90° to the left.

**Setters :**

* `call random r<dest>` : puts a random bit (either `0` or `1`) in register `<dest>`
* `call pick r<dest>` : puts the current color in register `<dest>`

### Examples

**You can run the examples with :** https://3r10.github.io/Ant-language/antvm/antvm.html

**Langton's ant**
*(compiled from code above)*

```
label start
  set r0 #1
  sub r0 #0 r0
  set r1 r0
  set r2 #1
  set r3 r2
  set r5 #1
  set r6 #1
  set r7 #30000
  set r4 r5
label cond0
  test_le r8 r4 r7
  goto end0 r8
  call pick r9
  set r10 r9
  set r11 #0
  test_eq r12 r10 r11
  goto else1 r12
  call turn r1
  call paint #1
  goto end1 #0
label else1
  call turn r3
  call paint #0
label end1
  call move #1
  add r4 r4 r6
  goto cond0 #0
label end0
  stop
```

**Other examples**

See `.s` files in the `samples` directory for some other examples.
