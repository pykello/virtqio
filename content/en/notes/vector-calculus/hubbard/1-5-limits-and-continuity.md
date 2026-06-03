# Limits and Continuity

Notes based on section 1.5 of *Vector Calculus, Linear Algebra, and Differential Forms, 5th Edition* by John H. Hubbard and Barbara Burke Hubbard.

There's always a piece of me in the proofs. Many are the result of my own direct attempts; others are reconstructions of proofs from the book, rewritten in my own words after learning them.

I've also added some notes and expanded some of the examples to make them clearer.

### Open and Closed Sets

**Open ball.** For any $v{x} \in bb{R}^n$ and $r > 0$, the open ball of radius $r$ centered at $v{x}$ is the subset

:::math
B_r(v{x}) := \{v{y} \in bb{R}^n : norm(v{x} - v{y}) < r\}.
:::

**Open set of $bb{R}^n$.** A subset $U \subset bb{R}^n$ is open if for every $x \in U$, there exists $r > 0$ such that $B_r(v{x}) \subset U$.

**Closed set of $bb{R}^n$.** A subset $C \subset bb{R}^n$ is closed if its complement $C^c = bb{R}^n - C$ is open.

> [!NOTE]
> * A set can be both open and closed. For example, $\emptyset$ and $bb{R}^n$ are both open and closed.
> * A set can be neither open nor closed. For example, $[0, 1)$ is neither open nor closed.

**Neighborhood.** A neighborhood of a point $v{x} \in bb{R}^n$ is a subset $X \subset bb{R}^n$ such that there exists $eps > 0$ with $B_eps(v{x}) \subset X$.

Often, we deal with sets that are neither open or closed. But every set is contained
in a smallest closed set, called its _closure_, and largest open set, called its _interior_.

**Closure.** The _closure_ of $A \subset bb{R}^n$, denoted $\overline{A}$, is the set of $v{x} \in bb{R}^n$ such that for every $r > 0$, $B_r(v{x}) \cap A != \emptyset$.

**Interior.** The _interior_ of $A \subset bb{R}^n$, denoted $\overset{\circ}{A}$, is the set of $v{x} \in bb{R}^n$ such that there exists $r > 0$ with $B_r(v{x}) \subset A$.

**Boundary.** The _boundary_ of $A \subset bb{R}^n$, denoted $\partial A$, is the set of $v{x} \in bb{R}^n$ such that every neighborhood of $v{x}$ overlaps both $A$ and $A^c$.

Thus,
* The closure of $A$ is the union of $A$ and its boundary: $\overline{A} = A \cup \partial A$.
* The interior of $A$ is the intersection of $A$ minus its boundary: $\overset{\circ}{A} = A - \partial A$.
* The boundary of $A$ is closure minus interior: $\partial A = \overline{A} - \overset{\circ}{A}$.

### Convergence and Limits

**Convergence.** A sequence $i \mapsto v{a}_i \in bb{R}^n$ _converges_ to $v{a} \in bb{R}^n$ if

:::math
forall eps > 0, exists M | m > M => norm(v{a}_m - v{a}) < eps.
:::

We call $v{a}$ the _limit_ of the sequence.

**Proposition 1.5.13 (Convergence in terms of coordinates).** A sequence $m \mapsto v{a}_m \in bb{R}^n$ converges to $v{a} \in bb{R}^n$ if and only if each coordinate converges.

:::expandable
**Proof.** [Click to Expand]

1. ($=>$) Assume $m \mapsto v{a}_m$ converges to $v{a}$. This
means for any $eps > 0$, there exists $M$ such that for all $m > M$ we have:

:::math align
&norm(v{a}_m - v{a}) < eps
=> & \sqrt{ ((a_m)_1-a_1)^2 + ... + ((a_m)_n-a_n)^2 } < eps
=> & ((a_m)_i-a_i)^2  < eps^2
=> & norm((a_m)_i-a_i) < eps
:::

Which means $m \mapsto (a_m)_i$ converges to $a_i$.

2. ($\impliedby$) Fix $eps$. For each $a_i$ we find corresponding $M_i$ for
$eps_i = eps / \sqrt{n}$. Then we choose $M = \max\{M_1,...,M_n\}$.
For $m > M$, $norm(v{a} - v{a}_m) < \sqrt{n dot (\dfrac{eps}{\sqrt{n}})^2} = eps$. Which means $m \mapsto v{a}_m$ converges to $v{a}$.

::::

**Proposition 1.5.14 (Elegance is not required).** Let $u$ be such that $u(eps) -> 0$ as $eps -> 0$. Then a sequence $i \mapsto v{a}_i$ converges to $v{a}$ if either of the following equivalent statements hold:

1. For every $eps > 0$, there exists $M$ such that for all $m > M$, $norm(v{a}_m - v{a}) < u(eps)$.
2. For every $eps > 0$, there exists $M$ such that for all $m > M$, $norm(v{a}_m - v{a}) < eps$.

:::expandable
**Proof.** [Click to Expand]

$lim[eps -> 0] u(eps) = 0$ means that for every $del > 0$ there exists $eps_0$ such that $u(eps) < del$ for all $eps < eps_0$.

[TODO]

::::

**Proposition 1.5.15 (Limit of sequence is unique).** If the sequence
$i \mapsto v{a}_i$ of points in $bb{R}^n$ converges to $v{a}$
and $v{b}$, then $v{a} = v{b}$.

:::expandable
**Proof.** [Click to Expand]

Assume $v{a} != v{b}$. Then $eps_0 = \dfrac{norm(v{a}-v{b})}{2} > 0$.

By definition of convergence, there exists $M_1$ such that for all $m > M_1$,
$norm(v{a} - v{a}_m) < eps_0$. Similar $M_2$ exists for $v{b}$.

Then for all $m > \max \{M_1, M_2\}$, we have

:::math
norm(v{a} - v{b}) <= norm(v{a} - v{a}_m) + norm(v{b} - v{a}_m) \quad \text{(triangle inequality)}
< eps_0 + eps_0
= norm(v{a} - v{b})
:::

Hence $norm(v{a} - v{b}) < norm(v{a} - v{b})$, a contradiction. So, $v{a} = v{b}$.

::::

**Theorem 1.5.16 (The arithmetic of limits of sequence).** Let $i \mapsto v{a}_i$ and $i \mapsto v{b}_i$ be two sequences of points in $bb{R}^n$, and let
$i \mapsto c_i$ be a sequence of numbers. Then

1. If $i \mapsto v{a}_i$ and $i \mapsto v{b}_i$ both converge, then so does $i \mapsto v{a}_i + v{b}_i$, and

:::math
lim[i -> inf] (v{a}_i + v{b}_i)
= lim[i -> inf] v{a}_i
  + lim[i -> inf] v{b}_i \tag{1.5.20}
:::

2. If $i \mapsto v{a}_i$ and $i \mapsto c_i$ both converge, then so does $i \mapsto c_i v{a}_i$, and

:::math
lim[i-> inf] c_i v{a}_i
= (lim[i-> inf] c_i )
  ( lim[i-> inf] v{a}_i ) \tag{1.5.21}
:::

3. If $i \mapsto v{a}_i$ and $i \mapsto v{b}_i$ both converge, then so does their dot product $i \mapsto \vec{v{a}_i} dot \vec{v{b}_i}$, and

:::math
lim[i-> inf] (\vec{v{a}_i} dot \vec{v{b}_i} )
= (lim[i-> inf] \vec{v{a}_i} ) dot
  ( lim[i-> inf] \vec{v{b}_i} ) \tag{1.5.22}
:::

4. If $i \mapsto v{a}_i$ is bounded and $i \mapsto c_i$ converges to $0$, then

:::math
lim[i-> inf] c_i v{a}_i = 0 \tag{1.5.23}
:::

**Proposition 1.5.17 (Sequence in closed set).**

1. Let $i \mapsto v{x}_i$ be a sequence in a closed set $C \subset bb{R}^n$
converging to $v{x} \in bb{R}^n$. Then $v{x} \in C$.
2. Conversely, if every convergent sequence in $C \subset bb{R}^n$ converges to
a point in $C$, then $C$ is closed.

:::expandable
**Proof.** [Click to Expand]

1. Assume $v{x} \notin C$. Then $v{x} \in C^c$ which is open. So, there
exists $r > 0$ such that $B_r(v{x}) \subset C^c$. Since all $v{x}_i \in C$, then $v{x}_i \notin B_r(v{x})$, which means for all $i$ we have $norm(v{x}_i - v{x}) >= r$ for every $i$. Then if we choose $eps = r/2$, we can't find an $M$ such that for $m > M$ we have $norm(v{x}_m - v{x}) < eps$. So, $i \mapsto v{x}_i$ doesn't converge to $v{x}$. A contradiction.

2. Assume $C$ is not closed. Choose $v{x} \in \partial C \notin C$. Since $v{x} \in \overline{C}$, then for all $r > 0$, $B_r(v{x}) \cap C != \emptyset$. We choose $i \mapsto v{x}_i$ such that $v{x}_i \in B_{1/i}(v{x}) \cap C$.<br/>
This sequence converges to $v{x}$: For a given $eps > 0$, for all $m > 1/eps$ we have $norm(v{x} - v{x}_m) <  1/m < eps$.<br/>
Since $v{x} \not\in C$, this sequence doesn't converge to a point in $C$. A contradiction. Hence, $C$ is closed.

:::

### Subsequences

**Subsequence.** $j \mapsto a_{i(j)}$ where $i(k) > i(j)$ when $k > j$.

**Proposition 1.5.19 (Subsequence of convergent sequence converges).**
If a sequence $k \mapsto v{a}_k$ converges to $v{a}$, then any
subsequence of the sequence converges to the same limit $v{a}$.

### Limits of Functions

**Limit of a function.** Let $X$ be a subset of $bb{R}^n$ and $v{x}_0$ a point in $\overline{X}$. A function $v{f}: X -> bb{R}^p$ has the _limit_ $v{a}$ at $v{x}_0$:

:::math
lim[v{x}-> v{x}_0] v{f}(v{x}) = v{a}
:::

if for all $eps > 0$ there exists $del > 0$ such that for all $v{x} \in X$,

:::math
norm(v{x} - v{x}_0) < del => norm(v{f}(v{x}) - v{a}) < eps
:::

> [!NOTE]
> With this definition, $v{x}_0$ need not be in $X$. It only needs to be in the
> closure of $X$. But if $v{x}_0$ is in $X$, then $v{f}(v{x}_0)$
> must be equal to $v{a}$.
>
> For example, limit of $f: bb{R} -> bb{R}$ doesn't exist at $0$:
> $$
> f(x) = \begin{cases}
>     1 & \text{if } x != 0 \\
>     0 & \text{if } x = 0
> \end{cases}
> $$
>
> Contrast this with the usual 1-dimensional definition of limit:
>
> **Definition (From Zorich, Mathematical Analysis I).** We shall say (following
> Cauchy) that the function $f: E -> bb{R}$ tends to $A$ as $x$ tends to $a$,
> or that $A$ is the limit of $f$ as $x$ tends to $a$, if for every $eps > 0$
> there exists $del > 0$ such that $abs(f(x) - A) < eps$ for
> every $x \in E$ such that $0 < abs(x - a) < del$.
>
> The difference is the "greater than 0": $0 < abs(x - a) < del$
> instead of $norm(v{x} - v{x}_0) < del$.


**Proposition 1.5.21 (Limit of function is unique).** Let $f: X -> bb{R}^n$ be
a function. If $f$ has a limit at $v{x}_0 \in \overline{X}$, the limit is unique.

:::expandable
**Proof.** [Click to Expand]

Assume it's not unique and $lim[v{x}-> v{x}_0]v{f}(v{x})$ takes two values of $v{a} != v{b}$. Let
$eps = \dfrac{norm(v{a} - v{b})}{2} > 0$.

Since $v{a}$ is a limit, then there exists $del_a$ such that for all
$v{x} \in X$, $norm(v{x} - v{x}_0) < del_a$ implies
$norm(v{f}(v{x}) - v{a}) < eps$. Similar $del_b$ exists for $v{b}$.

Then for all $v{x} \in X$ such that $norm(v{x} - v{x}_0) < \min\{del_a, del_b\}$, we have:

:::math align
norm(v{a}-v{b}) &<= norm(v{f}(v{x}) - v{a})+norm(v{f}(v{x}) - v{b}) \quad\text{(triangle inequality)}
&< eps + eps
&= norm(v{a}-v{b})
:::

Hence $norm(v{a}-v{b}) < norm(v{a}-v{b})$, a contradiction. So, $v{a} = v{b}$
::::

**Theorem 1.5.22 (Limit of a composition).** Let $U \subset bb{R}^n$, $V \subset bb{R}^m$, and $v{f}: U -> V$  and $v{g}: V -> bb{R}^k$ be mappings, so that $v{g} \circ v{f}$ is defined on $U$. If $v{x}_0 \in \overline{U}$ and

:::math
v{y}_0 = lim[v{x} -> v{x}_0] v{f}(v{x}) \quad \text{and} \quad v{z}_0 = lim[v{y} -> v{y}_0] v{g}(v{y})
:::

both exist, then $lim[v{x} -> v{x}_0] (v{g} \circ v{f})(v{x})$ exists and is equal to $v{z}_0$.

:::expandable
**Proof.** [Click to Expand]

Since $lim[v{y}-> v{y}_0] v{g}(v{y}) = v{z}_0$,

:::math
forall eps > 0, exists eta > 0 \quad\text{s.t.}\quad norm(v{y} - v{y}_0) < eta => norm(v{g}(v{y}) - v{z}_0) < eps
:::

Since $lim[v{x}-> v{x}_0] v{f}(v{x}) = v{y}_0$,

:::math
forall eta > 0, exists del > 0 \quad\text{s.t.}\quad norm(v{x} - v{x}_0) < del => norm(v{f}(v{x}) - v{y}_0) < eta
:::

Combining these, we get

:::math
forall eps > 0, exists del > 0 \quad\text{s.t.}\quad norm(v{x} - v{x}_0) < del => norm(v{g}(v{f}(v{x})) - v{z}_0) < eps
:::

which is equivalent to saying $lim[v{x} -> v{x}_0] (v{g} \circ v{f})(v{x}) = v{z}_0$.
::::


> [!NOTE]
> With the standard definition of limit of real functions (see the previous note),
> this theorem is not true. For example, consider $f, g: bb{R} -> bb{R}$
>
> $$
> f(x) = \begin{cases}
>     x \sin(\dfrac{1}{x}) & \text{if } x != 0 \\
>     0 & \text{if } x = 0
> \end{cases} \quad\text{and}\quad
> g(x) = \begin{cases}
>     1 & \text{if } x != 0 \\
>     0 & \text{if } x = 0
> \end{cases}
> $$
>
> Then using the standard definition of limit, we have $lim[x -> 0] f(x) = 0$ and
> $lim[x -> 0] g(x) = 1$. But $lim[x -> 0] (g \circ f)(x)$
> does not exist: $\sin(1/x) = 0$ for $x = 1/(k pi)$, $k \in bb{Z}$. So, in
> any radius $r > 0$ of $0$, we have infinitely many points where $f(x) = 0$ and
> infinitely many points where $f(x) != 0$. Hence, the limit of $(g \circ f)(x)$
> does not exist.
>
> With our definition, $lim[y -> 0] g(y)$ does not exist.

**Proposition 1.5.25 (Convergence by coordinates).** Suppose

:::math
U \subset bb{R}^n, \quad
v{f} =
pmat(f_1; \vdots; f_m)
: U -> bb{R}^m,
\quad \text{and} \quad
v{x}_0 \in \overline{U}.
:::

Then $lim[v{x} -> v{x}_0] v{f}(v{x}) = pmat(a_1; \vdots; a_m)$ if and only if $lim[v{x} -> v{x}_0] f_i(v{x}) = a_i$ for all $i = 1, ..., m$.

:::expandable
**Proof.** [Click to Expand]

1. ($=>$) Since $forall i \in \{1,...,m\}$ we have $norm(v{f}(v{x})-v{f}(v{y}))>= abs(f_i(v{x})-f_i(v{y}))$, then for each $eps$ the same $del$ that works for the limit of vector
function works also for the limit of each coordinate function.

2. ($\impliedby$) Fix $eps$, and for each coordinate function $f_i$ find the
$del_i$ corresponding to $eps/\sqrt{m}$. Then use $del=\min\{del_1,...,del_m\}$ for the vector function.
::::

**Theorem 1.5.26 (Limits of functions).** Let $U \subset bb{R}^n$, and let $v{f}, v{g}: U -> bb{R}^m$, $h: U -> bb{R}$.

1. If $lim[v{x} -> v{x}_0] v{f}(v{x})$ and $lim[v{x} -> v{x}_0] v{g}(v{x})$ exist, then

:::math
lim[v{x} -> v{x}_0] (v{f} + v{g})(v{x}) = lim[v{x} -> v{x}_0] v{f}(v{x}) + lim[v{x} -> v{x}_0] v{g}(v{x}).
:::

2. If $lim[v{x} -> v{x}_0] v{f}(v{x})$ and $lim[v{x} -> v{x}_0] h(v{x})$ exist, then

:::math
lim[v{x} -> v{x}_0] (h v{f})(v{x}) = lim[v{x} -> v{x}_0] h(v{x}) dot lim[v{x} -> v{x}_0] v{f}(v{x}).
:::

3. If $lim[v{x} -> v{x}_0] v{f}(v{x})$ and $lim[v{x} -> v{x}_0] h(v{x}) != 0$ exist, then

:::math
lim[v{x} -> v{x}_0] ( \frac{v{f}}{h} )(v{x}) = \frac{lim[v{x} -> v{x}_0] v{f}(v{x})}{lim[v{x} -> v{x}_0] h(v{x})}.
:::

4. Define $(v{f} dot v{g})(v{x}) := v{f}(v{x}) dot v{g}(v{x})$. If $lim[v{x} -> v{x}_0] v{f}(v{x})$ and $lim[v{x} -> v{x}_0] v{g}(v{x})$ exist, then

:::math
lim[v{x} -> v{x}_0] (v{f} dot v{g})(v{x}) = lim[v{x} -> v{x}_0] v{f}(v{x}) dot lim[v{x} -> v{x}_0] v{g}(v{x}).
:::

5. If $v{f}$ is bounded and $lim[v{x} -> v{x}_0] h(v{x}) = 0$, then

:::math
lim[v{x} -> v{x}_0] (h v{f})(v{x}) = 0.
:::

6. If $lim[v{x} -> v{x}_0] v{f}(v{x}) = 0$ and $h$ is bounded, then

:::math
lim[v{x} -> v{x}_0] (h v{f})(v{x}) = 0.
:::

:::expandable
**Proof of 4.** [Click to Expand]

Using **1.5.25**, since limit of $v{f}$ exists, then limit of each coordinate function $f_i$ exits. Part 1 and 2 apply also when the target space is one-dimensional. Induction on part 1 implies similar result for finite-sums.

So, we have:

:::math align
lim[v{x} -> v{x}_0] v{f}(v{x}) dot lim[v{x} -> v{x}_0] v{g}(v{x}) &= sum[i=1..m] (lim[v{x} -> v{x}_0]{f_i(v{x})}) (lim[v{x} -> v{x}_0] {g_i(v{x})})
&= sum[i=1..m] lim[v{x} -> v{x}_0]{f_i(v{x}) g_i(v{x})} \tag{using part 2}
&=lim[v{x} -> v{x}_0] sum[i=1..m]{f_i(v{x}) g_i(v{x})} \tag{using part 1}
&= lim[v{x} -> v{x}_0] (v{f} dot v{g})(v{x})
:::
::::

### Continuous Functions

**Continuous function.** Let $X \subset bb{R}^n$. A function $v{f}: X -> bb{R}^m$ is _continuous_ at $v{x}_0 \in X$ if $lim[v{x} -> v{x}_0] v{f}(v{x}) = v{f}(v{x}_0)$.

$v{f}$ is continuous on $X$ if it is continuous at every point $v{x}_0 \in X$.

> [!NOTE]
> An example of a two-variable function that is continuous only at the origin:
>
> $$
> f(x, y) = \begin{cases}
>     \dfrac{xy}{x^2 + y^2} & \text{if } (x, y) != (0, 0) \\
>     0 & \text{if } (x, y) = (0, 0)
> \end{cases}
> $$
>
> Another example:
>
> $$
> f(x, y) = \begin{cases}
>     norm((x,y)) & \text{if } (x, y) \in bb{Q}^2 \\
>     0 & \text{otherwise}
> \end{cases}
> $$

**Proposition 1.5.28 (Criterion for continuity).** Let $X \subset bb{R}^n$. A function $v{f}: X -> bb{R}^m$ is continuous at $v{x}_0 \in X$ if and only if for every sequence $i \mapsto v{x}_i$ in $X$ converging to $v{x}_0$, we have

:::math
lim[i-> inf] v{f}(v{x}_i) = v{f}(v{x}_0).
:::

:::expandable
**Proof.** [Click to Expand]

[TODO: Add proof]
::::

**Theorem 1.5.29 (Combining continuous mappings).**
Let $U$ be a subset of $bb{R}^n$, $v{f}$ and $v{g}$ mappings $U -> bb{R}^m$, and $h$ a function $U -> bb{R}$.

1. If $v{f}$ and $v{g}$ are continuous at $v{x}_0 \in U$, so is $v{f} + v{g}$.

2. If $v{f}$ and $h$ are continuous at $v{x}_0 \in U$, so is $h v{f}$.

3. If $v{f}$ and $h$ are continuous at $v{x}_0 \in U$, and $h(v{x}_0) != 0$, so is $\dfrac{v{f}}{h}$.

4. If $v{f}$ and $v{g}$ are continuous at $v{x}_0 \in U$, so is $v{f} dot v{g}$.

5. If $h$ is defined and continuous at $v{x}_0 \in \overline{U}$ with $h(v{x}_0) = 0$, and there exist $C, del > 0$ such that

:::math
|v{f}(v{x})| <= C \quad \text{for } v{x} \in U, \quad |v{x} - v{x}_0| < del,
:::
(i.e. $v{f}$ is bounded near $v{x}_0$), then the map
:::math
v{x} \mapsto cases:
h(v{x}) v{f}(v{x}) | \text{for } v{x} \in U
0 | \text{if } v{x} = v{x}_0
:::

is continuous at $v{x}_0$.

> [!NOTE]
> An example for part 5:
>
> $$
> v{f}(v{x}) = \begin{cases}
>     x \sin(\dfrac{1}{x}) & \text{if } x != 0 \\
>     0 & \text{if } x = 0
> \end{cases}
> $$
>
> Here $abs(\sin(1/x)) <= 1$ for all $x != 0$ and value of $h(x)=x$ at $0$
> is $0$. So, $v{f}$ is continuous at $0$.
>
> A discontinuous example in which the boundedness condition is not satisfied:
>
> $$
> v{f}(v{x}) = \begin{cases}
>     x \cdot \dfrac{1}{x} & \text{if } x != 0 \\
>     0 & \text{if } x = 0
> \end{cases}
> $$
>
> Then $g(x) = 1$ for all $x != 0$, but $g(0) = 0$, so $g$ is discontinuous at $x = 0$.


**Theorem 1.5.30 (Composition of continuous functions).** Let $U \subset bb{R}^n$, $V \subset bb{R}^m$, and $v{f}: U -> V$ and $v{g}: V -> bb{R}^p$ be mappings, so that $v{g} \circ v{f}$ is defined on $U$. If $v{f}$ is continuous at $v{x}_0 \in U$ and $v{g}$ is continuous at $v{f}(v{x}_0)$, then $v{g} \circ v{f}$ is continuous at $v{x}_0$.

**Corollary 1.5.31 (Continuity of polynomials and rational functions).**
1. Any polynomial function $v{f}: bb{R}^n -> bb{R}$ is continuous on all of $bb{R}^n$.
2. Any rational function $v{f}: bb{R}^n -> bb{R}$ is continuous on all of $bb{R}^n$ except at points where the denominator is $0$.

(A _rational function_ is a ratio of two polynomials.)

### Uniform Continuity

**Uniformly continuous function.** Let $X \subset bb{R}^n$. A function $v{f}: X -> bb{R}^m$ is _uniformly continuous_ on $X$ if for every $eps > 0$ there exists $del > 0$ such that for all $v{x}, v{y} \in X$, if $norm(v{x} - v{y}) < del$, then $norm(v{f}(v{x}) - v{f}(v{y})) < eps$.

> [!NOTE]
> The difference between continuity and uniform continuity is that in the latter
> the $del$ is independent of the point $v{x}_0 \in X$. For example,
> $f(x) = x^2$ is continuous on $bb{R}$, but not uniformly continuous.

**Theorem 1.5.33 (Linear functions are uniformly continuous).** Any linear function $v{f}: bb{R}^n -> bb{R}^m$ is uniformly continuous.

:::expandable
**Proof.** [Click to Expand]

Any linear function has a corresponding matrix $A$ such that $v{f}(v{x}) = A v{x}$. Then

:::math align
norm(v{f}(v{x})-v{f}(v{y})) &= norm(A dot v{x} - A dot v{y})
&= norm(A dot (v{x} - v{y}))
&= norm(A) dot norm(v{x} - v{y})
:::

Where $norm(A) = sup[norm(v)=1] norm(Av)$ is the [operator norm](https://mathworld.wolfram.com/OperatorNorm.html) of $A$.

Then, for all $eps$ if we take $del = \dfrac{eps}{norm(A) + 1 }$
, we'll have:

:::math align
norm(v{x} - v{y}) < del &=> norm(v{x} - v{y}) < \dfrac{eps}{norm(A) + 1 }
&=> (norm(A) + 1) norm(v{x} - v{y}) < eps
&=> norm(A) dot norm(v{x} - v{y}) < eps
&=> norm(v{f}(v{x})-v{f}(v{y})) < eps
:::

which means $v{f}$ is uniformly continuous.
::::

### Series of Vectors

**Convergent series of vectors.** A series $sum[i=1..inf] \vec{v{a}_i}$
is _convergent_ if the sequence of partial sums $n \mapsto \vec{v{s}_n} = sum[i=1..n] \vec{v{a}_i}$ is convergent. The limit of the series is defined as

:::math
sum[i=1..inf] \vec{v{a}_i} = lim[n -> inf] \vec{v{s}_n}
:::

**Proposition 1.5.35 (Absolute convergence).** If $sum[i=1..inf] norm(\vec{v{a}_i})$ converges, then $sum[i=1..inf] \vec{v{a}_i}$ converges.

> [!NOTE]
> This is a very important result. This can be used to prove:
> * Convergence of Newton's method
> * Euler's identity
> * That the geometric series of matrices can be treated like the geometric series of numbers

### Complex exponentials and trigonometric functions

**Proposition 1.5.36 (Complex exponentials).** For any complex number $z$, the
series $e^z = sum[n=0..inf] \dfrac{z^n}{n!}$ converges.

**Proposition 1.5.37.** For any real number $t$ we have $e^{it} = \cos(t) + i \sin(t)$.

### Geometric series of matrices

**Proposition 1.5.38.** Let $A$ be a square matrix. If $norm(A) < 1$, then the series $S = I + A + A^2 + ...$ converges to $(I - A)^{-1}$.

**Corollary 1.5.39.** If $norm(A) < 1$, then $(I - A)$ is invertible.

**Corollary 1.5.40.** The set of invertible $n cross n$ matrices is open.
