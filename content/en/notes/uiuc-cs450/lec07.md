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
minimizes the **residual** $\lVert Ax - b \rVert\_2$.

For an optimal solution $x^\*$, we have $r \perp \text{span}(A)$ where
$r = Ax^\* - b$. Residual can only be $0$ if $b \in \text{span}(A)$.