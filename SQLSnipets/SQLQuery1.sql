USE [TNLTRG_DS]
GO
/****** Object:  StoredProcedure [dbo].[PA_Rembpend1]    Script Date: 07/09/2023 09:26:28 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure[dbo].[PA_Rembpend1](
			@OrdenId1 varchar (30),
			@OrdenId2 varchar (30),
			@DstinoId varchar (30),
			@ProvId varchar (30),
			@TrigoId varchar (30)
)
as

	select de.Nombre as 'Destino', od.OrdenId as 'No. Orden',e1.EmbId as 'No. Embarque', e1.Reftrans as 'Ref. Transporte',
	e1.Fchemb as 'Fecha Embarque', e1.Pesoemb as 'Peso Embarque', lo.LoteId, pr.Nombre Proveedor,
	og.Nombre Origen, tr.Nombre Trigo, lo.Grado, lo.Proteina
	from sLotes lo inner join sOrdenes od
			on lo.LoteId=od.LoteId 
	inner join sEmb1 e1
			on od.OrdenId = e1.OrdenId  
	inner join sDestino de
			on e1.DstinoId = de.DstinoId
	inner join sProveed pr
		on lo.ProvId = pr.ProvId
	inner join sOrigen og
		on od.OrigenId = og.OrigenId
	inner join sTrigos tr
		on lo.TrigoId = tr.TrigoId
	where od.OrdenId between @OrdenId1 and @OrdenId2 
	AND e1.DstinoId like '%'+@DstinoId+'%' 
	AND lo.ProvId like '%'+@ProvId+'%' 
	AND lo.TrigoId like '%'+@TrigoId+'%'
	and lo.EstadoId <> 'L'
	and od.EstadoId <> 'L'
	and e1.EstadoId <> 'L'
	and e1.Silo is NULL

	Exec [dbo].[PA_Rembpend1]
			@OrdenId1,
			@OrdenId2,
			@DstinoId,
			@ProvId,
			@TrigoId
--, sEmb1 e1, sDestino de, sTrigos

--select  * from sEmb1;
--select TOP 100 * from sLotes;
--select  *from sOrdenes;
--select * from sProveed
--select TOP 10 * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select TOP 10 * from sLotes
