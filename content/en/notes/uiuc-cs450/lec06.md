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

In **partial pivoting**, at each step we pick the largest 
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

For all $1 \leq k \leq n - 1$.

**Example.** Consider the matrix:

$$
A = \begin{bmatrix}
3 & 2 \\
6 & 4 \\
0 & 3
\end{bmatrix}
$$

Here, $\text{rank}(A[1:2, 1:2]) = 1$ and $\text{rank}(A[1:3, 1:2]) = 2$.
So, an LU factorization does not exist. So, we'll need to use partial pivoting.

Then:

$$
\underbrace{\begin{bmatrix}
0 & 1 & 0 \\
1 & 0 & 0 \\
0 & 0 & 1
\end{bmatrix}}\_{P_1}
\;
\underbrace{\begin{bmatrix}
3 & 2 \\
6 & 4 \\
0 & 3
\end{bmatrix}}_{A}
= \begin{bmatrix}
1 \\
1/2 \\
0
\end{bmatrix}
\;
\begin{bmatrix}
6 & 4
\end{bmatrix}
+
\begin{bmatrix}
0 & 0 \\
0 & 2 - (1/2) \cdot 4 \\
0 & 3 - 0 \cdot 4
\end{bmatrix}
$$

The Schur complement is $\begin{bmatrix}0 & 3\end{bmatrix}^T$, and
we proceed with pivoted LU:

$$
\underbrace{\begin{bmatrix}
0 & 1\\
1 & 0
\end{bmatrix}}\_{P_2}
\begin{bmatrix}
0 \\
3
\end{bmatrix}
\=
\begin{bmatrix}
1 \\
0
\end{bmatrix}
\begin{bmatrix}3\end{bmatrix}
$$

Then the overall factorization is given by:

$$
\begin{bmatrix}1 & \\ & P_2\end{bmatrix}
\;
P_1
\;
A
\= \begin{bmatrix}
1 &  \\
0 & 1 \\
1/2 & 0
\end{bmatrix}
\cdot
\begin{bmatrix}
6 & 4 \\
  & 3
\end{bmatrix}
$$

#### Complete Pivoting

**Complete pivoting** permutes both rows and columns to make absolute value
of the pivot element as large as possible at each step.

Complete pivoting is noticeably more expensive than partial pivoting.

#### Round-off Error in LU

Consider the following matrix where $\epsilon < \epsilon_{\text{mach}}$:

$$
A = \begin{bmatrix}
\epsilon & 1 \\
1 & 1
\end{bmatrix}
$$

**Without pivoting.**

* We have $L = \begin{bmatrix}
1 & 0 \\\\
1/\epsilon & 1
\end{bmatrix}$ and $U = \begin{bmatrix}
\epsilon & 1 \\\\
0 & 1 - 1/\epsilon
\end{bmatrix}$.
* Rounding yields $fl(U) = \begin{bmatrix}
\epsilon & 1 \\\\
0 & -1/\epsilon
\end{bmatrix}$.
* This leads to $L \\; fl(U) = \begin{bmatrix}
\epsilon & 1 \\\\
1 & 0
\end{bmatrix}$, a backward error of $\begin{bmatrix}0 & 0 \\\\
0 & -1\end{bmatrix}$.


**With partial pivoting.**
* Partial pivoting gives $PA = \begin{bmatrix}1 & 1 \\\\
\epsilon & 1\end{bmatrix}$.
* We have $L = \begin{bmatrix}
1 & 0 \\\\
\epsilon & 1
\end{bmatrix}$ and $U = \begin{bmatrix}
1 & 1 \\\\
0 & 1 - \epsilon
\end{bmatrix}$.
* Rounding yields $fl(U) = \begin{bmatrix}
1 & 1 \\\\
0 & 1
\end{bmatrix}$.
* This leads to $L \\; fl(U) = \begin{bmatrix}
1 & 1 \\\\
\epsilon & 1 + \epsilon
\end{bmatrix}$, a backward error of $\begin{bmatrix}0 & 0 \\\\
0 & \epsilon\end{bmatrix}$.

#### Error Analysis of LU Factorization

When computing in floating-point, absolute backward error $\delta A$ in LU,
so that $\hat L \hat U = A + \delta A$, is:

$$
\lvert \delta a_{ij} \rvert \leq \epsilon_{\text{mach}} (\lvert \hat L \rvert \cdot \lvert \hat U \rvert)_{ij}
$$

#### Helpful Matrix Properties

**Strictly Diagonally Dominant Matrix.** Pivoting is not required if the matrix is strictly diagonally dominant, meaning:

$$
\lvert a_{ii} \rvert > \sum_{j \neq i} \lvert a_{ij} \rvert
$$

That is, the absolute value of each diagonal entry is greater than the sum of the absolute values of the other entries in that **row**.

**Symmetric Positive Definite Matrix.** If $A^T = A$ and for all $x \neq 0$ we have $x^T A x > 0$ (or equivalently, all eigenvalues are positive), then $L = U^T$ and pivoting is not required. **Cholesky** algorithm $A = LL^T$ can be used. Note that in Cholesky, $L$ is not necessarily unit-diagonal.

:::card[example]
**Example.** Consider the matrix:

$$
A = \begin{bmatrix}
4 & 12 & -16 \\
12 & 37 & -43 \\
-16 & -43 & 98
\end{bmatrix}
$$

Here $A^T = A$ and all principal minors are positive, so it is symmetric positive definite.
Thus, we can use Cholesky factor:

$$
L = \begin{bmatrix}
2 & 0 & 0 \\
6 & 1 & 0 \\
-8 & 5 & 3
\end{bmatrix}
$$

One can verify that $A = LL^T$.
::::

**Symmetric Indefinite Matrix.** If $A^T = A$  and $\lambda(A) < 0$, then
we can use pivoted **LDL factorization** $P A P^T = L D L^T$, where $L$ is lower triangular and unit-diagonal, and $D$ is block diagonal with 2x2 diagonal or antidiagonal blocks.

**Banded Matrix.** If we have non-zero entries only on the main diagonal and $b$ diagonals above and below it, i.e $a_{ij} = 0$ for $|i - j| > b$, then
LU without pivoting and Cholesky preserve the band structure and require $O(n b^2)$ operations.

#### Solving Perturbed Systems with Rank-1 Updates

Suppose we have computed $A = LU$ and now want to solve a perturbed system
$(A - uv^T)x = b$. That is, we want to find $x = (A - uv^T)^{-1} b$.

From the **Sherman-Morrison-Woodbury** formula we have:

$$
(A - uv^T)^{-1} = A^{-1} + \frac{A^{-1} u v^T A^{-1}}{1 + v^T A^{-1} u}
$$

Then:

$$
x = (A - uv^T)^{-1} \; b = A^{-1} b + \frac{(A^{-1} u) \; v^T \; (A^{-1} b)}{1 + v^T \; (A^{-1} u)}
$$

To compute this:
- Solve $Az = u$ to find $z = A^{-1} u$ using the LU factorization of $A$. Similarly, solve $Ay = b$ to find $y = A^{-1} b$ (cost: $O(n^2)$),
- Then evaluate $x = y + \dfrac{z (v^T y)}{1 + v^T z}$ (cost: $O(n)$).

Thus, the full solution requires only $O(n^2)$ time.

