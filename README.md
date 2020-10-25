# `Ant` language

## Introduction

**ant_language** is :
* A compiler for a simple educative language : `Ant`.
  * The `Ant` language aims at teaching basic compilation skills.
  * The compiler is based on `ocamllex` and `ocamlyacc` and outputs a custom assembly code.
* A virtual machine written in *vanilla* `javasctipt` for running the assembly code.

## Building
`./make_all.sh`
`./make_samples.sh`

## Usage

`./antcc < file.ant > file.s`

The destination file contains :
* An **abstract syntax tree** in ASCII format.
* The **assembly code itself** to be run on the virtual machine `antvm.html`

## `Ant` grammar

*todo*

## Custom assembly instruction

*todo*
