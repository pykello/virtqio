# Limits and Continuity

(Notes from section 1.5 of *Vector Calculus, Linear Algebra, and Differential Forms, 5th Edition* by John H. Hubbard and Barbara Burke Hubbard)

### Open and Closed Sets

**Open ball.** For any $\mathbf{x} \in \mathbb{R}^n$ and $r > 0$, the open ball of radius $r$ centered at $\mathbf{x}$ is the subset

$$
B_r(\mathbf{x}) := \\{\mathbf{y} \in \mathbb{R}^n : |\mathbf{x} - \mathbf{y}| < r\\}.
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

### Sequences

**Subsequence.** $j \mapsto a_{i(j)}$ where $i(k) > i(j)$ when $k > j$.

**Proposition 1.5.19 (Subsequence of convergent sequence converges).**
If a sequence $k \mapsto \mathbf{a}_k$ converges to $\mathbf{a}$, then any
subsequence of the sequence converges to the same limit $\mathbf{a}$.

### Limits of Functions

**Limit of a function.** Let $X$ be a subset of $\mathbb{R}^n$ and $\mathbf{x}_0$ a point in $\overline{X}$. A function $\mathbf{f}: X \to \mathbb{R}^n$ has the _limit_ $\mathbf{a}$ at $\mathbf{x}$:

$$
\lim_{\mathbf{x}\to\mathbf{x}_0} \mathbf{f}(\mathbf{x}) = \mathbf{a}
$$

if for all $\epsilon > 0$ there exists $\delta > 0$ such that for all $\mathbf{x} \in X$,

$$
\lVert\mathbf{x} - \mathbf{x}_0\rVert < \delta \implies \lVert\mathbf{f}(\mathbf{x}) - \mathbf{a}\rVert < \epsilon
$$

**Proposition 1.5.21 (Limit of function is unique).** Let $f: X \to \mathbb{R}^n$ be
a function. If $f$ has a limit at $\mathbf{x}_0 \in \overline{X}$, the limit is unique.

:::expandable
Proof. [Click to Expand]

[TODO]
::::
