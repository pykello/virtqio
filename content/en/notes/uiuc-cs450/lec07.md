# CS 450 - Lecture 7

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_06ikz8ir/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/03-lecture.pdf)

## Linear Least Squares

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

## Data Fitting using Least Squares

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

