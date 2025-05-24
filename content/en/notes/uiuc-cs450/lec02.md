# CS 450 - Lecture 2

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_v5mj7noh/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/01-lecture.pdf)

Some notes and examples are from:

* Heath, M. T. (2018). Scientific computing: An introductory survey (Revised Second Edition). SIAM. https://doi.org/10.1137/1.9781611975581

#### Review: Condition Number

Conditioning is a property of the problem, not the algorithm. An inaccurate solution is not necessarily due to an inaccurate algorithm, but may be inherent to the problem itself.

**Well-conditioned** or **insensitive** problems are those for which small relative changes in the input produce small relative changes in the output.
In **ill-conditioned** or **sensitive** problems, small relative changes in the input produce large relative changes in the output.

**(Relative) Condition Number** is the relative change in the output divided by the relative change in the input. 

**Absolute Condition Number**

$$
\kappa_{abs}(f, x) = \lvert f'(x) \rvert
$$

**Relative Condition Number**

$$
\kappa_{rel}(f, x) = \left\lvert \frac{x f'(x)}{f(x)} \right\rvert
$$

Condition number of an ill-posed problem is infinite. That is, $f$ is not
differentiable for some input.

:::card[example]
**Example (Condition Number).** Let $f(x) = \sqrt{x}$. Since $f'(x) = \dfrac{1}{2\sqrt{x}}$, we have:

$$
\kappa_{rel}(f, x) = \left\lvert \frac{x f'(x)}{f(x)} \right\rvert = \left\lvert \frac{x/(2\sqrt{x})}{\sqrt{x}} \right\rvert = \frac{1}{2}
$$

This means that a given relative change in the input causes a relative change in the output of about half as much.
::::

#### Stability and Accuracy

An algorithm is **stable** if errors in the input do not grow significantly during the computation. **Stability** measures the sensitivity of an algorithm to to round-off and truncation errors.

Stability (of an algorithm) is analogous to conditioning (of a problem):
- Similarity: both relate to effects of perturbations.
- Distinction:
    - Stability refers to effects of _computational errors_ on the result computed by an algorithm.
    - Conditioning refers to effects of _data errors_ on the solution to the problem.

From the viewpoint of _backward error analysis_, an algorithm is stable if it produces a result that is close to the exact solution of a nearby problem.

An algorithm is **accurate** if $\hat{f}(x) = f(x)$ for all $x$ when computing with infinite precision. In other words, truncation error is zero.
