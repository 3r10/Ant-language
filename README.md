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

*todo*

See `ant` files in the `samples` directory.

## Custom assembly instruction set

*todo*

See generated custom assembly code.
