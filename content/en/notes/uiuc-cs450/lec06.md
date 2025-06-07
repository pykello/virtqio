# CS 450 - Lecture 6

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_qt6mvjzy/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

#### Review (Partial Pivoting)

Not all matrices have LU factorizations, because the elimination process can entail division by zero.

However, for all matrices, we can find a $PA = LU$ factorization, where $P$ is a permutation matrix.

$L$ is lower triangular with ones on the diagonal, and $U$ is upper triangular.

$U$ might have zeros in the diagonal. We have:

$$
\text{rank}(A) = \text{rank}(LU) = \text{rank}(U)
$$

In **partial pivoting**, at each step we peak the largest 
absolute value in the column. $P$ is product of $n-1$
row permutation matrices:

$$
P_{jk} = I - (e_j - e_k)(e_j - e_k)^T
$$

#### Partial Pivoting Example

**Theorem.** The LU factorization exists if and only if:

$$
\text{rank}(A[1:k, 1:k]) = \text{rank}(A[1:n, 1:k])
$$

**Example.** For all $1 \leq k \leq n - 1$.

Consider the matrix:

$$
A = \begin{bmatrix}
3 & 2 \\\\
6 & 4 \\\\
0 & 3
\end{bmatrix}
$$

Here, $\text{rank}(A[1:2, 1:2]) = 1$ and $\text{rank}(A[1:3, 1:2]) = 2$.
So, an LU factorization does not exist. So, we'll need to use partial pivoting.

Then:

$$
\underbrace{\begin{bmatrix}
0 & 1 & 0 \\\\
1 & 0 & 0 \\\\
0 & 0 & 1
\end{bmatrix}}\_{P_1}
\\;
\underbrace{\begin{bmatrix}
3 & 2 \\\\
6 & 4 \\\\
0 & 3
\end{bmatrix}}_{A}
= \begin{bmatrix}
1 \\\\
1/2 \\\\
0
\end{bmatrix}
\\;
\begin{bmatrix}
6 & 4
\end{bmatrix}
+
\begin{bmatrix}
0 & 0 \\\\
0 & 2 - (1/2) \cdot 4 \\\\
0 & 3 - 0 \cdot 4
\end{bmatrix}
$$

The Schur complement is $\begin{bmatrix}0 & 3\end{bmatrix}^T$, and
we proceed with pivoted LU:

$$
\underbrace{\begin{bmatrix}
0 & 1\\\\
1 & 0
\end{bmatrix}}\_{P_2}
\begin{bmatrix}
0 \\\\
3
\end{bmatrix}
\=
\begin{bmatrix}
1 \\\\
0
\end{bmatrix}
\begin{bmatrix}3\end{bmatrix}
$$

Then the overall factorization is given by:

$$
\begin{bmatrix}1 & \\\\ & P_2\end{bmatrix}
\\;
P_1
\\;
A
\= \begin{bmatrix}
1 &  \\\\
0 & 1 \\\\
1/2 & 0
\end{bmatrix}
\cdot
\begin{bmatrix}
6 & 4 \\\\
  & 3
\end{bmatrix}
$$

#### Complete Pivoting

**Complete pivoting** permutes both rows and columns to make divisor $u_{ii}$
maximal at each step.

Complete pivoting is noticeably more expensive than partial pivoting.

#### Round-off Error in LU
