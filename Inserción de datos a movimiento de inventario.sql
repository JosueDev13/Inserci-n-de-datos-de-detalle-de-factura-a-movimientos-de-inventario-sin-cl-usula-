insert into movimien 
    (concepto, numero, tipo, fecha, idarticulo, cantidad, cod_unidad, bodega, costo_compra, 
     factor, costo_prom, totalcosto2, entransito, precio, idgrupo, idsubgrupo, proveedor, 
     feccreo, usrcreo, NLote)
select 
    a.tipofact, a.numero, 'S', a.fecha, a.idarticulo, a.cantidad, 
    a.cod_unidad, a.bodega, 0, a.factor, a.costo, 
    a.costo * a.cantidad, 0, a.precio, a.idGrupo, 
    a.idSubGrupo, a.codProveedor, b.fechaUserCreo, 
    b.usercreo, a.nlote 
from detafac as a
inner join facturas as b on a.tipofact = b.tipofact and a.numero = b.numero
where not exists (select 1 from movimien where movimien.concepto = a.tipofact and movimien.numero = a.numero)
    and isnull(b.anulado, 0) = 0  
    and exists (select 1 from conceptos where conceptos.concepto = b.tipofact and isnull(conceptos.Es_Cotizacion, 0) = 0  )