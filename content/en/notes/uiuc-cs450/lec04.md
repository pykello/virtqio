# CS 450 - Lecture 4

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_w7fpz9ns/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

Some notes and examples are from:

* Heath, M. T. (2018). Scientific computing: An introductory survey (Revised Second Edition). SIAM. https://doi.org/10.1137/1.9781611975581

#### Existence of SVD

Consider the decomposition:

$$
\begin{pmatrix}
\\
u_1 & \cdots & u_n \\
\\
\end{pmatrix}
\begin{pmatrix}
\sigma_1 & & \\
& \ddots & \\
& & \sigma_n \\
\end{pmatrix}
\begin{pmatrix}
\\
v_1 & \cdots & v_n \\
\\
\end{pmatrix}^T
= \sum_{i=1}^n \sigma_i u_i v_i^T
$$

We want to find $x_1$ such that $\lVert x_1 \rVert\_2 = 1$ and maximizes $\lVert Ax \rVert\_2$. Then $x_1$ is the first right singular vector $v_1$. We can show that $Av_1 = \sigma_1 u_1$, and therefore $u_1 = \dfrac{Av_1}{\lVert Av_1 \rVert\_2} = \dfrac{Av_1}{\sigma_1}$.

Similarly, $v_2$ is the vector that maximizes $\lVert (A - \sigma_1 u_1 v_1^T)x \rVert\_2$ subject to $\lVert x \rVert\_2 = 1$, and so on.

#### Conditioning of Linear Systems

We saw previously that $\kappa(A) = \lVert A \rVert\_2 \lVert A^{-1} \rVert\_2$ controls
the maximum relative perturbation of $Ax$.

We can also show $\kappa(A)$ describes the conditioning of the linear system $Ax = b$.
That is, if we perturb $b$ by $\delta b$, what's the maximum relative perturbation $\delta x$ in the solution $x$?

If $A(x + \delta x) = b + \delta b$, then how $\dfrac{\lVert \delta b \rVert\_2}{\lVert b \rVert\_2}$ relates to $\dfrac{\lVert \delta x \rVert\_2}{\lVert x \rVert\_2}$?

(In the following, we will use $\lVert \cdot \rVert$ to denote the 2-norm.)

By linearity, we can write:

$$
\begin{align*}
\delta b = A \delta x &\implies
\delta x = A^{-1} \delta b
\\[1em]
&\implies
\lVert \delta x \rVert \le \lVert A^{-1} \rVert \lVert \delta b \rVert
\\[1em]
&\implies
\dfrac{\lVert \delta x \rVert}{\lVert x \rVert} \le \dfrac{\lVert A^{-1} \rVert \cdot \lVert \delta b \rVert}{\lVert x \rVert}
\tag{1}
\end{align*}
$$

Since $x$ is in the denominator, we are interested in lower bounding it. Since $Ax = b$, we have:

$$
\lVert x \rVert \ge \frac{\lVert b \rVert}{\lVert A \rVert} \tag{2}
$$

Then putting (2) and (1) together, we get:

$$
\dfrac{\lVert \delta x \rVert}{\lVert x \rVert} \le \lVert A \rVert \cdot \lVert A^{-1} \rVert \cdot \dfrac{\lVert \delta b \rVert}{\lVert b \rVert}
$$

So, we have:

$$
\dfrac{\lVert \delta x \rVert}{\lVert x \rVert}
    \le \kappa(A) \dfrac{\lVert \delta b \rVert}{\lVert b \rVert}
$$

---------

Now, consider perturbations to the input coefficients $\hat A = A + \delta A$. 

We want to solve $Ax = b$ and want to know how much the solution changes if we perturb the coefficients: $(A + \delta A)(x + \delta x) = b$. That is, we want to understand the relationship between $\dfrac{\lVert \delta A \rVert}{\lVert A \rVert}$ and $\dfrac{\lVert \delta x \rVert}{\lVert x \rVert}$.

Since $Ax = b$, then:

$$
\delta A \, x + A \, \delta x + \delta A \, \delta x = 0
$$

Since $\delta A \\, \delta x$ is small, we can ignore it. Then we have:

$$
\delta A \, x \approx -A \, \delta x
$$

Then:

$$
\lVert \delta x \rVert \le \lVert A^{-1} \rVert \lVert \delta A \rVert \lVert x \rVert
$$

Which means:

$$
\dfrac{\lVert \delta x \rVert}{\lVert x \rVert} \le \lVert A^{-1} \rVert \lVert \delta A \rVert = \lVert A^{-1} \rVert \lVert A \rVert \dfrac{\lVert \delta A \rVert}{\lVert A \rVert}
$$

So, we have:

$$
\dfrac{\lVert \delta x \rVert}{\lVert x \rVert} \le \kappa(A) \dfrac{\lVert \delta A \rVert}{\lVert A \rVert}
$$

#### Geometric Interpretation

A geometric interpretation of these sensitivity results in 2D is that if
the lines defined by two equations are close to parallel, then their
intersection is not sharply defined. On the other hand, if the lines are
nearly perpendicular, then the intersection is sharply defined.

#### Solving Basic Linear Systems

The general strategy is to transform the system into one that:
- is easier to solve
- has the same solution

We can premultiply both sides by any non-singular matrix $P$
without changing the solution. To see this, note that the
solution to $MAx = Mb$ is given by:

$$
z = (MA)^{-1} Mb = A^{-1} M^{-1} Mb = A^{-1} b = x
$$

##### Diagonal Matrices

If we have:

$$
\begin{pmatrix}
d\_1 & & \\
& \ddots & \\
& & d\_n \\
\end{pmatrix}
\begin{pmatrix}
x\_1 \\
\vdots \\
x\_n \\
\end{pmatrix}
\=
\begin{pmatrix}
b\_1 \\
\vdots \\
b\_n \\
\end{pmatrix}
$$

Then $x_i = \dfrac{b_i}{d_i}$.

##### Orthogonal Matrices

Solve $Qx = b$ where $Q$ is orthogonal. Then $x = Q^T b$.

##### Given SVD

Given SVD $A = U \Sigma V^T$. Then $A^{-1} = V \Sigma^{-1} U^T$.
Then $x = V \Sigma^{-1} U^T b$.

##### Solving Triangular Systems

If $Lx = b$ where $L$ is lower triangular, then we can solve by forward substitution:

$$
\begin{array}{rclcl}
l_{11} x_1 & = & b_1 & & x_1 = b_1 / l_{11} \\
l_{21} x_1 + l_{22} x_2 & = & b_2 & \Rightarrow & x_2 = (b_2 - l_{21}x_1) / l_{22} \\
l_{31} x_1 + l_{32} x_2 + l_{33} x_3 & = & b_3 & & x_3 = (b_3 - l_{31}x_1 - l_{32}x_2) / l_{33} \\
\vdots & & \vdots & & \vdots
\end{array}
$$

The above algorithm can also be formulated recursively by blocks.

Time complexity is $O(n^2)$. In the recursive version, the relation is $T(n) = 2T(n/2) + O(n^2)$.

**Existence of solution.** Solution exists if $l_{ii} \neq 0$ for all $i$.
If some $l_{ii} = 0$, then solution may not exist.

**Uniqueness of solution.** Even if some $l_{ii} = 0$ and $L^{-1}$ does not exist, the system may have solution, but it will not be unique.

#### Properties of Triangular Matrices

* The product of two triangular matrices is triangular.
* The inverse of a triangular matrix is triangular (if it exists).

