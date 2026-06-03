**Problem III-26.** Since the divergence of any magnetic field $v{B}$ is zero, we
can write $v{B} = \nabla \times v{A}$. Prove that the circulation of $v{A}$
around any closed path $C$ is equal to the flux of $v{B}$ through any surface $S$ capping $C$.

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\oint_C v{A} \cdot unit{t} \, ds &= \iint_S (\nabla \times v{A}) \cdot unit{n} \, dS \quad \text{(Stokes' Theorem)} \\[1em]
&= \iint_S v{B} \cdot unit{n} \, dS \\[1em]
\end{align*}
$$

which is the flux of $v{B}$ through $S$.
::::
