# CS 450 - Lecture 4

* [Lecture Video](https://mediaspace.illinois.edu/media/t/1_w7fpz9ns/330048022)
* [Slides](https://relate.cs.illinois.edu/course/cs450-s24/f/lectures/02-lecture.pdf)

#### Existence of SVD

Consider the decomposition:

$$
\begin{pmatrix}
\\\\
u_1 & \cdots & u_n \\\\
\\\\
\end{pmatrix}
\begin{pmatrix}
\sigma_1 & & \\\\
& \ddots & \\\\
& & \sigma_n \\\\
\end{pmatrix}
\begin{pmatrix}
\\\\
v_1 & \cdots & v_n \\\\
\\\\
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

If $A(x + \delta x) = b + \delta b$, than how $\dfrac{\lVert \delta b \rVert\_2}{\lVert b \rVert\_2}$ relates to $\dfrac{\lVert \delta x \rVert\_2}{\lVert x \rVert\_2}$?

(In the following, we will use $\lVert \cdot \rVert$ to denote the 2-norm.)

By linearity, we can write:

$$
\begin{align*}
\delta b = A \delta x &\implies
\delta x = A^{-1} \delta b
\\\\[1em]
&\implies
\lVert \delta x \rVert \le \lVert A^{-1} \rVert \lVert \delta b \rVert
\\\\[1em]
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

---------

Now, consider perturbations to the input coefficients $\hat A = A + \delta A$. 

We want to solve $Ax = b$ and want to know how much the solution changes if we perturb the coefficients: $(A + \delta A)(x + \delta x) = b$. That is, we want to understand the relationship between $\dfrac{\lVert \delta A \rVert}{\lVert A \rVert}$ and $\dfrac{\lVert \delta x \rVert}{\lVert x \rVert}$.

Since $Ax = b$, then:

$$
\delta A \\, x + A \\, \delta x + \delta A \\, \delta x = 0
$$

Since $\delta A \\, \delta x$ is small, we can ignore it. Then we have:

$$
\delta A \\, x \approx -A \\, \delta x
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

#### Solving Basic Linear Systems

