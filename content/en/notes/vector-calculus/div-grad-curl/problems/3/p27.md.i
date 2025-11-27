**Problem III-27.** Prove the statement made in Problem III-24(a) by applying Stokes' theorem 
and divergence theorem. [Hint: See the diagram below]

![](III-27.png)

:::expandable
**Solution.** [Click to Expand]

Assume that $\mathbf{G} = \nabla \times \mathbf{H}$.

For any closed surface $S$ capping $C$ and $S'$ capping $C'$, let $V$ be the volume enclosed by $S$ and $S'$. Then, we have:

$$
\begin{align*}
\iiint_V \nabla \cdot \mathbf{G} \, dV &= \iint_{S+S'} \mathbf{G} \cdot \hat{\mathbf{n}} \, dS
&\text{(Divergence Theorem)} \\[1em]
&= \iint_{S+S'} (\nabla \times \mathbf{H}) \cdot \hat{\mathbf{n}} \, dS \\[1em]
&= \oint_{C + C'} \mathbf{H} \cdot \hat{\mathbf{t}} \, ds &\text{(Stokes' Theorem)}
\end{align*}
$$

Since $C$ and $C'$ follow the same path but in opposite directions, then the last integral is zero.

So, for volume bounded by any $S$ and $S'$ capping $C$ and $C'$, we have:

$$
\iiint_V \nabla \cdot \mathbf{G} \, dV = 0
$$

Since choice of $S$ and $S'$ is arbitrary, it implies that $\nabla \cdot \mathbf{G} = 0$.
::::
