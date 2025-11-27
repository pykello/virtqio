**Problem III-26.** Since the divergence of any magnetic field $\mathbf{B}$ is zero, we
can write $\mathbf{B} = \nabla \times \mathbf{A}$. Prove that the circulation of $\mathbf{A}$ 
around any closed path $C$ is equal to the flux of $\mathbf{B}$ through any surface $S$ capping $C$.

:::expandable
**Solution.** [Click to Expand]

$$
\begin{align*}
\oint_C \mathbf{A} \cdot \hat{\mathbf{t}} \, ds &= \iint_S (\nabla \times \mathbf{A}) \cdot \hat{\mathbf{n}} \, dS \quad \text{(Stokes' Theorem)} \\[1em]
&= \iint_S \mathbf{B} \cdot \hat{\mathbf{n}} \, dS \\[1em]
\end{align*}
$$

which is the flux of $\mathbf{B}$ through $S$.
::::
