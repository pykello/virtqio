**Problem IV-2.**
Verify the following identities.

**(a)** $\nabla(fg) = f \nabla g + g \nabla f$

:::expandable
**Solution.** [Click to Expand]

:::math align
\nabla(fg) &= pd(\partial(fg), x) v{i} + pd(\partial(fg), y) v{j} + pd(\partial(fg), z) v{k}
&= g pd(f, x) v{i} + f pd(g, x) v{i} + g pd(f, y) v{j} + f pd(g, y) v{j} + g pd(f, z) v{k} + f pd(g, z) v{k}
&= f ( pd(g, x) v{i} + pd(g, y) v{j} + pd(g, z) v{k} ) + g ( pd(f, x) v{i} + pd(f, y) v{j} + pd(f, z) v{k} )
&= f \nabla g + g \nabla f
:::
:::

**(b)** $\nabla(v{F} dot v{G}) = (v{G} dot \nabla) v{F} + (v{F} dot \nabla) v{G} + v{F} cross (\nabla cross v{G}) + v{G} cross (\nabla cross v{F})$

:::expandable
**Solution.** [Click to Expand]

We have:

:::math align
( (v{G} dot \nabla) v{F} )_x &= G_x pd(F_x, x) + G_y pd(F_x, y) + G_z pd(F_x, z)
( (v{F} dot \nabla) v{G} )_x &= F_x pd(G_x, x) + F_y pd(G_x, y) + F_z pd(G_x, z)
(v{F} cross (\nabla cross v{G}))_x &= F_y ( pd(G_y, x) - pd(G_x, y) ) - F_z ( pd(G_x, z) - pd(G_z, x) )
(v{G} cross (\nabla cross v{F}))_x &= G_y ( pd(F_y, x) - pd(F_x, y) ) - G_z ( pd(F_x, z) - pd(F_z, x) )
:::

Adding these together, we get:

:::math
G_x pd(F_x, x) + F_x pd(G_x, x) +
G_y pd(F_x, y) + F_y pd(G_x, y) +
G_z pd(F_x, z) + F_z pd(G_x, z) +
:::

which is equal to:

:::math
pd(\partial, x) (F_x G_x + F_y G_y + F_z G_z)
:::

which is the $x$-component of $\nabla(v{F} dot v{G})$.

Similarly, we can prove the equality for the $y$ and $z$ components.

::::

**(c)** $\nabla dot (f v{F}) = f \nabla dot v{F} + v{F} dot \nabla f$

:::expandable
**Solution.** [Click to Expand]

:::math align
\nabla dot (f v{F}) &= pd((f F_x), x) + pd((f F_y), y) + pd((f F_z), z)
&= f pd(F_x, x) + F_x pd(f, x) + f pd(F_y, y) + F_y pd(f, y) + f pd(F_z, z) + F_z pd(f, z)
&= f \nabla dot v{F} + v{F} dot \nabla f
:::
::::

**(d)** $\nabla dot (v{F} cross v{G}) = v{G} dot (\nabla cross v{F}) - v{F} dot (\nabla cross v{G})$

:::expandable
**Solution.** [Click to Expand]

We have:

:::math align
v{G} dot (\nabla cross v{F}) &= G_x ( pd(F_z, y) - pd(F_y, z) ) + G_y ( pd(F_x, z) - pd(F_z, x) ) + G_z ( pd(F_y, x) - pd(F_x, y) )
v{F} dot (\nabla cross v{G}) &= F_x ( pd(G_z, y) - pd(G_y, z) ) + F_y ( pd(G_x, z) - pd(G_z, x) ) + F_z ( pd(G_y, x) - pd(G_x, y) )
:::

Then:

:::math align
v{G} dot (\nabla cross v{F}) &- v{F} dot (\nabla cross v{G}) =
& (G_z pd(F_y, x) + F_y pd(G_z, x)) \- (G_y pd(F_z, x) + F_z pd(G_y, x))
\+ &(G_x pd(F_z, y) + F_z pd(G_x, y)) \- (G_z pd(F_x, y) + F_x pd(G_z, y))
\+ &(G_y pd(F_x, z) + F_x pd(G_y, z)) \- (G_x pd(F_y, z) + F_y pd(G_x, z))
:::

Then:

:::math align
v{G} dot &(\nabla cross v{F}) - v{F} dot (\nabla cross v{G})
&= pd(\partial, x) (F_y G_z - F_z G_y) + pd(\partial, y) (F_z G_x - F_x G_z) + pd(\partial, z) (F_x G_y - F_y G_x)
&= \nabla dot (v{F} cross v{G})
:::

::::

**(e)** $\nabla cross (f v{F}) = f \nabla cross v{F} + (\nabla f) cross v{F}$

:::expandable
**Solution.** [Click to Expand]

:::math align
\nabla cross (f v{F}) &= v{i} ( pd((f F_z), y) - pd((f F_y), z) )
&\quad + v{j} ( pd((f F_x), z) - pd((f F_z), x) )
&\quad + v{k} ( pd((f F_y), x) - pd((f F_x), y) )
&= v{i} ( f pd(F_z, y) + F_z pd(f, y) - f pd(F_y, z) - F_y pd(f, z) )
&\quad + v{j} ( f pd(F_x, z) + F_x pd(f, z) - f pd(F_z, x) - F_z pd(f, x) )
&\quad + v{k} ( f pd(F_y, x) + F_y pd(f, x) - f pd(F_x, y) - F_x pd(f, y) )
&= f ( v{i} ( pd(F_z, y) - pd(F_y, z) ) + v{j} ( pd(F_x, z) - pd(F_z, x) ) + v{k} ( pd(F_y, x) - pd(F_x, y) ) )
&\quad + ( pd(f, y) F_z - pd(f, z) F_y ) v{i} \+ ( pd(f, z) F_x - pd(f, x) F_z ) v{j} + ( pd(f, x) F_y - pd(f, y) F_x ) v{k}
&= f \nabla cross v{F} + (\nabla f) cross v{F}
:::

::::
