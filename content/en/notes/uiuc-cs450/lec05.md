# CS 450 - Lecture 5

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_tw0jek7s/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

Some notes and examples are from:

* Heath, M. T. (2018). Scientific computing: An introductory survey (Revised Second Edition). SIAM. https://doi.org/10.1137/1.9781611975581

#### LU Factorization

We want to transform a general matrix into product triangular matrices.

An **LU factorization** is decomposition $A = LU$, where:

- $L$ is a lower triangular matrix with ones on the diagonal.
- $U$ is an upper triangular matrix.

Unit-diagonal $L$ implies each $L_{ii} = 1$, leaving $\dfrac{n(n-1)}{2}$
unknowns in $L$ and $\dfrac{n(n+1)}{2}$ unknowns in $U$. So, we have
$n^2$ unknowns in total, matching the number of entries in $A$.

:::card[example]
**Example (LU Factorization).**

:::math
A =
mat(2, 3, 1; 6, 13, 5; 2, 19, 10)
\=
mat(1, 0, 0; 3, 1, 0; 1, 4, 1)
dot
mat(2, 3, 1; 0, 4, 2; 0, 0, 1)
:::
::::

For a rectangular matrix $A \in bb{R}^{m cross n}$, we can consider a
**full** LU factorization with $L \in bb{R}^{m cross \max(m, n)}$ and
$U \in bb{R}^{\max(m, n) cross n}$:

:::math
\underbrace{mat(3, 5; 6, 12; -3, 1; 0, 8)}_{A\in bb{R}^{4cross 2}}
\;=\;
\underbrace{mat(1, 0, 0, 0; 2, 1, 0, 0; -1, 3, 1, 0; 0, 4, 0, 1)}_{L_{\text{full}}\in bb{R}^{4cross 4}}
\;
\underbrace{mat(3, 5; 0, 2; 0, 0; 0, 0)}_{U_{\text{full}}\in bb{R}^{4cross 2}}.
:::

But it is fully described by a **reduced** LU factorization with lower-trapezoidal $L \in bb{R}^{m cross \min(m, n)}$ and
upper-trapezoidal $U \in bb{R}^{\min(m, n) cross n}$:

:::math
\underbrace{mat(3, 5; 6, 12; -3, 1; 0, 8)}_{A\in bb{R}^{4cross 2}}
\;=\;
\underbrace{mat(1, 0; 2, 1; -1, 3; 0, 4)}_{L\in bb{R}^{4cross 2}}
\;
\underbrace{mat(3, 5; 0, 2)}_{U\in bb{R}^{2cross 2}}.
:::

##### Solving Linear Systems with LU Factorization
Given an LU factorization $A = LU$, we can solve the linear system $Ax = b$ in two steps:

1. Solve $Ly = b$ for $y$ using forward substitution.
2. Solve $Ux = y$ for $x$ using backward substitution.

Computational complexity of this algorithm is $O(n^2)$.

#### Elementary Elimination Matrices

:::math
M_k a = mat(1, ..., 0, 0, ..., 0; \vdots, \ddots, \vdots, \vdots, \ddots, \vdots; 0, ..., 1, 0, ..., 0; 0, ..., -m_{k+1}, 1, ..., 0; \vdots, \ddots, \vdots, \vdots, \ddots, \vdots; 0, ..., -m_{n}, 0, ..., 1)
mat(a_1; \vdots; a_k; a_{k+1}; \vdots; a_n)
\=
mat(a_1; \vdots; a_k; 0; \vdots; 0)
:::

where $m_i = \dfrac{a_i}{a_k}$ for $i = k+1, ..., n$.

The divisor $a_k$ is the **pivot**.

This is called an **elementary elimination matrix** or **Gaussian transformation**.

Note the following properties:
- $M_k$ is lower triangular with unit main diagonal, hence it is non-singular.
- $M_k = I - v{m}_k v{e}_k^T$, where $v{m}_k = (0, ..., 0, m_{k+1}, ..., m_n)^T$ and $v{e}_k$ is the $k$-th column of the identity matrix.
- $M_k^{-1} = I + v{m}_k v{e}_k^T$.
- If $M_j$, $j > k$, is another elementary elimination matrix, then

:::math
M_k M_j = I - v{m}_k v{e}_k^T - v{m}_j v{e}_j^T + v{m}_k v{e}_k^T v{m}_j v{e}_j^T = I - v{m}_k v{e}_k^T - v{m}_j v{e}_j^T
:::

This is because $v{e}_k^T v{m}_j = 0$. Thus their product is essentially their union.

#### Gaussian Elimination
Using elementary elimination matrices, it's easy to transform a matrix into an upper triangular form.

Let $M = M_{n-1} ... M_1$ be the product of elementary elimination matrices. Then $M A = U$, where $U$ is upper triangular. As discussed above, $M$ and $M^{-1}$ are lower triangular with ones on the diagonal.

We also saw how to iteratively compute $M^{-1}$.

We can write the LU factorization as:

:::math
A = M^{-1} U = L U
:::

#### The Recursive Algorithm

Consider the block matrix form:

:::math
mat(a_{11}, v{a}_{12}; v{a}_{21}, v{A}_{22})
\=
mat(1, 0; v{l}_{21}, v{L}_{22})
dot
mat(u_{11}, v{u}_{12}; 0, v{U}_{22})
:::

Where bold-face entries are submatrices: $v{a}_{12} \in bb{R}^{1 cross n-1}$, $v{a}_{21} \in bb{R}^{n-1 cross 1}$, $v{A}_{22} \in bb{R}^{(n-1) cross (n-1)}$, etc.

Then:

- $mat(u_{11}, v{u}_{12}) = mat(a_{11}, v{a}_{12})$.
- $v{l}_{21} = \dfrac{v{a}_{21}}{u_{11}}$.
- Obtain $v{L}_{22}$ and $v{U}_{22}$ recursively computing the LU factorization of the **Schur complement**:

:::math
S = v{A}_{22} - v{l}_{21} dot v{u}_{12}
:::

The computational complexity of this algorithm is $O(n^3)$.

#### Existence of LU Factorization

If all leading principal minors of $A$ are non-zero, then $A$ has an LU factorization.

> [!NOTE]
> Converse is not true: having an LU factorization does not imply that all leading principal minors are non-zero.
>
> For example,
> $$
> \begin{bmatrix}
> 1 & 0 \\
> 0 & 0
> \end{bmatrix}
> \=
> \begin{bmatrix}
> 1 & 0 \\
> 0 & 1
> \end{bmatrix}
> \cdot
> \begin{bmatrix}
> 1 & 0 \\
> 0 & 0
> \end{bmatrix}
> $$
>
> However, if $A \in bb{R}^{ncross n}$ is **invertible**, then it
> admits an LU factorization **if and only if** all leading principal
> minors of $A$ are non-zero.

We can't necessarily factor a matrix into $LU$, because it may entail
division by zero. As an example, the following matrix does not have an
LU factorization:

:::math
mat(3, 2; 6, 4; 0, 3)
:::

Proceeding with Gauss elimination, we obtain:

:::math
mat(3, 2; 6, 4; 0, 3)
\=
mat(1, 0; 2, 1; 0, l_{32})
dot
mat(3, 2; 0, u_{21})
:::

Then we need that $4 = 4 + u_{21}$, so $u_{21} = 0$. But at the
same time $l_{32} u_{21} = 3$.

Also, if Gaussian elimination can be performed to produce an upper triangular matrix without any row swaps, then the matrix has an LU factorization.

> [!NOTE]
> The potential need for pivoting has nothing to do with
> singularity. For example, the matrix
>
> $$
> \begin{bmatrix}
> 0 & 1 \\
> 1 & 0 \\
> \end{bmatrix}
> $$
>
> is non-singular, but it does not have an LU factorization
> without row swaps.

#### $PA = LU$ Factorization

**Permutation of rows** enables us to transform the matrix so that it has an LU factorization.

So, what we are going to do in general is to compute a factorization of the form $PA = LU$, where $P$ is a permutation matrix.

Then the system $Ax = b$ becomes $PAx = Pb$, and we can solve it using the LU factorization of $PA$.

There are many ways to choose the permutation matrix $P$. The most common one is **partial pivoting**: at each step, we choose the largest absolute value in the column as the pivot.

A row permutation corresponds to an application of a **row permutation matrix**:

:::math
P_{jk} = I - (e_j - e_k)(e_j - e_k)^T
:::

#### Gaussian Elimination with Partial Pivoting

**Partial pivoting** permutes rows to make the absolute value of
the divisor $u_{ii}$ maximal at each step.

This selection ensures that:
- We are never forced to divide by zero during Gaussian elimination.
- The magnitude of the entries in $L$ is at most 1.

