# EXPLANATION FOR SUBNORMAL FLOATING-POINT NUMBERS (WHAT IS A SUBNORMAL FLOATING-POINT NUMBER?)

***Source: https://stackoverflow.com/questions/8341395/what-is-a-subnormal-floating-point-number***

## IEEE 754 basics

First let's review the basics of IEEE 754 numbers are organized.

We'll focus on single precision (32-bit), but everything can be immediately generalized to other precisions.

The format is:

1 bit: sign
8 bits: exponent
23 bits: fraction

Or if you like pictures: ![](https://i.stack.imgur.com/x3va3.png)

32 bits of sign, exponent, and fraction

The sign is simple: 0 is positive, and 1 is negative, end of story.

The exponent is 8 bits long, and so it ranges from 0 to 255.

The exponent is called biased because it has an offset of -127, e.g.:

```
  0 == special case: zero or subnormal, explained below
  1 == 2 ^ -126
    ...
125 == 2 ^ -2
126 == 2 ^ -1
127 == 2 ^  0
128 == 2 ^  1
129 == 2 ^  2
    ...
254 == 2 ^ 127
255 == special case: infinity and NaN
```

## The leading bit convention

(What follows is a fictitious hypothetical narrative, not based on any actual historical research.)

While designing IEEE 754, engineers noticed that all numbers, except 0.0, have a one 1 in binary as the first digit. E.g.:

```
25.0   == (binary) 11001 == 1.1001 * 2^4
 0.625 == (binary) 0.101 == 1.01   * 2^-1
```

both start with that annoying `1.` part.

Therefore, it would be wasteful to let that digit take up one precision bit almost every single number.

For this reason, they created the "leading bit convention":

> always assume that the number starts with one

But then how to deal with 0.0? Well, they decided to create an exception:

if the exponent is 0
and the fraction is 0
then the number represents plus or minus 0.0
so that the bytes 00 00 00 00 also represent 0.0, which looks good.

If we only considered these rules, then the smallest non-zero number that can be represented would be:

* exponent: 0
* fraction: 1

which looks something like this in a hex fraction due to the leading bit convention:

`1.000002 * 2 ^ (-127)`

where .000002 is 22 zeroes with a 1 at the end.

We cannot take fraction = 0, otherwise that number would be 0.0.

But then the engineers, who also had a keen aesthetic sense, thought: isn't that ugly? That we jump from straight 0.0 to something that is not even a proper power of 2? Couldn't we represent even smaller numbers somehow? (OK, it was a bit more concerning than "ugly": it was actually people getting bad results for their computations, see "How subnormals improve computations" below).

## Subnormal numbers

The engineers scratched their heads for a while, and came back, as usual, with another good idea. What if we create a new rule:

> If the exponent is 0, then:
> * the leading bit becomes 0
> * the exponent is fixed to -126 (not -127 as if we didn't have this exception)
>
> Such numbers are called subnormal numbers (or denormal numbers which is synonym).

This rule immediately implies that the number such that:

* exponent: 0
* fraction: 0

is still 0.0, which is kind of elegant as it means one less rule to keep track of.

So 0.0 is actually a subnormal number according to our definition!

With this new rule then, the smallest non-subnormal number is:

* exponent: 1 (0 would be subnormal)
* fraction: 0

which represents:

1.0 * 2 ^ (-126)
Then, the largest subnormal number is:

* exponent: 0
* fraction: 0x7FFFFF (23 bits 1)

which equals:

0.FFFFFE * 2 ^ (-126)
where .FFFFFE is once again 23 bits one to the right of the dot.

This is pretty close to the smallest non-subnormal number, which sounds sane.

And the smallest non-zero subnormal number is:

* exponent: 0
* fraction: 1

which equals:

0.000002 * 2 ^ (-126)
which also looks pretty close to 0.0!

Unable to find any sensible way to represent numbers smaller than that, the engineers were happy, and went back to viewing cat pictures online, or whatever it is that they did in the 70s instead.

As you can see, subnormal numbers do a trade-off between precision and representation length.

As the most extreme example, the smallest non-zero subnormal:

0.000002 * 2 ^ (-126)
has essentially a precision of a single bit instead of 32-bits. For example, if we divide it by two:

0.000002 * 2 ^ (-126) / 2
we actually reach 0.0 exactly!

## Visualization

It is always a good idea to have a geometric intuition about what we learn, so here goes.

If we plot IEEE 754 floating point numbers on a line for each given exponent, it looks something like this:

```
          +---+-------+---------------+-------------------------------+
exponent  |126|  127  |      128      |              129              |
          +---+-------+---------------+-------------------------------+
          |   |       |               |                               |
          v   v       v               v                               v
          -------------------------------------------------------------
floats    ***** * * * *   *   *   *   *       *       *       *       *
          -------------------------------------------------------------
          ^   ^       ^               ^                               ^
          |   |       |               |                               |
          0.5 1.0     2.0             4.0                             8.0
```

From that we can see that:

for each exponent, there is no overlap between the represented numbers
for each exponent, we have the same number 2^23 of floating point numbers (here represented by 4 *)
within each exponent, points are equally spaced
larger exponents cover larger ranges, but with points more spread out
Now, let's bring that down all the way to exponent 0.

Without subnormals, it would hypothetically look like this:

```
          +---+---+-------+---------------+-------------------------------+
exponent  | ? | 0 |   1   |       2       |               3               |
          +---+---+-------+---------------+-------------------------------+
          |   |   |       |               |                               |
          v   v   v       v               v                               v
          -----------------------------------------------------------------
floats    *    **** * * * *   *   *   *   *       *       *       *       *
          -----------------------------------------------------------------
          ^   ^   ^       ^               ^                               ^
          |   |   |       |               |                               |
          0   |   2^-126  2^-125          2^-124                          2^-123
              |
              2^-127
```

With subnormals, it looks like this:

```
          +-------+-------+---------------+-------------------------------+
exponent  |   0   |   1   |       2       |               3               |
          +-------+-------+---------------+-------------------------------+
          |       |       |               |                               |
          v       v       v               v                               v
          -----------------------------------------------------------------
floats    * * * * * * * * *   *   *   *   *       *       *       *       *
          -----------------------------------------------------------------
          ^   ^   ^       ^               ^                               ^
          |   |   |       |               |                               |
          0   |   2^-126  2^-125          2^-124                          2^-123
              |
              2^-127
```

By comparing the two graphs, we see that:

subnormals double the length of range of exponent 0, from [2^-127, 2^-126) to [0, 2^-126)

The space between floats in subnormal range is the same as for [0, 2^-126).

the range [2^-127, 2^-126) has half the number of points that it would have without subnormals.

Half of those points go to fill the other half of the range.

the range [0, 2^-127) has some points with subnormals, but none without.

This lack of points in [0, 2^-127) is not very elegant, and is the main reason for subnormals to exist!

since the points are equally spaced:

the range [2^-128, 2^-127) has half the points than [2^-127, 2^-126) -[2^-129, 2^-128) has half the points than [2^-128, 2^-127)
and so on
This is what we mean when saying that subnormals are a tradeoff between size and precision.

## Runnable C example

Now let's play with some actual code to verify our theory.

In almost all current and desktop machines, C float represents single precision IEEE 754 floating point numbers.

This is in particular the case for my Ubuntu 18.04 amd64 Lenovo P51 laptop.

With that assumption, all assertions pass on the following program:

subnormal.c
```C
#if __STDC_VERSION__ < 201112L
#error C11 required
#endif

#ifndef __STDC_IEC_559__
#error IEEE 754 not implemented
#endif

#include <assert.h>
#include <float.h> /* FLT_HAS_SUBNORM */
#include <inttypes.h>
#include <math.h> /* isnormal */
#include <stdlib.h>
#include <stdio.h>

#if FLT_HAS_SUBNORM != 1
#error float does not have subnormal numbers
#endif

typedef struct {
    uint32_t sign, exponent, fraction;
} Float32;

Float32 float32_from_float(float f) {
    uint32_t bytes;
    Float32 float32;
    bytes = *(uint32_t*)&f;
    float32.fraction = bytes & 0x007FFFFF;
    bytes >>= 23;
    float32.exponent = bytes & 0x000000FF;
    bytes >>= 8;
    float32.sign = bytes & 0x000000001;
    bytes >>= 1;
    return float32;
}

float float_from_bytes(
    uint32_t sign,
    uint32_t exponent,
    uint32_t fraction
) {
    uint32_t bytes;
    bytes = 0;
    bytes |= sign;
    bytes <<= 8;
    bytes |= exponent;
    bytes <<= 23;
    bytes |= fraction;
    return *(float*)&bytes;
}

int float32_equal(
    float f,
    uint32_t sign,
    uint32_t exponent,
    uint32_t fraction
) {
    Float32 float32;
    float32 = float32_from_float(f);
    return
        (float32.sign     == sign) &&
        (float32.exponent == exponent) &&
        (float32.fraction == fraction)
    ;
}

void float32_print(float f) {
    Float32 float32 = float32_from_float(f);
    printf(
        "%" PRIu32 " %" PRIu32 " %" PRIu32 "\n",
        float32.sign, float32.exponent, float32.fraction
    );
}

int main(void) {
    /* Basic examples. */
    assert(float32_equal(0.5f, 0, 126, 0));
    assert(float32_equal(1.0f, 0, 127, 0));
    assert(float32_equal(2.0f, 0, 128, 0));
    assert(isnormal(0.5f));
    assert(isnormal(1.0f));
    assert(isnormal(2.0f));

    /* Quick review of C hex floating point literals. */
    assert(0.5f == 0x1.0p-1f);
    assert(1.0f == 0x1.0p0f);
    assert(2.0f == 0x1.0p1f);

    /* Sign bit. */
    assert(float32_equal(-0.5f, 1, 126, 0));
    assert(float32_equal(-1.0f, 1, 127, 0));
    assert(float32_equal(-2.0f, 1, 128, 0));
    assert(isnormal(-0.5f));
    assert(isnormal(-1.0f));
    assert(isnormal(-2.0f));

    /* The special case of 0.0 and -0.0. */
    assert(float32_equal( 0.0f, 0, 0, 0));
    assert(float32_equal(-0.0f, 1, 0, 0));
    assert(!isnormal( 0.0f));
    assert(!isnormal(-0.0f));
    assert(0.0f == -0.0f);

    /* ANSI C defines FLT_MIN as the smallest non-subnormal number. */
    assert(FLT_MIN == 0x1.0p-126f);
    assert(float32_equal(FLT_MIN, 0, 1, 0));
    assert(isnormal(FLT_MIN));

    /* The largest subnormal number. */
    float largest_subnormal = float_from_bytes(0, 0, 0x7FFFFF);
    assert(largest_subnormal == 0x0.FFFFFEp-126f);
    assert(largest_subnormal < FLT_MIN);
    assert(!isnormal(largest_subnormal));

    /* The smallest non-zero subnormal number. */
    float smallest_subnormal = float_from_bytes(0, 0, 1);
    assert(smallest_subnormal == 0x0.000002p-126f);
    assert(0.0f < smallest_subnormal);
    assert(!isnormal(smallest_subnormal));

    return EXIT_SUCCESS;
}
```

Compile and run with:

`gcc -ggdb3 -O0 -std=c11 -Wall -Wextra -Wpedantic -Werror -o subnormal.out subnormal.c
./subnormal.out`

## C++

In addition to exposing all of C's APIs, C++ also exposes some extra subnormal related functionality that is not as readily available in C in <limits>, e.g.:

denorm_min: Returns the minimum positive subnormal value of the type T
In C++ the whole API is templated for each floating point type, and is much nicer.

## Implementations

x86_64 and ARMv8 implemens IEEE 754 directly on hardware, which the C code translates to.

Subnormals seem to be less fast than normals in certain implementations: [Why does changing 0.1f to 0 slow down performance by 10x?](https://stackoverflow.com/questions/9314534/why-does-changing-0-1f-to-0-slow-down-performance-by-10x) This is mentioned in the ARM manual, see the "ARMv8 details" section of this answer.

## ARMv8 details

[ARM Architecture Reference Manual ARMv8 DDI 0487C.a manual](https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf) A1.5.4 "Flush-to-zero" describes a configurable mode where subnormals are rounded to zero to improve performance:

> The performance of floating-point processing can be reduced when doing calculations involving denormalized numbers and Underflow exceptions. In many algorithms, this performance can be recovered, without significantly affecting the accuracy of the final result, by replacing the denormalized operands and intermediate results with zeros. To permit this optimization, ARM floating-point implementations allow a Flush-to-zero mode to be used for different floating-point formats as follows:
>
> For AArch64:
>
> If FPCR.FZ==1, then Flush-to-Zero mode is used for all Single-Precision and Double-Precision inputs and outputs of all instructions.
>
> If FPCR.FZ16==1, then Flush-to-Zero mode is used for all Half-Precision inputs and outputs of floating-point instructions, other than:—Conversions between Half-Precision and Single-Precision numbers.—Conversions between Half-Precision and Double-Precision numbers.

A1.5.2 "Floating-point standards, and terminology" Table A1-3 "Floating-point terminology" confirms that subnormals and denormals are synonyms:

This manual                 IEEE 754-2008
-------------------------   -------------
[...]
Denormal, or denormalized   Subnormal
C5.2.7 "FPCR, Floating-point Control Register" describes how ARMv8 can optionally raise exceptions or set a flag bits whenever the input of a floating point operation is subnormal:

> FPCR.IDE, bit [15] Input Denormal floating-point exception trap enable. Possible values are:
>
> 0b0 Untrapped exception handling selected. If the floating-point exception occurs then the FPSR.IDC bit is set to 1.
>
> 0b1 Trapped exception handling selected. If the floating-point exception occurs, the PE does not update the FPSR.IDC bit. The trap handling software can decide whether to set the FPSR.IDC bit to 1.

D12.2.88 "MVFR1_EL1, AArch32 Media and VFP Feature Register 1" shows that denormal support is completely optional in fact, and offers a bit to detect if there is support:

> FPFtZ, bits [3:0]
>
> Flush to Zero mode. Indicates whether the floating-point implementation provides support only for the Flush-to-Zero mode of operation. Defined values are:
>
> 0b0000 Not implemented, or hardware supports only the Flush-to-Zero mode of operation.
>
> 0b0001 Hardware supports full denormalized number arithmetic.
>
> All other values are reserved.
>
> In ARMv8-A, the permitted values are 0b0000 and 0b0001.

This suggests that when subnormals are not implemented, implementations just revert to flush-to-zero.

## Infinity and NaN

Curious? I've written some things at:

* infinity: [Ranges of floating point datatype in C?](https://stackoverflow.com/questions/10108053/ranges-of-floating-point-datatype-in-c/53204544#53204544)
* NaN: [What is the difference between quiet NaN and signaling NaN?](https://stackoverflow.com/questions/18118408/what-is-difference-between-quiet-nan-and-signaling-nan/55648118#55648118)

## How subnormals improve computations

According to the Oracle (formerly Sun) [Numerical Computation Guide](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_math.html#746)

> [S]ubnormal numbers eliminate underflow as a cause for concern for a variety of computations (typically, multiply followed by add). ... The class of problems that succeed in the presence of gradual underflow, but fail with Store 0, is larger than the fans of Store 0 may realize. ... In the absence of gradual underflow, user programs need to be sensitive to the implicit inaccuracy threshold. For example, in single precision, if underflow occurs in some parts of a calculation, and Store 0 is used to replace underflowed results with 0, then accuracy can be guaranteed only to around 10-31, not 10-38, the usual lower range for single-precision exponents.

The Numerical Computation Guide refers the reader to two other papers:

* [Underflow and the Reliability of Numerical Software](https://epubs.siam.org/doi/10.1137/0905062) by James Demmel
* [Combatting the Effects of Underflow and Overflow in Determining Real Roots of Polynomials](https://dl.acm.org/doi/abs/10.1145/1057562.1057565) by S. Linnainmaa

Thanks to [Willis Blackburn](https://stackoverflow.com/users/2684196/willis-blackburn) for contributing to this section of the answer.

## Actual history

[An Interview with the Old Man of Floating-Point](https://people.eecs.berkeley.edu/~wkahan/ieee754status/754story.html) by [Charles Severance](https://en.wikipedia.org/wiki/Charles_Severance) (1998) is a short real world historical overview in the form of an interview with [William Kahan](https://en.wikipedia.org/wiki/William_Kahan) and was suggested by John Coleman in the comments.

```
=============================================================
```

From http://blogs.oracle.com/d/entry/subnormal_numbers:

> There are potentially multiple ways of representing the same number, using decimal as an example, the number 0.1 could be represented as 1*10-1 or 0.1*100 or even 0.01 * 10. The standard dictates that the numbers are always stored with the first bit as a one. In decimal that corresponds to the 1*10-1 example.
>
> Now suppose that the lowest exponent that can be represented is -100. So the smallest number that can be represented in normal form is 1*10-100. However, if we relax the constraint that the leading bit be a one, then we can actually represent smaller numbers in the same space. Taking a decimal example we could represent 0.1*10-100. This is called a subnormal number. The purpose of having subnormal numbers is to smooth the gap between the smallest normal number and zero.
>
> It is very important to realise that subnormal numbers are represented with less precision than normal numbers. In fact, they are trading reduced precision for their smaller size. Hence calculations that use subnormal numbers are not going to have the same precision as calculations on normal numbers. So an application which does significant computation on subnormal numbers is probably worth investigating to see if rescaling (i.e. multiplying the numbers by some scaling factor) would yield fewer subnormals, and more accurate results.