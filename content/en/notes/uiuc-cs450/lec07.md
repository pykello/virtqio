# CS 450 - Lecture 7

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_06ikz8ir/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/03-lecture.pdf)

#### Linear Least Squares

We have more equations than unknowns, and we want to find a solution
that minimizes $\lVert Ax - b \rVert\_2$. That is, we want to find

$$
x^* = \arg\min_{x \in \mathbb{R}^n} \lVert Ax - b \rVert\_2
$$

where $A \in \mathbb{R}^{m \times n}$ and $b \in \mathbb{R}^m$.

We usually write this as $Ax \cong b$, meaning $x$ is the vector that
minimizes the 2-norm of the **residual** $Ax - b$.

For an optimal solution $x^\*$, we have $r \perp \text{span}(A)$ where
$r = Ax^\* - b$. Residual can only be $0$ if $b \in \text{span}(A)$.

Given the SVD of $A = U \Sigma V^T$, and since $U^T$ is orthogonal (hence, an isometry), we can write:

$$
\begin{align*}
\lVert Ax - b \rVert\_2 &= 
\lVert U^T (Ax - b) \rVert\_2 \\\\[1em]
&= \lVert \Sigma V^T x - U^T b \rVert\_2
\end{align*}
$$

Letting $y = V^T x$ and $d = U^T b$, then we need to find $y^*$ such that
$\lVert \Sigma y - d \rVert\_2$ is minimized.

The minimizer of this reduced problem is given by:

- $y^*_i = \dfrac{d_i}{\sigma_i}$ for $i \in \\{1, \ldots, r\\}$
- $y^*_i = 0$ for $i > r$

where $r = \text{rank}(A)$.

Remember that inverse of a non-singular matrix $A$ is given by $A^{-1} = V \Sigma^{-1} U^T$. Similarly, the **pseudoinverse** is given by $A^\dagger = V \Sigma^\dagger U^T$, where $\Sigma^\dagger$ is the diagonal matrix with the reciprocals of the non-zero singular values of $A$ on the diagonal, and zeros elsewhere:

$$
\Sigma^\dagger = \text{diag}\left(\dfrac{1}{\sigma_1}, \ldots, \dfrac{1}{\sigma_r}, 0, \ldots, 0\right)
$$

Then, $y^* = \Sigma^\dagger d$, and we can recover $x^*$ as:

$$
x^* = A^\dagger b
$$

#### Data Fitting using Least Squares

Given a set of points $(x_i, y_i)$, we want to find a $n-1$ degree polynomial $p(x)$ that minimizes the residuals:

$$
\sum_{i=1}^m (y_i - p(x_i))^2
$$

The polynomial can be expressed as:

$$
p(x) = a_0 + a_1 x + \ldots + a_{n-1} x^{n-1}
$$

We can write this as a linear system:

$$
\begin{bmatrix}
1 & x_1 & x_1^2 & \ldots & x_1^{n-1} \\\\
1 & x_2 & x_2^2 & \ldots & x_2^{n-1} \\\\
\vdots & \vdots & \vdots & \ddots & \vdots \\\\
1 & x_m & x_m^2 & \ldots & x_m^{n-1}
\end{bmatrix}
\begin{bmatrix}
a_0 \\\\
a_1 \\\\
\vdots \\\\
a_{n-1}
\end{bmatrix}
\=
\begin{bmatrix}
y_1 \\\\
y_2 \\\\
\vdots \\\\
y_m
\end{bmatrix}
$$

Then we can use the least squares method to find the coefficients $a_i$.

#### Conditioning of Linear Least Squares

Consider a perturbation $\delta b$ to the right-hand side $b$:

$$
A(x + \delta x) \cong b + \delta b
$$

The amplification depends on how much of $b$ is in the span of $A$.

$$
\frac{\lVert \delta x \rVert\_2}{\lVert x \rVert\_2} \leq \kappa(A) \frac{\lVert b \rVert\_2}{\lVert Ax \rVert\_2} \frac{\lVert \delta b \rVert\_2}{\lVert b \rVert\_2}
$$

#### Normal Equations

To solve the least squares problem, we can use the **normal equations**:

$$
A^T A x = A^T b
$$

Using the SVD of $A = U \Sigma V^T$, we have:

$$
\begin{align*}
(U \Sigma V^T)^T U \Sigma V^T x &= (U \Sigma V^T)^T b \\\\
\Sigma^T \Sigma V^T x &= \Sigma^T U^T b \\\\
V^T x &= (\Sigma^T \Sigma)^{-1} \Sigma^T U^T b = \Sigma^\dagger U^T b \\\\
x &= V \Sigma^\dagger U^T b = x^\star
\end{align*}
$$

However, this method is more ill-conditioned problem than the original least squares problem. Generally, we have $\kappa(A^T A) = \kappa(A)^2$.
This is easily seen by noting that singular values of $A^T A$ are squares of the singular values of $A$.

#### Solving Normal Equations

If $A$ is full column rank ($\text{rank}(A) = n$), then $A^T A$ is symmetric positive definite (SPD):

- **Symmetric.** $(A^T A)^T = A^T A$.
- **Positive Definite.**
  - Since $A^T A = V \Sigma^2 V^T$, we have $\lambda\_i(A^T A) = \sigma\_i(A)^2 > 0$,
  - or equivalently, $x^T A^T A x = \lVert Ax \rVert\_2^2 > 0$ for all $x \neq 0$.

Since $A^T A$ is SPD, we can use Cholesky factorization to solve the normal equation $A^T A x = A^T b$.

#### QR Factorization

**QR factorization** provides a more stable way to solve the least squares problem.

Given a matrix $A \in \mathbb{R}^{m \times n}$ where $m \geq n$ and $\text{rank}(A) = n$, we can factor it as $A = QR$, where:

- $Q \in \mathbb{R}^{m \times m}$ is an orthogonal matrix (i.e., $Q^T Q = I_m$),
- $R \in \mathbb{R}^{m \times n}$ is an upper trapezoidal matrix.
  For $m > n$, first $n$ rows of $R$ are upper triangular with
  positive diagonal, and the remaining rows are zero.

A **reduced QR factorization** is defined as $A = \hat{Q} \hat{R}$, where:
- $\hat{Q} \in \mathbb{R}^{m \times n}$ has orthonormal columns,
- $\hat{R} \in \mathbb{R}^{n \times n}$ is upper triangular.

To solve the least squares problem $Ax \cong b$, we can:

1. Compute the reduced QR factorization $A = \hat{Q} \hat{R}$.
2. Multiply both sides by $\hat{Q}^T$ to get $\hat{R} x = \hat{Q}^T b$.
3. Solve the upper triangular system $\hat{R} x = \hat{Q}^T b$ using backward substitution.

This method is more stable than the normal equations, since multiplying
by an orthogonal matrix doesn't grow the error.

