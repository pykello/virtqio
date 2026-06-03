# CS 450 - Lecture 1

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_gqc9qknj/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/01-lecture.pdf)

#### Well-posed problems

We want to approximate $y = f(x)$ given $x \in bb{R}^n$.

We are interested in well-posed problems. Problems that:
- have a solution
- have a unique solution
- the solution depends continuously on the input. That is:

$$
\lim_{hat{x}-> x} f(hat{x}) = f(x)
$$

Otherwise, the problem is ill-posed.

Examples of well-posed (or ill-posed) problems (from quiz 1):
- ❌ Given $x = r^2 \in bb{R}$, determining the value of $r \in bb{R}$
- ✅ The simulation of a pendulum, with the properties of the physical setup at the beginning as input data, and the behavior over a given period of time as output data
- ❌ Predicting the outcome of a random sample
- ✅ The evaluation of a polynomial, with the $x$ coordinate as input data
- ❌ Division of any pair of numbers
- ✅ Multiplication of any pair of numbers


#### Error Analysis
In general error is $y - hat{y}$, where $y$ is true quantity we're interested in and $hat{y}$ is the computed quantity.

Sometimes we want to keep track of the sign, but ultimately we're interested in the magnitude of the error. That is, either $norm(y - hat{y})$ (**absolute error**), or $\dfrac{norm(y - hat{y})}{norm(y)}$ (**relative error**).

**Forward error** is the difference between the true and the computed outputs: $f(x) - hat{f}(x)$. Example: as an approximation to $\sqrt{2}$, $1.4$ has a relative forward error of about $\frac{abs(1.4−1.41421356)}{abs(\sqrt{2})} \approx 0.01$.

**Backward error** equals $x - hat{x}$ when $hat{f}(x) = f(hat{x})$. That is,
it quantifies how far we must move the input to make our computed result exact.
Example: as an approximation to $\sqrt{2}$, $1.4$ has a backward error of $\frac{abs(2 − 1.4^2)}{abs(2)} = 0.02$.

#### Sources of Error
- **Representation of Numbers** (round-off error): Error when rounding a number to floating point binary representation.
- **Propagated Data Error**: $f(hat{x}) - f(x)$
- **Computational Error**: $hat{f}(x) - f(x)$. Truncation error (approximations in the algorithm; simplified model) + rounding error (using inexact representations).

#### Condition Number
The **absolute condition number** is a property of the problem, which measures its sensitivity small perturbations in the input data.

$$
\kappa_{abs}(f) = \lim_{\Delta x -> 0} abs(\frac{f(x + \Delta x) - f(x)}{\Delta x}) = abs(\frac{df}{dx} (x))
$$

When considering a space of inputs $cal{X}$, then $\kappa_{abs}(f) = \max_{x \in cal{X}} abs(\frac{df}{dx} (x))$. That is, what's the worst case scenario?

The **relative condition number** considers the relative perturbations in the input and output:

$$
\kappa_{rel}(f) = \max_{x \in cal{X}} \lim_{\Delta x -> 0} abs(\frac{(f(x + \Delta x) - f(x)) / f(x)}{\Delta x / x}) = \frac{\kappa_{abs}(f) |x|}{|f(x)|}
$$

It quantifies how much relative error in input can amplify relative error in output.
