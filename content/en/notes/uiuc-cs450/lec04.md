# CS 450 - Lecture 4

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_w7fpz9ns/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

Some notes and examples are from:

* Heath, M. T. (2018). Scientific computing: An introductory survey (Revised Second Edition). SIAM. https://doi.org/10.1137/1.9781611975581

#### Existence of SVD

Consider the decomposition:

:::math plain
pmat(u_1, ..., u_n)
\begin{pmatrix}
sigma_1 & & \\
& \ddots & \\
& & sigma_n \\
\end{pmatrix}
pmat(v_1, ..., v_n)^T
= sum[i=1..n] sigma_i u_i v_i^T
:::

We want to find $x_1$ such that $norm(x_1)_2 = 1$ and maximizes $norm(Ax)_2$. Then $x_1$ is the first right singular vector $v_1$. We can show that $Av_1 = sigma_1 u_1$, and therefore $u_1 = \dfrac{Av_1}{norm(Av_1)_2} = \dfrac{Av_1}{sigma_1}$.

Similarly, $v_2$ is the vector that maximizes $norm((A - sigma_1 u_1 v_1^T)x)_2$ subject to $norm(x)_2 = 1$, and so on.

#### Conditioning of Linear Systems

We saw previously that $kappa(A) = norm(A)_2 norm(A^{-1})_2$ controls
the maximum relative perturbation of $Ax$.

We can also show $kappa(A)$ describes the conditioning of the linear system $Ax = b$.
That is, if we perturb $b$ by $del b$, what's the maximum relative perturbation $del x$ in the solution $x$?

If $A(x + del x) = b + del b$, then how $\dfrac{norm(del b)_2}{norm(b)_2}$ relates to $\dfrac{norm(del x)_2}{norm(x)_2}$?

(In the following, we will use $norm(dot)$ to denote the 2-norm.)

By linearity, we can write:

:::math align
del b = A del x &=> del x = A^{-1} del b
&=> norm(del x) <= norm(A^{-1}) norm(del b)
&=> \dfrac{norm(del x)}{norm(x)} <= \dfrac{norm(A^{-1}) dot norm(del b)}{norm(x)} \tag{1}
:::

Since $x$ is in the denominator, we are interested in lower bounding it. Since $Ax = b$, we have:

:::math
norm(x) >= \frac{norm(b)}{norm(A)} \tag{2}
:::

Then putting (2) and (1) together, we get:

:::math
\dfrac{norm(del x)}{norm(x)} <= norm(A) dot norm(A^{-1}) dot \dfrac{norm(del b)}{norm(b)}
:::

So, we have:

:::math
\dfrac{norm(del x)}{norm(x)}
    <= kappa(A) \dfrac{norm(del b)}{norm(b)}
:::

---------

Now, consider perturbations to the input coefficients $\hat A = A + del A$.

We want to solve $Ax = b$ and want to know how much the solution changes if we perturb the coefficients: $(A + del A)(x + del x) = b$. That is, we want to understand the relationship between $\dfrac{norm(del A)}{norm(A)}$ and $\dfrac{norm(del x)}{norm(x)}$.

Since $Ax = b$, then:

:::math
del A \, x + A \, del x + del A \, del x = 0
:::

Since $del A \, del x$ is small, we can ignore it. Then we have:

:::math
del A \, x \approx -A \, del x
:::

Then:

:::math
norm(del x) <= norm(A^{-1}) norm(del A) norm(x)
:::

Which means:

:::math
\dfrac{norm(del x)}{norm(x)} <= norm(A^{-1}) norm(del A) = norm(A^{-1}) norm(A) \dfrac{norm(del A)}{norm(A)}
:::

So, we have:

:::math
\dfrac{norm(del x)}{norm(x)} <= kappa(A) \dfrac{norm(del A)}{norm(A)}
:::

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

:::math
z = (MA)^{-1} Mb = A^{-1} M^{-1} Mb = A^{-1} b = x
:::

##### Diagonal Matrices

If we have:

:::math plain
\begin{pmatrix}
d_1 & & \\
& \ddots & \\
& & d_n \\
\end{pmatrix}
pmat(x_1; \vdots; x_n)
=
pmat(b_1; \vdots; b_n)
:::

Then $x_i = \dfrac{b_i}{d_i}$.

##### Orthogonal Matrices

Solve $Qx = b$ where $Q$ is orthogonal. Then $x = Q^T b$.

##### Given SVD

Given SVD $A = U Sigma V^T$. Then $A^{-1} = V Sigma^{-1} U^T$.
Then $x = V Sigma^{-1} U^T b$.

##### Solving Triangular Systems

If $Lx = b$ where $L$ is lower triangular, then we can solve by forward substitution:

:::math plain
\begin{array}{rclcl}
l_{11} x_1 & = & b_1 & & x_1 = b_1 / l_{11} \\
l_{21} x_1 + l_{22} x_2 & = & b_2 & \Rightarrow & x_2 = (b_2 - l_{21}x_1) / l_{22} \\
l_{31} x_1 + l_{32} x_2 + l_{33} x_3 & = & b_3 & & x_3 = (b_3 - l_{31}x_1 - l_{32}x_2) / l_{33} \\
\vdots & & \vdots & & \vdots
\end{array}
:::

The above algorithm can also be formulated recursively by blocks.

Time complexity is $O(n^2)$. In the recursive version, the relation is $T(n) = 2T(n/2) + O(n^2)$.

**Existence of solution.** Solution exists if $l_{ii} != 0$ for all $i$.
If some $l_{ii} = 0$, then solution may not exist.

**Uniqueness of solution.** Even if some $l_{ii} = 0$ and $L^{-1}$ does not exist, the system may have solution, but it will not be unique.

#### Properties of Triangular Matrices

* The product of two triangular matrices is triangular.
* The inverse of a triangular matrix is triangular (if it exists).
