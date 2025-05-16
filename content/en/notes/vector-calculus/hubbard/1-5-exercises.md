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
for each $i \in \mathbb{N}$. Define $B = \cap_{i=0}^{\infty} A_i$. Then $B = \\{0\\}$ which is not open.

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

::::

---------

