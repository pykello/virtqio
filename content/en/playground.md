### Alerts

> [!NOTE]  
> Highlights information that users should take into account, even when skimming.

> [!TIP]
> Optional information to help a user be more successful.

> [!IMPORTANT]  
> Crucial information necessary for users to succeed.

> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.

> [!CAUTION]
> Negative potential consequences of an action.

<div id="box" class="jxgbox" style="width:480px; height:360px; margin: auto;"></div>

<script>
    var board = JXG.JSXGraph.initBoard('box', {
        boundingbox: [-5, 10, 7, -6],
        axis:true,
        showCopyright: false,
        showNavigation: false
    });
    board.suspendUpdate();
    var p = [];
    p[0] = board.create('point', [-1,-2], {size:2});
    p[1] = board.create('point', [6,5], {size:2});
    p[2] = board.create('point', [-0.5,1], {size:2});
    p[3] = board.create('point', [3,3], {size:2});
    var f = JXG.Math.Numerics.lagrangePolynomial(p);
    var graph = board.create('functiongraph', [f,-10, 10]);

    var g = function(x) {
        return JXG.Math.Numerics.D(f)(x)-(p[1].Y()-p[0].Y())/(p[1].X()-p[0].X());
    };

    var r = board.create('glider', [
                        function() { return JXG.Math.Numerics.root(g,(p[0].X()+p[1].X())*0.5); },
                        function() { return f(JXG.Math.Numerics.root(g,(p[0].X()+p[1].X())*0.5)); },
                        graph], {name:' ',size:4,fixed:true});
    board.create('tangent', [r], {strokeColor:'#ff0000'});
    line = board.create('line',[p[0],p[1]],{strokeColor:'#ff0000',dash:1});

    board.unsuspendUpdate();
</script>
