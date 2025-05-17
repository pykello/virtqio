# Exercises for Section 1.5

**1.5.3.** Prove the following for open subsets of $\mathbb{R}^n$:
1. Any union of open sets is open.
2. A finite intersection of open sets is open.
3. An infinite intersection of open sets need not be open.

:::expandable
**Solution.** [Click to Expand]

**1.** Let $B = \bigcup_{i \in I} A_i$, where each $A_i \in \mathbb{R}^n$ is
open. Let $\mathbf{x} \in B$. Then there exists some index $i \in I$ s.t. $\mathbf{x} \in A_i$.
Since $A_i$ is open, then there is an $r > 0$ s.t. $B_r(\mathbf{x}) \subset A_i \subset B$.

Hence for each point in $B$ there's an open ball around it contained in $B$. Therefore, $B$ is open.

**2.** Let $B = \bigcap_{i \in I} A_i$ where $\lvert I\rvert = n \in \mathbb{N}$.
Let $\mathbf{x} \in B$. Then for all $i \in I$, $\mathbf{x} \in A_i$, and
since each $A_i$ is open, for all $i$ there exists $r_i > 0$ such that $B_{r_i}(\mathbf{x}) \subset A_i$. Let $p = \min_{i \in I} r_i$. Since $I$ is finite and every $r_i > 0$, we have $p > 0$.
Then for all $i \in I$, $B_p(\mathbf{x}) \subset A_i$, which implies
$B_p(\mathbf{x}) \subset B$.

Hence for each point in $B$ there's an open ball around it contained in $B$. Therefore, $B$ is open.

**3.** Let $A_i=\left(-\dfrac{1}{2^i},\dfrac{1}{2^i}\right)$, which is open
for each $i \in \mathbb{N}$. Define $B = \bigcap_{i=0}^{\infty} A_i$. Then $B = \\{0\\}$ which is not open.

::::

---------

**1.5.4.** Prove:

1. The interior of $A$ is the largest open set contained in $A$.
2. The closure of $A$ is the smallest closed set containing $A$.
3. $\overline{A} = A \cup \partial A$.
4. $\partial A = \overline{A} - \overset{\circ}{A}$.

:::expandable
**Solution.** [Click to Expand]

::::

---------

**1.5.6.** Let $A$ be a subset of $\mathbb{R}^n$. Prove $\partial A = \overline{A} \cap \overline{A^c}$.

:::expandable
**Solution.** [Click to Expand]

We need to show that $\mathbf{x} \in \partial A$ if and only if $\mathbf{x} \in \overline{A} \cap \overline{A^c}$

($\implies$) Assume $\mathbf{x} \in \partial A$. Then by definition of boundary we have:

1. $\forall r > 0$, $B_r({\mathbf{x}}) \cap A \ne \emptyset$, which implies $\mathbf{x} \in \overline{A}$.
2. $\forall r > 0$, $B_r({\mathbf{x}}) \cap A^c \ne \emptyset$, which implies $\mathbf{x} \in \overline{A^c}$.

Which means $\mathbf{x} \in \overline{A} \cap \overline{A^c}$.

($\impliedby$) Assume $\mathbf{x} \in \overline{A} \cap \overline{A^c}$. Then:
1. $\mathbf{x} \in \overline{A}$, which by definition means $\forall r > 0$, $B_r({\mathbf{x}}) \cap A \ne \emptyset$
2.  $\mathbf{x} \in \overline{A^c}$, which by definition means $\forall r > 0$, $B_r({\mathbf{x}}) \cap A^c \ne \emptyset$

So, by definition of boundary, $x \in \partial A$.

::::

---------

**1.5.9.** Suppose $\sum_{i=1}^{\infty} \mathbf{x}_i$ is a convergent series
in $\mathbb{R}^n$. Show that the triangle inequality applies

$$
\left\lVert \sum\_{i=1}^{n} \mathbf{x}_i \right\rVert \leq \sum\_{i=1}^{n} \lVert \mathbf{x}_i \rVert.
$$

:::expandable
**Solution.** [Click to Expand]

::::

---------

**1.5.10.** Let $A$ be an $n \times n$ matrix, and define

$$
e^{A} = \sum_{k=0}^{\infty} \frac{A^k}{k!} = I + A + \frac{A^2}{2!} + \frac{A^3}{3!} + \cdots
$$

1. Prove that the series converges for all $A$. Find a bound for $|e^A|$ in terms of $|A|$ and $n$.

2. Prove or disprove:
    - $e^{A+B} = e^A e^B$ for all $A$ and $B$.
    - $e^{A+B} = e^A e^B$ for all $A$ and $B$ such that $AB = BA$.
    - $e^{2A} = (e^A)^2$ for all $A$.

:::expandable
**Solution.** [Click to Expand]

::::

---------

**1.5.16.a.** 
Let $D^* \subset \mathbb{R}^2$ be the region $0 < x^2 + y^2 < 1$, and
let $f:D^* \to \mathbb{R}$ be a function. What does the following
assertion mean?

$$
\lim_{\begin{pmatrix} x \\\\ y \end{pmatrix} \to \begin{pmatrix} 0 \\\\ 0 \end{pmatrix}} f\begin{pmatrix} x \\\\ y \end{pmatrix} = a
$$

:::expandable
**Solution.** [Click to Expand]

By definition it means:

$$
\forall \epsilon > 0 \exists \delta > 0\quad \text{s.t.} \quad \sqrt{x^2+y^2} < \delta \implies \left\lVert f\begin{pmatrix} x \\\\ y \end{pmatrix} - a \right\rVert < \epsilon
$$

More intuitively it means: for any given $\epsilon$, there's an open circle centered at the origin with radius $0 < \delta < 1$ such that value of $f$ for all points in that region is in the $(a - \epsilon, a + \epsilon)$ interval.
::::

---------
**1.5.16.b.** For the following two functions, defined on $\mathbb{R}^2 - \{\mathbf{0}\}$, either show that the limit exists at $\mathbf{0}$ and find it, or show that the limit does not exist.

1.

$$
f \begin{pmatrix} x \\\\ y \end{pmatrix} = \dfrac{\sin(x + y)}{\sqrt{x^2 + y^2}}
$$

:::expandable
**Solution.** [Click to Expand]

We have $\lim\_{x\to0^-} f \begin{pmatrix} x \\\\ 0 \end{pmatrix} = \lim_{x\to 0^-}\dfrac{sin(x)}{-x} = -1$ and $\lim\_{x\to0^+} f \begin{pmatrix} x \\\\ 0 \end{pmatrix} = \lim_{x\to 0^+}\dfrac{sin(x)}{x} = +1$.

So, the limit of this function at $\mathbf{0}$ doesn't exist.

::::

2.
$$
g \begin{pmatrix} x \\\\ y \end{pmatrix} = \left(|x| + |y|\right) \ln(x^2 + y^2)
$$

:::expandable
**Solution.** [Click to Expand]

Since this is an even function, we can just focus on $x \ge 0, y \ge 0$.

$\ln(\cdot)$ is a monotonically increasing function. So, in this region
we have

\begin{align*}
\ln(x^2+y^2) &\le \ln(x^2+y^2+2xy) \\\\
&= \ln\left((x+y)^2\right) \\\\
&=2\ln(x+y)
\end{align*}

Which implies $g \begin{pmatrix} x \\\\ y \end{pmatrix} \le 2 (x + y) \ln (x + y)$.

We also have $g \begin{pmatrix} x \\\\ y \end{pmatrix} \ge 2x \ln x$.

From one-dimensional calculus we know $lim\_{x\to0^+} x\ln x = 0$.

Then,

$$
0 = \lim\_{x\to0^+} 2x\ln x \le
\lim\_{\begin{pmatrix} x \\\\ y \end{pmatrix} \to \begin{pmatrix} 0^+ \\\\ 0^+ \end{pmatrix}} g \begin{pmatrix} x \\\\ y \end{pmatrix}
\le
\lim\_{x+y\to0^+} 2(x+y)\ln(x+y) = 0
$$

So,

$$
\lim\_{\begin{pmatrix} x \\\\ y \end{pmatrix} \to \begin{pmatrix} 0^+ \\\\ 0^+ \end{pmatrix}} g \begin{pmatrix} x \\\\ y \end{pmatrix} = 0
$$

And since function is even, the non-directional limit is also 0.

::::

---------

**1.5.19.** Let $U \subset \text{Mat}(2,2)$ be the set of matrices $A$ such that
$I - A$ is invertible.

1. Show that $U$ is open, and find a sequence in $U$ that converges to $I$.
2. Consider the mapping $f:U \to \text{Mat}(2,2)$ given by $f(A) = (A^2 - I)(A - I)^{-1}$. Does $\lim\_{A \to I} f(A)$ exist? If so, find it. 

:::expandable
**Solution.** [Click to Expand]
::::

---------
**1.5.20.** Set $A = \begin{pmatrix} a & a \\\\ a & a \end{pmatrix}$.
For which values of $a \in \mathbb{R}$ does the sequence
$k \mapsto A^k$ converge as $k \to \infty$? What is the limit?

:::expandable
**Solution.** [Click to Expand]
::::

---------
**1.5.23.** Let $A$ be an $n \times n$ matrix. What does it mean to say that
the following limit exists?

$$
\lim\_{B \to A} (A - B)^{-1} (A^2 - B^2)
$$

:::expandable
**Solution.** [Click to Expand]
::::

---------
