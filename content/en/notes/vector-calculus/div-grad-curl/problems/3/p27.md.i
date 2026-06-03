**Problem III-27.** Prove the statement made in Problem III-24(a) by applying Stokes' theorem
and divergence theorem. [Hint: See the diagram below]

:::figure III-27.png
:::

:::expandable
**Solution.** [Click to Expand]

Assume that $v{G} = \nabla cross v{H}$.

For any closed surface $S$ capping $C$ and $S'$ capping $C'$, let $V$ be the volume enclosed by $S$ and $S'$. Then, we have:

:::math align
iiint[V] \nabla dot v{G} \, dV &= iint[S+S'] v{G} dot unit{n} \, dS &\text{(Divergence Theorem)}
&= iint[S+S'] (\nabla cross v{H}) dot unit{n} \, dS
&= oint[C + C'] v{H} dot unit{t} \, ds &\text{(Stokes' Theorem)}
:::

Since $C$ and $C'$ follow the same path but in opposite directions, then the last integral is zero.

So, for volume bounded by any $S$ and $S'$ capping $C$ and $C'$, we have:

:::math
iiint[V] \nabla dot v{G} \, dV = 0
:::

Since choice of $S$ and $S'$ is arbitrary, it implies that $\nabla dot v{G} = 0$.
::::
