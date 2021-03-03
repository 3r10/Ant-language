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
  | <expr> - <value>

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

**Other exemples**

See `ant` files in the `samples` directory for some other examples.

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

`label <name>` : sets a label with **unique name** `<name>`.
`goto <name> <value>` : instruction pointer will be set to `label <name>` iff `<value>` **is 0**
`call <name> <value>` : calls the function `<name>` with the parameter `<value>` (if the function is a *getter*)
`call <name> r<dest>` : calls the function `<name>` and puts its result in register `<dest>` (if the function is a *setter*)
function `<name>` should be one of the predefined external functions (*see infra*)

`set r<dest> <value>` : sets register `<dest>` with a value.
`add r<dest> <value1> <value2>` : sets register `<dest>` with the sum of 2 values.
`sub r<dest> <value1> <value2>` : sets register `<dest>` with the differences between 2 values.
`test_eq r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the 2 values are equal, else to `0`.
`test_ne r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the 2 values are different, else to `0`.
`test_ge r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is greater or equal to `<value2>` , else to `0`.
`test_gt r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is greater than `<value2>` , else to `0`.
`test_le r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is less or equal to `<value2>` , else to `0`.
`test_lt r<dest> <value1> <value2>` : sets register `<dest>` to `1` iff the `<value1>` is less than `<value2>` , else to `0`.

### External functions

**Getters :**
