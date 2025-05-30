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