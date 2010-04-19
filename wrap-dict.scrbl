#lang scribble/manual
@(require (for-label scheme/base
                     scheme/gui
                     scheme/contract
                     "main.ss"))

@title{wrap-dict}
@author{@(author+email "Jay McCarthy" "jay@plt-scheme.org")}

A wrapper for dictionaries with limited datatype support

@defmodule[(planet jaymccarthy/wrap-dict)]

@defproc[(make-wrapped-dict
          [to-key (any/c . -> . any/c)]
          [from-key (any/c . -> . any/c)]
          [to-val (any/c . -> . any/c)]
          [from-val (any/c . -> . any/c)])
         (dict? . -> . dict?)]

Returns a function that accepts a dictionary and returns a new dictionary with the same contents, except that whenever a key is requested it is projected with @scheme[to-key] and whenever a value is inserted it is projected with @scheme[to-val]. Similarly, whenever a key is returned it is projected with @scheme[from-key] and a value is projected with @scheme[from-val].

This is useful if your dictionary only supports limited data types such as strings in which case @scheme[to-key] should @scheme[write] and @scheme[from-key] should @scheme[read].