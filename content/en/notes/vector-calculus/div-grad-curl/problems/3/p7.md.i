**Problem III-7.** Show that $\nabla dot (\nabla cross v{F}) = 0$. (Assume that
mixed second partial derivatives are independent of the order of differentiation.)

:::expandable
**Solution.** [Click to Expand]

:::math align
\nabla cross v{F} &= v{i} ( pd(F_z, y) - pd(F_y, z) )
&+ v{j} ( pd(F_x, z) - pd(F_z, x) )
&+ v{k} ( pd(F_y, x) - pd(F_x, y) )
:::

Then:

:::math align
\nabla dot (\nabla cross v{F}) &= pd2(F_z, x, y) - pd2(F_y, x, z)
&+ pd2(F_x, y, z) - pd2(F_z, x, y)
&+ pd2(F_y, x, z) - pd2(F_x, y, z)
&= 0
:::
::::
