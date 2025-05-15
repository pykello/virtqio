# Limits and Continuity

Notes based on section 1.5 of *Vector Calculus, Linear Algebra, and Differential Forms, 5th Edition* by John H. Hubbard and Barbara Burke Hubbard.

I initially attempted to write my own proofs. In few cases, I studied the proof from the book and then tried to reproduce it on my own.

I've also added some notes and expanded some of the examples to make them clearer.

### Open and Closed Sets

**Open ball.** For any $\mathbf{x} \in \mathbb{R}^n$ and $r > 0$, the open ball of radius $r$ centered at $\mathbf{x}$ is the subset

$$
B_r(\mathbf{x}) := \\{\mathbf{y} \in \mathbb{R}^n : \lVert\mathbf{x} - \mathbf{y}\rVert < r\\}.
$$

**Open set of $\mathbb{R}^n$.** A subset $U \subset \mathbb{R}^n$ is open if for every $x \in U$, there exists $r > 0$ such that $B_r(\mathbf{x}) \subset U$.

**Closed set of $\mathbb{R}^n$.** A subset $C \subset \mathbb{R}^n$ is closed if its complement $C^c = \mathbb{R}^n - C$ is open.

**Neighborhood.** A neighborhood of a point $\mathbf{x} \in \mathbb{R}^n$ is a subset $X \subset \mathbb{R}^n$ such that there exists $\epsilon > 0$ with $B_\epsilon(\mathbf{\mathbf{x}}) \subset X$.

Often, we deal with sets that are neither open or closed. But every set is contained
in a smallest closed set, called its _closure_, and largest open set, called its _interior_.

**Closure.** The _closure_ of $A \subset \mathbb{R}^n$, denoted $\overline{A}$, is the set of $\mathbf{x} \in \mathbb{R}^n$ such that for every $r > 0$, $B_r(\mathbf{x}) \cap A \neq \emptyset$.

**Interior.** The _interior_ of $A \subset \mathbb{R}^n$, denoted $\overset{\circ}{A}$, is the set of $\mathbf{x} \in \mathbb{R}^n$ such that there exists $r > 0$ with $B_r(\mathbf{x}) \subset A$.

**Boundary.** The _boundary_ of $A \subset \mathbb{R}^n$, denoted $\partial A$, is the set of $\mathbf{x} \in \mathbb{R}^n$ such that every neighborhood of $\mathbf{x}$ overlaps both $A$ and $A^c$.

Thus,
* The closure of $A$ is the union of $A$ and its boundary: $\overline{A} = A \cup \partial A$.
* The interior of $A$ is the intersection of $A$ minus its boundary: $\overset{\circ}{A} = A - \partial A$.
* The boundary of $A$ is closure minus interior: $\partial A = \overline{A} - \overset{\circ}{A}$.

### Convergence and Limits

**Convergence.** A sequence $i \mapsto \mathbf{a}_i \in \mathbb{R}^n$ _converges_ to $\mathbf{a} \in \mathbb{R}^n$ if

$$
\forall \epsilon > 0, \exists M | m > M \implies \lVert\mathbf{a}_m - \mathbf{a}\rVert < \epsilon.
$$

We call $\mathbf{a}$ the _limit_ of the sequence.

**Proposition 1.5.13 (Convergence in terms of coordinates).** A sequence $m \mapsto \mathbf{a}_m \in \mathbb{R}^n$ converges to $\mathbf{a} \in \mathbb{R}^n$ if and only if each coordinate converges.

:::expandable
**Proof.** [Click to Expand]

1. ($\implies$) Assume $m \mapsto \mathbf{a}\_m$ converges to $\mathbf{a}$. This
means for any $\epsilon > 0$, there exists $M$ such that for all $m > M$ we have:

$$
\begin{align*}
&\lVert\mathbf{a}_m - \mathbf{a}\rVert < \epsilon \\\\
\implies &
\sqrt{
    \left((a_m)_1-a_1\right)^2 + \cdots + \left((a_m)_n-a_n\right)^2
} < \epsilon \\\\
\implies &
 \left((a_m)_i-a_i\right)^2  < \epsilon^2 \\\\
\implies &
 \lVert(a_m)_i-a_i\rVert < \epsilon
\end{align*}
$$

Which means $m \mapsto (a_m)_i$ converges to $a_i$.

2. ($\impliedby$) Fix $\epsilon$. For each $a_i$ we find corresponding $M_i$ for
$\epsilon_i = \epsilon / \sqrt{n}$. Then we choose $M = \max\\{M_1,...,M_n\\}$.
For $m > M$, $\lVert\mathbf{a} - \mathbf{a}_m\rVert < \sqrt{n \cdot \left(\dfrac{\epsilon}{\sqrt{n}}\right)^2} = \epsilon$. Which means $m \mapsto \mathbf{a}_m$ converges to $\mathbf{a}$.

::::

**Proposition 1.5.14 (Elegance is not required).** Let $u$ be such that $u(\epsilon) \to 0$ as $\epsilon \to 0$. Then a sequence $i \mapsto \mathbf{a}_i$ converges to $\mathbf{a}$ if either of the following equivalent statements hold:

1. For every $\epsilon > 0$, there exists $M$ such that for all $m > M$, $\lVert\mathbf{a}_m - \mathbf{a}\rVert < u(\epsilon)$.
2. For every $\epsilon > 0$, there exists $M$ such that for all $m > M$, $\lVert\mathbf{a}_m - \mathbf{a}\rVert < \epsilon$.

:::expandable
**Proof.** [Click to Expand]

$lim_{\epsilon \to 0} u(\epsilon) = 0$ means that for every $\delta > 0$ there exists $\epsilon_0$ such that $u(\epsilon) < \delta$ for all $\epsilon < \epsilon_0$.

[TODO]

::::

**Proposition 1.5.15 (Limit of sequence is unique).** If the sequence
$i \mapsto \mathbf{a}_i$ of points in $\mathbb{R}^n$ converges to $\mathbf{a}$
and $\mathbf{b}$, then $\mathbf{a} = \mathbf{b}$.

:::expandable
**Proof.** [Click to Expand]

Assume $\mathbf{a} \ne \mathbf{b}$. Then $\epsilon_0 = \dfrac{\lVert\mathbf{a}-\mathbf{b}\rVert}{2} > 0$.

By definition of convergence, there exists $M_1$ such that for all $m > M_1$,
$\lVert\mathbf{a} - \mathbf{a}_m\rVert < \epsilon_0$. Similar $M_2$ exists for $\mathbf{b}$.

Then for all $m > \max \\{M_1, M_2\\}$, we have

$$
\begin{align*}
\lVert\mathbf{a} - \mathbf{b}\rVert &\le \lVert\mathbf{a} - \mathbf{a}_m\rVert + \lVert\mathbf{b} - \mathbf{a}_m\rVert \quad \text{(triangle inequality)} \\\\
&< \epsilon_0 + \epsilon_0  \\\\
&= \lVert\mathbf{a} - \mathbf{b}\rVert
\end{align*}
$$

Hence $\lVert\mathbf{a} - \mathbf{b}\rVert < \lVert\mathbf{a} - \mathbf{b}\rVert$, a contradiction. So, $\mathbf{a} = \mathbf{b}$.

::::

**Theorem 1.5.16 (The arithmetic of limits of sequence).** Let $i \mapsto \mathbf{a}_i$ and $i \mapsto \mathbf{b}_i$ be two sequences of points in $\mathbb{R}^n$, and let
$i \mapsto c_i$ be a sequence of numbers. Then

1. If $i \mapsto \mathbf{a}_i$ and $i \mapsto \mathbf{b}_i$ both converge, then so does $i \mapsto \mathbf{a}_i + \mathbf{b}_i$, and

$$
\lim\_{i\to\infty} \left(\mathbf{a}_i + \mathbf{b}_i\right)
\= \lim\_{i\to\infty} \mathbf{a}\_i
  \+ \lim\_{i\to\infty} \mathbf{b}\_i \tag{1.5.20}
$$

2. If $i \mapsto \mathbf{a}_i$ and $i \mapsto c_i$ both converge, then so does $i \mapsto c_i \mathbf{a}_i$, and 

$$
\lim\_{i\to\infty} c_i \mathbf{a}_i
\= \left(\lim\_{i\to\infty} c\_i \right)
  \left( \lim\_{i\to\infty} \mathbf{a}\_i \right) \tag{1.5.21}
$$

3. If $i \mapsto \mathbf{a}_i$ and $i \mapsto \mathbf{b}_i$ both converge, then so does their dot product $i \mapsto \vec{\mathbf{a}_i} \cdot \vec{\mathbf{b}_i}$, and

$$
\lim\_{i\to\infty} \left(\vec{\mathbf{a}_i} \cdot \vec{\mathbf{b}_i} \right)
\= \left(\lim\_{i\to\infty} \vec{\mathbf{a}_i} \right) \cdot
  \left( \lim\_{i\to\infty} \vec{\mathbf{b}\_i} \right) \tag{1.5.22}
$$

4. If $i \mapsto \mathbf{a}_i$ is bounded and $i \mapsto c_i$ converges to $0$, then

$$
\lim\_{i\to\infty} c_i \mathbf{a}_i \= 0 \tag{1.5.23}
$$

**Proposition 1.5.17 (Sequence in closed set).**

1. Let $i \mapsto \mathbf{x}_i$ be a sequence in a closed set $C \subset \mathbb{R}^n$
converging to $\mathbf{x} \in \mathbb{R}^n$. Then $\mathbf{x} \in C$.
2. Conversely, if every convergent sequence in $C \subset \mathbb{R}^n$ converges to 
a point in $C$, then $C$ is closed.

:::expandable
**Proof.** [Click to Expand]

1. Assume $\mathbf{x} \notin C$. Then $\mathbf{x} \in C^c$ which is open. So, there
exists $r > 0$ such that $B_r(\mathbf{x}) \subset C^c$. Since all $\mathbf{x}_i \in C$, then $\mathbf{x}_i \notin B_r(\mathbf{x})$, which means for all $i$ we have $\lVert\mathbf{x}_i - \mathbf{x}\rVert \ge r$ for every $i$. Then if we choose $\epsilon = r/2$, we can't find an $M$ such that for $m > M$ we have $\lVert\mathbf{x}_m - \mathbf{x}\rVert < \epsilon$. So, $i \mapsto \mathbf{x}_i$ doesn't converge to $\mathbf{x}$. A contradiction.

2. Assume $C$ is not closed. Choose $\mathbf{x} \in \partial C \notin C$. Since $\mathbf{x} \in \overline{C}$, then for all $r > 0$, $B_r(\mathbf{x}) \cap C \ne \emptyset$. We choose $i \mapsto \mathbf{x}_i$ such that $\mathbf{x}_i \in B\_{1/i}(\mathbf{x}) \cap C$.<br/>
This sequence converges to $\mathbf{x}$: For a given $\epsilon > 0$, for all $m > 1/\epsilon$ we have $\lVert\mathbf{x} - \mathbf{x}_m\rVert <  1/m < \epsilon$.<br/>
Since $\mathbf{x} \not\in C$, this sequence doesn't converge to a point in $C$. A contradiction. Hence, $C$ is closed.

:::

### Subsequences

**Subsequence.** $j \mapsto a_{i(j)}$ where $i(k) > i(j)$ when $k > j$.

**Proposition 1.5.19 (Subsequence of convergent sequence converges).**
If a sequence $k \mapsto \mathbf{a}_k$ converges to $\mathbf{a}$, then any
subsequence of the sequence converges to the same limit $\mathbf{a}$.

### Limits of Functions

**Limit of a function.** Let $X$ be a subset of $\mathbb{R}^n$ and $\mathbf{x}_0$ a point in $\overline{X}$. A function $\mathbf{f}: X \to \mathbb{R}^p$ has the _limit_ $\mathbf{a}$ at $\mathbf{x}_0$:

$$
\lim_{\mathbf{x}\to\mathbf{x}_0} \mathbf{f}(\mathbf{x}) = \mathbf{a}
$$

if for all $\epsilon > 0$ there exists $\delta > 0$ such that for all $\mathbf{x} \in X$,

$$
\lVert\mathbf{x} - \mathbf{x}_0\rVert < \delta \implies \lVert\mathbf{f}(\mathbf{x}) - \mathbf{a}\rVert < \epsilon
$$

> [!NOTE]
> With this definition, $\mathbf{x}_0$ need not be in $X$. It only needs to be in the
> closure of $X$. But if $\mathbf{x}_0$ is in $X$, then $\mathbf{f}(\mathbf{x}_0)$
> must be equal to $\mathbf{a}$.
>
> For example, limit of $f: \mathbb{R} \to \mathbb{R}$ doesn't exist at $0$:
> $$
> f(x) = \begin{cases}
>     1 & \text{if } x \ne 0 \\\\
>     0 & \text{if } x = 0
> \end{cases}
> $$
>
> Contrast this with the usual 1-dimensional definition of limit:
>
> **Definition (From Zorich, Mathematical Analysis I).** We shall say (following
> Cauchy) that the function $f: E \to \mathbb{R}$ tends to $A$ as $x$ tends to $a$,
> or that $A$ is the limit of $f$ as $x$ tends to $a$, if for every $\epsilon > 0$
> there exists $\delta > 0$ such that $\lvert f(x) - A \rvert < \epsilon$ for
> every $x \in E$ such that $0 < \lvert x - a \rvert < \delta$.
>
> The difference is the "greater than 0": $0 < \lvert x - a \rvert < \delta$
> instead of $\lVert\mathbf{x} - \mathbf{x}_0\rVert < \delta$.


**Proposition 1.5.21 (Limit of function is unique).** Let $f: X \to \mathbb{R}^n$ be
a function. If $f$ has a limit at $\mathbf{x}_0 \in \overline{X}$, the limit is unique.

:::expandable
**Proof.** [Click to Expand]

Assume it's not unique and $\lim_{\mathbf{x}\to\mathbf{x}_0}\mathbf{f}(\mathbf{x})$ takes two values of $\mathbf{a} \ne \mathbf{b}$. Let
$\epsilon = \dfrac{\lVert\mathbf{a} - \mathbf{b}\rVert}{2} > 0$.

Since $\mathbf{a}$ is a limit, then there exists $\delta_a$ such that for all
$\mathbf{x} \in X$, $\lVert\mathbf{x} - \mathbf{x}_0\rVert < \delta_a$ implies
$\lVert\mathbf{f}(\mathbf{x}) - \mathbf{a}\rVert < \epsilon$. Similar $\delta_b$ exists for $\mathbf{b}$.

Then for all $\mathbf{x} \in X$ such that $\lVert\mathbf{x} - \mathbf{x}_0\rVert < \min\\{\delta_a, \delta_b\\}$, we have:

$$
\begin{align*}
\lVert\mathbf{a}-\mathbf{b}\rVert &\le \lVert\mathbf{f}(\mathbf{x}) - \mathbf{a}\rVert+\lVert\mathbf{f}(\mathbf{x}) - \mathbf{b}\rVert \quad\text{(triangle inequality)} \\\\
&< \epsilon + \epsilon \\\\
&= \lVert\mathbf{a}-\mathbf{b}\rVert
\end{align*}
$$

Hence $\lVert\mathbf{a}-\mathbf{b}\rVert < \lVert\mathbf{a}-\mathbf{b}\rVert$, a contradiction. So, $\mathbf{a} = \mathbf{b}$
::::

**Theorem 1.5.22 (Limit of a composition).** Let $U \subset \mathbb{R}^n$, $V \subset \mathbb{R}^m$, and $\mathbf{f}: U \to V$  and $\mathbf{g}: V \to \mathbb{R}^k$ be mappings, so that $\mathbf{g} \circ \mathbf{f}$ is defined on $U$. If $\mathbf{x}_0 \in \overline{U}$ and

$$
\mathbf{y}_0 = \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) \quad \text{and} \quad \mathbf{z}\_0 \= \lim\_{\mathbf{y} \to \mathbf{y}_0} \mathbf{g}(\mathbf{y})
$$

both exist, then $\lim_{\mathbf{x} \to \mathbf{x}_0} \left(\mathbf{g} \circ \mathbf{f}\right)(\mathbf{x})$ exists and is equal to $\mathbf{z}_0$.

:::expandable
**Proof.** [Click to Expand]

Since $\lim\_{\mathbf{y}\to\mathbf{y}_0} \mathbf{g}(\mathbf{y}) \= \mathbf{z}_0$,

$$
\forall \epsilon > 0, \exists \eta > 0 \quad\text{s.t.}\quad\lVert \mathbf{y} - \mathbf{y}_0 \rVert < \eta \implies \lVert \mathbf{g}(\mathbf{y}) - \mathbf{z}_0 \rVert < \epsilon
$$

Since $\lim\_{\mathbf{x}\to\mathbf{x}_0} \mathbf{f}(\mathbf{x}) \= \mathbf{y}_0$,

$$
\forall \eta > 0, \exists \delta > 0 \quad\text{s.t.}\quad\lVert \mathbf{x} - \mathbf{x}_0 \rVert < \delta \implies \lVert \mathbf{f}(\mathbf{x}) - \mathbf{y}_0 \rVert < \eta
$$

Combining these, we get

$$
\forall \epsilon > 0, \exists \delta > 0 \quad\text{s.t.}\quad\lVert \mathbf{x} - \mathbf{x}_0 \rVert < \delta \implies \lVert \mathbf{g}(\mathbf{f}(\mathbf{x})) - \mathbf{z}_0 \rVert < \epsilon
$$

which is equivalent to saying $\lim_{\mathbf{x} \to \mathbf{x}_0} \left(\mathbf{g} \circ \mathbf{f}\right)(\mathbf{x}) = \mathbf{z}_0$.
::::


> [!NOTE]
> With the standard definition of limit of real functions (see the previous note),
> this theorem is not true. For example, consider $f, g: \mathbb{R} \to \mathbb{R}$
>
> $$
> f(x) = \begin{cases}
>     x \sin\left(\dfrac{1}{x}\right) & \text{if } x \ne 0 \\\\
>     0 & \text{if } x = 0
> \end{cases} \quad\text{and}\quad
> g(x) = \begin{cases}
>     1 & \text{if } x \ne 0 \\\\
>     0 & \text{if } x = 0
> \end{cases}
> $$
>
> Then using the standard definition of limit, we have $\lim_{x \to 0} f(x) = 0$ and
> $\lim_{x \to 0} g(x) = 1$. But $\lim_{x \to 0} (g \circ f)(x)$
> does not exist: $\sin(1/x) = 0$ for $x = 1/(k \pi)$, $k \in \mathbb{Z}$. So, in
> any radius $r > 0$ of $0$, we have infinitely many points where $f(x) = 0$ and
> infinitely many points where $f(x) \ne 0$. Hence, the limit of $(g \circ f)(x)$
> does not exist.
>
> With our definition, $\lim_{y \to 0} g(y)$ does not exist.

**Proposition 1.5.25 (Convergence by coordinates).** Suppose

$$
U \subset \mathbb{R}^n, \quad
\mathbf{f} =
\begin{pmatrix}
f_1 \\\\
\vdots \\\\
f_m
\end{pmatrix}
: U \to \mathbb{R}^m,
\quad \text{and} \quad
\mathbf{x}_0 \in \overline{U}.
$$

Then $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) = \begin{pmatrix}a_1\\\\ \vdots\\\\ a_m \end{pmatrix}$ if and only if $\lim\_{\mathbf{x} \to \mathbf{x}_0} f_i(\mathbf{x}) = a_i$ for all $i = 1, \ldots, m$.

:::expandable
**Proof.** [Click to Expand]

1. ($\implies$) Since $\lVert\mathbf{x}-\mathbf{y}\rVert\ge\lvert x_i-y_i \rvert$, then for each $\epsilon$ the same $\delta$ that works for the limit of vector 
function works also for the limit of each coordinate function.

2. ($\impliedby$) Fix $\epsilon$, and for each coordinate function $f_i$ find the 
$\delta_i$ corresponding to $\epsilon/\sqrt{m}$. Then use $\delta=\min\\{\delta_1,\ldots,\delta_m\\}$ for the vector function.
::::

**Theorem 1.5.26 (Limits of functions).** Let $U \subset \mathbb{R}^n$, and let $\mathbf{f}, \mathbf{g}: U \to \mathbb{R}^m$, $h: U \to \mathbb{R}$.

1. If $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x})$ and $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{g}(\mathbf{x})$ exist, then

$$
\lim\_{\mathbf{x} \to \mathbf{x}_0} (\mathbf{f} + \mathbf{g})(\mathbf{x}) = \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) + \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{g}(\mathbf{x}).
$$

2. If $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x})$ and $\lim\_{\mathbf{x} \to \mathbf{x}_0} h(\mathbf{x})$ exist, then

$$
\lim\_{\mathbf{x} \to \mathbf{x}_0} (h \mathbf{f})(\mathbf{x}) = \lim\_{\mathbf{x} \to \mathbf{x}_0} h(\mathbf{x}) \cdot \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}).
$$

3. If $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x})$ and $\lim\_{\mathbf{x} \to \mathbf{x}_0} h(\mathbf{x}) \ne 0$ exist, then

$$
\lim\_{\mathbf{x} \to \mathbf{x}_0} \left( \frac{\mathbf{f}}{h} \right)(\mathbf{x}) = \frac{\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x})}{\lim\_{\mathbf{x} \to \mathbf{x}_0} h(\mathbf{x})}.
$$

4. Define $(\mathbf{f} \cdot \mathbf{g})(\mathbf{x}) := \mathbf{f}(\mathbf{x}) \cdot \mathbf{g}(\mathbf{x})$. If $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x})$ and $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{g}(\mathbf{x})$ exist, then

$$
\lim\_{\mathbf{x} \to \mathbf{x}_0} (\mathbf{f} \cdot \mathbf{g})(\mathbf{x}) = \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) \cdot \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{g}(\mathbf{x}).
$$

5. If $\mathbf{f}$ is bounded and $\lim\_{\mathbf{x} \to \mathbf{x}_0} h(\mathbf{x}) = 0$, then

$$
\lim\_{\mathbf{x} \to \mathbf{x}_0} (h \mathbf{f})(\mathbf{x}) = 0.
$$

6. If $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) = 0$ and $h$ is bounded, then

$$
\lim\_{\mathbf{x} \to \mathbf{x}_0} (h \mathbf{f})(\mathbf{x}) = 0.
$$

:::expandable
**Proof of 4.** [Click to Expand]

Using **1.5.25**, since limit of $\mathbf{f}$ exists, then limit of each coordinate function $f_i$ exits. Part 1 and 2 apply also when the target space is one-dimensional. Induction on part 1 implies similar result for finite-sums.

So, we have:

$$
\begin{align*}
\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) \cdot \lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{g}(\mathbf{x}) &= 
\sum\_{i=1}^{m} \left(\lim\_{\mathbf{x} \to \mathbf{x}_0}{f_i(\mathbf{x})}\right)
\left(\lim\_{\mathbf{x} \to \mathbf{x}_0} {g_i(\mathbf{x})}\right)
\\\\
&= \sum\_{i=1}^{m} \lim\_{\mathbf{x} \to \mathbf{x}_0}{f_i(\mathbf{x}) g_i(\mathbf{x})} \tag{using part 2}
\\\\
&=\lim\_{\mathbf{x} \to \mathbf{x}_0} \sum\_{i=1}^{m}{f_i(\mathbf{x}) g_i(\mathbf{x})} 
\tag{using part 1}
\\\\
&= \lim\_{\mathbf{x} \to \mathbf{x}_0} (\mathbf{f} \cdot \mathbf{g})(\mathbf{x})
\end{align*}
$$
::::

### Continuous Functions

**Continuous function.** Let $X \subset \mathbb{R}^n$. A function $\mathbf{f}: X \to \mathbb{R}^m$ is _continuous_ at $\mathbf{x}\_0 \in X$ if $\lim\_{\mathbf{x} \to \mathbf{x}_0} \mathbf{f}(\mathbf{x}) = \mathbf{f}(\mathbf{x}_0)$.

$\mathbf{f}$ is continuous on $X$ if it is continuous at every point $\mathbf{x}_0 \in X$.

**Proposition 1.5.28 (Criterion for continuity).** Let $X \subset \mathbb{R}^n$. A function $\mathbf{f}: X \to \mathbb{R}^m$ is continuous at $\mathbf{x}_0 \in X$ if and only if for every sequence $i \mapsto \mathbf{x}_i$ in $X$ converging to $\mathbf{x}_0$, we have

$$
\lim\_{i\to\infty} \mathbf{f}(\mathbf{x}_i) = \mathbf{f}(\mathbf{x}_0).
$$

:::expandable
**Proof.** [Click to Expand]

[TODO: Add proof]
::::

**Theorem 1.5.29 (Combining continuous mappings).**
Let $U$ be a subset of $\mathbb{R}^n$, $\mathbf{f}$ and $\mathbf{g}$ mappings $U \to \mathbb{R}^m$, and $h$ a function $U \to \mathbb{R}$.

1. If $\mathbf{f}$ and $\mathbf{g}$ are continuous at $\mathbf{x}_0 \in U$, so is $\mathbf{f} + \mathbf{g}$.

2. If $\mathbf{f}$ and $h$ are continuous at $\mathbf{x}_0 \in U$, so is $h \mathbf{f}$.

3. If $\mathbf{f}$ and $h$ are continuous at $\mathbf{x}_0 \in U$, and $h(\mathbf{x}_0) \ne 0$, so is $\dfrac{\mathbf{f}}{h}$.

4. If $\mathbf{f}$ and $\mathbf{g}$ are continuous at $\mathbf{x}_0 \in U$, so is $\mathbf{f} \cdot \mathbf{g}$.

5. If $h$ is defined and continuous at $\mathbf{x}_0 \in \overline{U}$ with $h(\mathbf{x}_0) = 0$, and there exist $C, \delta > 0$ such that 

$$
|\mathbf{\mathbf{f}}(\mathbf{x})| \le C \quad \text{for } \mathbf{x} \in U, \quad |\mathbf{x} - \mathbf{x}_0| < \delta,
$$
then the map
$$
\mathbf{x} \mapsto
\begin{cases}
h(\mathbf{x}) \mathbf{f}(\mathbf{x}) & \text{for } \mathbf{x} \in U \\\\
0 & \text{if } \mathbf{x} = \mathbf{x}_0
\end{cases}
$$

is continuous at $\mathbf{x}_0$.
