**Problem III-26.** Since the divergence of any magnetic field $v{B}$ is zero, we
can write $v{B} = \nabla cross v{A}$. Prove that the circulation of $v{A}$
around any closed path $C$ is equal to the flux of $v{B}$ through any surface $S$ capping $C$.

:::expandable
**Solution.** [Click to Expand]

:::math align
oint[C] v{A} dot unit{t} \, ds &= iint[S] (\nabla cross v{A}) dot unit{n} \, dS \quad \text{(Stokes' Theorem)}
&= iint[S] v{B} dot unit{n} \, dS
:::

which is the flux of $v{B}$ through $S$.
::::
