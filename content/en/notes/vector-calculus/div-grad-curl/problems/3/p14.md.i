**Problem III-14.** Use Stokes' theorem to show that

:::math
oint[C] unit{t} \, ds = 0
:::

:::expandable
**Solution.** [Click to Expand]

Using $\nabla cross v{F} = v{i} ( pd(F_z, y) - pd(F_y, z) ) + v{j} ( pd(F_x, z) - pd(F_z, x) ) + v{k} ( pd(F_y, x) - pd(F_x, y) )$, we get:
$\nabla cross v{i}$ = $\nabla cross v{j}$ = $\nabla cross v{k} = 0$.

Then, $i$-component of $oint[C] unit{t} \\, ds$ is:

:::math align
v{i} dot oint[C] unit{t} \, ds &= oint[C] v{i} dot unit{t} \, ds
&= iint[S] \nabla cross v{i} dot unit{n} \, dS
&= 0
:::

Similarly, we can show that $j$-component and $k$-component of $oint[C] unit{t} \\, ds$ are also zero.

Then, we have:

:::math
oint[C] unit{t} \, ds = 0
:::
::::
