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

**1.**
If $X \subset A$ is an open set, then:

$$
\begin{align*}
\mathbf{x} \in X &\implies
\exists\\,r > 0\quad\text{s.t.}\quad B_r(\mathbf{x}) \subset X \\\\
&\implies
\exists\\,r > 0\quad\text{s.t.}\quad B_r(\mathbf{x}) \subset A \\\\
&\implies
\mathbf{x} \in \overset{\circ}{A}
\end{align*}
$$

Therefore, $X \subset \overset{\circ}{A}$. Also, $\overset{\circ}{A}$ itself is open and contained in $A$. So,
$\overset{\circ}{A}$ is the largest open set contained in $A$.

**2.**

**First we show that $\overline{A}$ is closed.** To do this,
we need to show that $\overline{A}^c$ is open. To do this,
we need to show if $x \in \overline{A}^c$ then there is
$r > 0$ s.t. $B_r(x) \subset \overline{A}^c$.

We'll use the following lemma in our proof.

**Lemma.** If $B_r(\mathbf{x}) \cap A = \emptyset$, then
$B_r(\mathbf{x}) \cap \overline{A} = \emptyset$

Using this lemma and the definition of closure, we have:

$$
\begin{align*}
x \in \overline{A}^c &\implies x \notin \overline{A} \\\\
&\implies \neg (\forall r > 0 \quad \text{s.t.} \quad
B_r(x) \cap A \ne \emptyset)
\\\\
&\implies \exists r > 0 \quad \text{s.t.} \quad
B_r(x) \cap A = \emptyset \\\\
&\implies \exists r > 0 \quad \text{s.t.} \quad
B_r(x) \cap \overline{A} = \emptyset
\\\\
&\implies \exists r > 0 \quad \text{s.t.} \quad
B_r(x) \subset \overline{A}^c.
\end{align*}
$$

Therefore, $\overline{A}^c$ is open and $\overline{A}$ is closed.

**Proof of Lemma.** Assume $B_r(\mathbf{x}) \cap A = \emptyset$ but $B_r(\mathbf{x}) \cap \overline{A} \ne \emptyset$. Then there exists $\mathbf{y} \in B_r(\mathbf{x}) \cap \overline{A}$. Then by definition of open ball $r' = r - \lVert x - y\rVert > 0$, and by definition of
closure $B_{r'}(\mathbf{y}) \cap A \ne \emptyset$. But $B_{r'}(\mathbf{y}) \subset B_{r}(\mathbf{x})$, which means
$B_{r}(\mathbf{x}) \cap A \ne \emptyset$.
A contradiction. So, such $\mathbf{y}$ doesn't exist and
$B_r(\mathbf{x}) \cap \overline{A} = \emptyset$.

**Second, we show that $\overline{A}$ is the smallest
closed set containing $A$**.

Assume that there's a smaller closed set $X$ such that $A \subset X$. Then there exists a $\mathbf{x} \in \overline{A}$ which
is not in $X$. Since $X$ is closed, then $X^c$ is open and:

$$
\begin{align*}
\mathbf{x} \in \overline{A} - X &\implies \mathbf{x} \in X^c \\\\
&\implies \exists r > 0 \quad \text{s.t.} \quad B_r(\mathbf{x}) \subset X^c
\\\\
&\implies \exists r > 0 \quad \text{s.t.} \quad B_r(\mathbf{x}) 
\cap A
\subset X^c \cap X \quad \text{(since } A \subset X \text{)}
\\\\
&\implies \exists r > 0 \quad \text{s.t.} \quad B_r(\mathbf{x}) \cap A = \emptyset
\\\\
&\implies \mathbf{x} \notin \overline{A}
\end{align*}
$$

Which is a contradiction. So, $\overline{A}$ is the smallest
closed set containing $A$.

**3.**
From problem 1.5.6 we have $\partial A = \overline{A} \cap \overline{A^c}$.

Then:

$$
\begin{align*}
A \cup \partial A &= A \cup (\overline{A} \cap \overline{A^c}) \\\\
&= (A \cup \overline{A}) \cap (A \cup \overline{A^c}) \\\\
&= \overline{A} \cap (A \cup \overline{A^c}) \quad &\text{(since } A \subset \overline{A} \text{)} \\\\
&= \overline{A} \cap \mathbb{R}^n &\text{(since } A^c \subset \overline{A^c} \text{ and } A \cup A^c = \mathbb{R}^n \text{)} \\\\
&= \overline{A}
\end{align*}
$$

**4.**

By definition,

$$
\mathbf{x} \in \overset{\circ}{A} \Leftrightarrow \exists r > 0 \\,
B_r(\mathbf{x}) \subset A
$$

Then:

$$
\mathbf{x} \in \left(\overset{\circ}{A}\right)^c \Leftrightarrow \forall r > 0 \\,
B_r(\mathbf{x}) \cap A^c \ne \emptyset
$$

And since definition of closure is:

$$
\mathbf{x} \in \overline{A} \Leftrightarrow \forall r > 0 \\, B_r(\mathbf{x}) \cap A \ne \emptyset
$$

Then

$$
\mathbf{x} \in \overline{A} \cap \left(\overset{\circ}{A}\right)^c \Leftrightarrow
\forall r > 0 \\, B_r(\mathbf{x}) \cap A \ne \emptyset
 \text{ and }
B_r(\mathbf{x}) \cap A^c \ne \emptyset
$$

Which means

$$
\mathbf{x} \in \overline{A} - \overset{\circ}{A} \Leftrightarrow
\mathbf{x} \in \partial{A}.
$$

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

**1.**
Since $\lVert A^k \rVert \le \lVert A \rVert^k$, then 
$\sum_{k=0}^{\infty} \left\lVert\dfrac{A^k}{k!}\right\rVert
\le \sum_{k=0}^{\infty} \dfrac{\lVert A\rVert^k}{k!}$, which
by proposition 1.5.36 converges to $e^{\lVert A \rVert}$.
Using proposition 1.5.35 (absolute convergence), we conclude $e^{A}$ itself converges.

To find a bound for $\lVert e^{A} \rVert$, we note that:

$$
\begin{align*}
\lVert e^A \rVert &=
\left\lVert\sum_{k=0}^{\infty} \frac{A^k}{k!}\right\rVert \\\\
&\le 
\sum_{k=0}^{\infty} \left\lVert\frac{A^k}{k!}\right\rVert \quad &\text{(exercise 1.5.9)}
\\\\
&\le \sum_{k=0}^{\infty} \frac{\lVert A\rVert^k}{k!} \quad &(\lVert A^k \rVert \le \lVert A \rVert^k)
\\\\
&= e^{\lVert A \rVert} \quad &\text{(proposition 1.5.36)}
\end{align*}
$$

Since norms are non-negative, then $0 \le \lVert e^A \rVert \le e^{\lVert A \rVert}$.

**2.**
**$e^{A+B} = e^{A}e^{B}$ is generally not true.** For example, let
$A = \begin{pmatrix} 0 & 1 \\\\ 0 & 0 \end{pmatrix}$ and
$B = \begin{pmatrix} 0 & 0 \\\\ 1 & 0 \end{pmatrix}$.
Then $A^2 = B^2 = \mathbf{0}$. So,
$e^A = I + A = \begin{pmatrix} 1 & 1 \\\\ 0 & 1\end{pmatrix}$ and
$e^B = I + B = \begin{pmatrix} 1 & 0 \\\\ 1 & 1 \end{pmatrix}$.

To calculate $e^{A+B}$, note that:

$$
(A + B)^k = 
\begin{pmatrix} 0 & 1 \\\\ 1 & 0\end{pmatrix}^k =
\begin{cases}
\begin{pmatrix} 0 & 1 \\\\ 1 & 0\end{pmatrix} \quad \text{when k odd} 
\\\\
\begin{pmatrix} 1 & 0 \\\\ 0 & 1\end{pmatrix} \quad \text{when k even} 
\end{cases}
$$

So, $(A + B)^k = \begin{pmatrix} \dfrac{1 + (-1)^k}{2} & \dfrac{1 - (-1)^k}{2} \\\\
\dfrac{1 - (-1)^k}{2} & \dfrac{1 + (-1)^k}{2} \end{pmatrix}$, and

$$
\begin{align*}
e^{A+B} &= \begin{pmatrix}
\dfrac{1}{2}\sum_{k=0}^{\infty} \left(\dfrac{1}{k!} + \dfrac{(-1)^k}{k!}\right) &
\dfrac{1}{2} \sum_{k=0}^{\infty} \left(\dfrac{1}{k!} - \dfrac{(-1)^k}{k!}\right) \\\\
\dfrac{1}{2} \sum_{k=0}^{\infty} \left(\dfrac{1}{k!} - \dfrac{(-1)^k}{k!}\right) &
\dfrac{1}{2}\sum_{k=0}^{\infty} \left(\dfrac{1}{k!} + \dfrac{(-1)^k}{k!}\right)
\end{pmatrix}
\\\\ &= \begin{pmatrix}
\dfrac{e+e^{-1}}{2} & \dfrac{e-e^{-1}}{2} \\\\
\dfrac{e-e^{-1}}{2} & \dfrac{e+e^{-1}}{2}
\end{pmatrix}
\end{align*}
$$

So, $e^{A+B} = \begin{pmatrix} \cosh{1} & \sinh{1} \\\\ \sinh{1} & \cosh{1}\end{pmatrix} \ne
\begin{pmatrix} 2 & 1 \\\\ 1 & 1 \end{pmatrix} =
 e^A e^B$.

------

**$e^{A+B} = e^{A}e^{B}$ holds when $AB = BA$**.

We have:

$$
\begin{align*}
e^{A+B} &= \sum\_{k=0}^{\infty} \frac{(A+B)^k}{k!}
\\\\
&= \sum\_{k=0}^{\infty} \sum\_{i=0}^{k} \frac{{k \choose i} A^iB^{k-i}}{k!} \quad \text{(\*)}
\\\\
&= \sum\_{k=0}^{\infty} \sum\_{i=0}^{k} \frac{A^i B^{k-i}}{i! (k - i)!}
\\\\
&= \sum\_{i=0}^{\infty} \sum\_{j=0}^{\infty} \frac{A^i B^j}{i! j!}
\\\\
&=
\left(\sum\_{i=0}^{\infty} \frac{A^i}{i!}\right)
\left(\sum\_{j=0}^{\infty} \frac{B^j}{j!}\right)
\\\\
&=
e^Ae^B
\end{align*}
$$

Where we used $AB=BA$ in step **(*)**.

---------

$e^{2A} = \left(e^A\right)^2$ holds for all $A$ as a
corollary of the previous result.
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
\forall \epsilon > 0 \exists \delta > 0\quad \text{s.t.} \quad \sqrt{x^2+y^2} < \delta \implies | f\begin{pmatrix} x \\\\ y \end{pmatrix} - a | < \epsilon
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

Let $r = \lVert (x, y) \rVert = \sqrt{x^2 + y^2}$ and
$s = \lvert x \rvert + \lvert y \rvert$. Then $g = 2s \ln r$.

Using triangle inequality, we have $r \le s$, and using cauchy-schwarz inequality (with $\mathbf{u}=(\frac{1}{\sqrt{2}},\frac{1}{\sqrt{2}})$, $\mathbf{v}=(|x|,|y|)$), we have $\dfrac{s}{\sqrt{2}} \le r$.

When $r < 1$, then $\ln r < 0$. So, near zero:

$$
\begin{align*}
\dfrac{s}{\sqrt{2}} \le r \le s &\implies
2 \sqrt{2} \\, r \ln r 
\le 2s \ln r \le
2r \ln r
\\\\
&\implies
2 \sqrt{2} \\, r \ln r 
\le g \begin{pmatrix} x \\\\ y \end{pmatrix} \le
2r \ln r
\end{align*}
$$

From one dimensional calculus we know $\lim_{r\to 0} r \ln r = 0$, which
means:

$$
\lim\_{\begin{pmatrix} x \\\\ y \end{pmatrix} \to \begin{pmatrix} 0^+ \\\\ 0^+ \end{pmatrix}} g \begin{pmatrix} x \\\\ y \end{pmatrix} = 0
$$

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

We have

$$
A^k = \begin{pmatrix}
\dfrac{(2a)^k}{2} & \dfrac{(2a)^k}{2} \\\\
\dfrac{(2a)^k}{2} & \dfrac{(2a)^k}{2}
\end{pmatrix}
$$

For $k \mapsto A^k$ to converge, $k \mapsto \dfrac{(2a)^k}{2}$ must converge. Then:

* If $|a| > \dfrac{1}{2}$, $A^k$ doesn't converge.
* If $|a| < \dfrac{1}{2}$, $A^k$ converges to $\mathbf{0}$.
* If $a = \dfrac{1}{2}$, $A^k$ converges to $\dfrac{1}{2}
\begin{pmatrix}1 & 1 \\\\ 1 & 1 \end{pmatrix}$.
* If $a = -\dfrac{1}{2}$, $A^k = (-1)^k \dfrac{1}{2}
\begin{pmatrix}1 & 1 \\\\ 1 & 1 \end{pmatrix}$ and doesn't converge.
::::

---------
