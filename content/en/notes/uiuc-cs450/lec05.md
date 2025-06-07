# CS 450 - Lecture 5

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_tw0jek7s/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

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

$$
A =
\begin{bmatrix}
2 & 3 & 1 \\\\
6 & 13 & 5 \\\\
2 & 19 & 10
\end{bmatrix}
\=
\begin{bmatrix}
1 & 0 & 0 \\\\
3 & 1 & 0 \\\\
1 & 4 & 1
\end{bmatrix}
\cdot
\begin{bmatrix}
2 & 3 & 1 \\\\
0 & 4 & 2 \\\\
0 & 0 & 1
\end{bmatrix}
$$
::::

For a rectangular matrix $A \in \mathbb{R}^{m \times n}$, we can consider a
**full** LU factorization with $L \in \mathbb{R}^{m \times \max(m, n)}$ and
$U \in \mathbb{R}^{\max(m, n) \times n}$:

$$
\underbrace{\begin{bmatrix}
 3 & 5\\\\
 6 & 12\\\\
-3 & 1\\\\
 0 & 8
\end{bmatrix}}\_{A\in\mathbb{R}^{4\times 2}}
\\;=\\;
\underbrace{\begin{bmatrix}
 1 & 0 & 0 & 0\\\\
 2 & 1 & 0 & 0\\\\
-1 & 3 & 1 & 0\\\\
 0 & 4 & 0 & 1
\end{bmatrix}}\_{L_{\text{full}}\in\mathbb{R}^{4\times 4}}
\\;
\underbrace{\begin{bmatrix}
 3 & 5\\\\
 0 & 2\\\\
 0 & 0\\\\
 0 & 0
\end{bmatrix}}\_{U_{\text{full}}\in\mathbb{R}^{4\times 2}}.
$$

But it is fully described by a **reduced** LU factorization with lower-trapezoidal $L \in \mathbb{R}^{m \times \min(m, n)}$ and 
upper-trapezoidal $U \in \mathbb{R}^{\min(m, n) \times n}$:

$$
\underbrace{\begin{bmatrix}
 3 & 5\\\\
 6 & 12\\\\
-3 & 1\\\\
 0 & 8
\end{bmatrix}}\_{A\in\mathbb{R}^{4\times 2}}
\\;=\\;
\underbrace{\begin{bmatrix}
 1 & 0\\\\
 2 & 1\\\\
-1 & 3\\\\
 0 & 4
\end{bmatrix}}\_{L\in\mathbb{R}^{4\times 2}}
\\;
\underbrace{\begin{bmatrix}
 3 & 5\\\\
 0 & 2
\end{bmatrix}}\_{U\in\mathbb{R}^{2\times 2}}.
$$

##### Solving Linear Systems with LU Factorization
Given an LU factorization $A = LU$, we can solve the linear system $Ax = b$ in two steps:

1. Solve $Ly = b$ for $y$ using forward substitution.
2. Solve $Ux = y$ for $x$ using backward substitution.

Computational complexity of this algorithm is $O(n^2)$.

#### The Recursive Algorithm

Consider the block matrix form:

$$
\begin{bmatrix}
 a_{11} & \mathbf{a}\_{12} \\\\
    \mathbf{a}\_{21} & \mathbf{A}\_{22}
\end{bmatrix}
\=
\begin{bmatrix}
    1 & 0 \\\\
    \mathbf{l}\_{21} & \mathbf{L}\_{22}
\end{bmatrix}
\cdot
\begin{bmatrix}
 u_{11} & \mathbf{u}\_{12} \\\\
    0 & \mathbf{U}\_{22}
\end{bmatrix}
$$

Where bold-face entries are submatrices: $\mathbf{a}\_{12} \in \mathbb{R}^{1 \times n-1}$, $\mathbf{a}\_{21} \in \mathbb{R}^{n-1 \times 1}$, $\mathbf{A}\_{22} \in \mathbb{R}^{(n-1) \times (n-1)}$, etc.

Then:

- $\begin{bmatrix} u_{11} & \mathbf{u}\_{12} \end{bmatrix} = \begin{bmatrix} a_{11} & \mathbf{a}\_{12} \end{bmatrix}$.
- $\mathbf{l}\_{21} = \dfrac{\mathbf{a}\_{21}}{u_{11}}$.
- Obtain $\mathbf{L}\_{22}$ and $\mathbf{U}\_{22}$ recursively computing the LU factorization of the **Schur complement**:

$$
S = \mathbf{A}\_{22} - \mathbf{l}\_{21} \cdot \mathbf{u}\_{12}
$$

The computational complexity of this algorithm is $O(n^3)$.

#### Existence of LU Factorization

If all leading principal minors of $A$ are non-zero, then $A$ has an LU factorization.

> [!NOTE]
> Converse is not true: having an LU factorization does not imply that all leading principal minors are non-zero.
>
> For example,
> $$
> \begin{bmatrix}
> 1 & 0 \\\\
> 0 & 0
> \end{bmatrix}
> \=
> \begin{bmatrix}
> 1 & 0 \\\\
> 0 & 1
> \end{bmatrix}
> \cdot
> \begin{bmatrix}
> 1 & 0 \\\\
> 0 & 0
> \end{bmatrix}
> $$
>
> However, if $A \in \mathbb{R}^{n\times n}$ is **invertible**, then it 
> admits an LU factorization **if and only if** all leading principal
> minors of $A$ are non-zero.


As an example, the following matrix does not have an LU factorization:

$$
\begin{bmatrix}
3 & 2 \\\\
6 & 4 \\\\
0 & 3
\end{bmatrix}
$$

Proceeding with Gauss elimination, we obtain:

$$
\begin{bmatrix}
3 & 2 \\\\
6 & 4 \\\\
0 & 3
\end{bmatrix}
\=
\begin{bmatrix}
1 & 0 \\\\
2 & 1 \\\\
0 & l_{32}
\end{bmatrix}
\cdot
\begin{bmatrix}
3 & 2 \\\\
0 & u_{21}
\end{bmatrix}
$$

Then we need that $4 = 4 + u_{21}$, so $u_{21} = 0$. But at the
same time $l_{32} u_{21} = 3$.

Also, if Gaussian elimination can be performed to produce an upper triangular matrix without any row swaps, then the matrix has an LU factorization.

#### $PA = LU$ Factorization

**Permutation of rows** enables us to transform the matrix so that it has an LU factorization.

So, what we are going to do in general is to compute a factorization of the form $PA = LU$, where $P$ is a permutation matrix.

Then the system $Ax = b$ becomes $PAx = Pb$, and we can solve it using the LU factorization of $PA$.

There are many ways to choose the permutation matrix $P$. The most common one is **partial pivoting**: at each step, we choose the largest absolute value in the column as the pivot.

#### Gaussian Elimination with Partial Pivoting

**Partial pivoting** permutes rows to make the absolute value of
the divisor $u_{ii}$ maximal at each step.

This selection ensures that:
- We are never forced to divide by zero during Gaussian elimination.
- The magnitude of the entries in $L$ is at most 1.

