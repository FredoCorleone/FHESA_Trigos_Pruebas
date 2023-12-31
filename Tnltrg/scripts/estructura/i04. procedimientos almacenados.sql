USE [TNLTRG]
GO
/****** Object:  StoredProcedure [dbo].[PA_Ajuactestado]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Ajuactestado](
    @Ordenid varchar (10),
	@Estadoid char
	)
	

as


	--Declaración de variables de entrada
	declare @AjustId varchar (10),
			@Fchajus date,
			@Compensa decimal(19,3),
			@Merma1 decimal(19,3),
			@Merma2 decimal(19,3),
			@Merma3 decimal(19,3),
			@Obsrv varchar (1000),
			@Fchcrea datetime,
			@Usrcrea varchar(10),
			@Fchmod datetime,
			@Usrmod varchar(10),
			@Nuevoest char(1)
	
	set @Nuevoest = @Estadoid
		
	--Declaración del cursor
	DECLARE CursorTipos CURSOR
	FOR
		--Consulta de entrada
		select aj.AjustId, aj.OrdenId, aj.Fchajus, aj.Compensa, aj.Merma1, aj.Merma2, aj.Merma3,aj.Obsrv, 
		aj.Fchcrea, aj.Usrcrea, aj.Fchmod, aj.Usrmod, aj.EstadoId
		from sAjustes aj 
		where OrdenId = @Ordenid;
		
	OPEN CursorTipos
	FETCH CursorTipos INTO @AjustId,@OrdenId,@Fchajus,@Compensa,@Merma1,@Merma2,@Merma3,@Obsrv, 
		@Fchcrea, @Usrcrea,@Fchmod,@Usrmod,@EstadoId
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva
		 
		 if @Nuevoest <> @Estadoid and @Estadoid <> 'L'
			exec[PA_sAjustes] 3, @AjustId,@OrdenId,@Fchajus,@Compensa,@Merma1,@Merma2,@Merma3,@Obsrv,
			 @Fchcrea, @Usrcrea,@Fchmod,@Usrmod,@Nuevoest


		FETCH CursorTipos INTO @AjustId,@OrdenId,@Fchajus,@Compensa,@Merma1,@Merma2,@Merma3,@Obsrv, 
		@Fchcrea, @Usrcrea,@Fchmod,@Usrmod,@EstadoId
	END 

	--Cerrar cursor
	CLOSE CursorTipos
	DEALLOCATE CursorTipos

GO
/****** Object:  StoredProcedure [dbo].[PA_Busquedas]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Busquedas](
	@Opcion smallint,
	@Funcion smallint,
	@Param1 varchar (500),
	@Param2 varchar (500),
	@Param3 varchar (500),
	@Param4 varchar (500),
	@Param5 varchar (500),
	@Param6 varchar (500)
	)
	
as

	declare @fechaini date,
			@fechafin date
			
			

	--Búsquedas de proveedores
	if @Opcion = 1
	begin
		if @Funcion = 1
			select pr.ProvId [Código], pr.Nombre [Razón Social], Cntcto Contacto,
			case when Activo = 1 then
				'Sí'
			else
				'No'
			end Activo,
			cp.Nombre Tipo
			from sProveed pr inner join cTpoprov cp
				on pr.TpoprvId = cp.TpoprvId
			where pr.ProvId like '%' + replace (@Param1, '*', '%') + '%'
			and pr.TpoprvId like '%' + replace (@Param2, '*', '%') + '%'
			and pr.Activo = convert (bit, @Param3)
			and pr.Nombre like '%' + replace (@Param4, '*', '%') + '%'
			and pr.Cntcto like '%' + replace (@Param5, '*', '%') + '%'
			
		return
	end


	--Búsquedas de trigos
	if @Opcion = 2
	begin
		if @Funcion = 1
			select tr.TrigoId [Código], tr.Nombre Nombre,
			case when tr.Activo = 1 then
				'Sí'
			else
				'No'
			end Activo
			from sTrigos tr
			where tr.TrigoId like '%' + replace (@Param1, '*', '%') + '%'
			and tr.Nombre like '%' + replace (@Param2, '*', '%') + '%'
			and tr.Activo = convert (bit, @Param3)

			
		return
	end




	--Búsquedas de lotes
	if @Opcion = 3
	begin	
		select @fechaini = convert(date, @Param5),
		@fechafin = case when year (convert(date, @Param5)) = 1899 then
						convert (date, '2099-12-31')
					else
						convert(date, @Param5)
					end
							
		if @Funcion = 1
			select lo.LoteId Lote, lo.Fchlote Fecha, pr.Nombre Proveedor, tr.Nombre Trigo,
			lo.Proteina, lo.Grado, ce.Nombre Estado
			from sLotes lo inner join sProveed pr
				on lo.ProvId = pr.ProvId
			inner join sTrigos tr
				on lo.TrigoId = tr.TrigoId
			inner join cEstados ce
				on lo.EstadoId = ce.EstadoId
			where lo.LoteId like '%' + replace (@Param1, '*', '%') + '%'
			and lo.EstadoId like '%' + replace (@Param2, '*', '%') + '%'
			and lo.ProvId like '%' + replace (@Param3, '*', '%') + '%'
			and lo.TrigoId like '%' + replace (@Param4, '*', '%') + '%'
			and lo.Fchlote between @fechaini and @fechafin

		
		return
	end
	
	
	

	--Búsquedas de orígenes
	if @Opcion = 4
	begin
		if @Funcion = 1
			select og.OrigenId [Código], og.Nombre Nombre,
			case when og.Activo = 1 then
				'Sí'
			else
				'No'
			end Activo
			from sOrigen og
			where og.OrigenId like '%' + replace (@Param1, '*', '%') + '%'
			and og.Nombre like '%' + replace (@Param2, '*', '%') + '%'
			and og.Activo = convert (bit, @Param3)

			
		return
	end
	
	
	
	
	
	--Búsquedas de órdenes
	if @Opcion = 5
	begin
		select @fechaini = convert(date, @Param3),
		@fechafin = case when year (convert(date, @Param3)) = 1899 then
						convert (date, '2099-12-31')
					else
						convert(date, @Param3)
					end
					
		if @Funcion = 1
			select od.OrdenId [Código], od.Fchord Fecha, od.LoteId Lote, od.Tnladas Toneladas,
			od.CtrtoId Contrato, lo.TrigoId [Código Trigo], tr.Nombre Trigo, lo.Grado, lo.Proteina [Proteína],
			lo.ProvId [Código Prov. Trigo], pr.Nombre [Proveedor Trigo], od.OrigenId [Código Origen], og.Nombre Origen,
			lo.Humedad, lo.Pesohtl, lo.Impureza
			from sOrdenes od inner join sOrigen og
				on od.OrigenId = og.OrigenId
			inner join sLotes lo
				on od.LoteId = lo.LoteId
			inner join sTrigos tr
				on lo.TrigoId = tr.TrigoId
			inner join sProveed pr
				on lo.ProvId = pr.ProvId
			where od.OrdenId like '%' + replace (@Param1, '*', '%') + '%'
			and od.EstadoId like '%' + replace (@Param2, '*', '%') + '%'
			and od.Fchord between @fechaini and @fechafin
			and od.CtrtoId like '%' + replace (@Param4, '*', '%') + '%'
			and od.LoteId like '%' + replace (@Param5, '*', '%') + '%'
			and od.OrigenId like '%' + replace (@Param6, '*', '%') + '%'
			
			
		return
	end
	
	
	
	
	--Búsquedas de destinos
	if @Opcion = 6
	begin
		if @Funcion = 1
			select de.DstinoId [Código], de.Nombre Nombre,
			case when de.Activo = 1 then
				'Sí'
			else
				'No'
			end Activo
			from sDestino de
			where de.DstinoId like '%' + replace (@Param1, '*', '%') + '%'
			and de.Nombre like '%' + replace (@Param2, '*', '%') + '%'
			and de.Activo = convert (bit, @Param3)

			
		return
	end
	
	
	
	--Búsquedas de operadores
	if @Opcion = 7
	begin
		if @Funcion = 1
			select op.OprdorId [Código], op.Nombre Nombre, op.Nkname Nickname,
			case when op.Activo = 1 then
				'Sí'
			else
				'No'
			end Activo
			from sOprador op
			where op.OprdorId like '%' + replace (@Param1, '*', '%') + '%'
			and op.Nombre like '%' + replace (@Param2, '*', '%') + '%'
			and op.Activo = convert (bit, @Param3)

			
		return
	end





	--Búsquedas de embarques
	if @Opcion = 8
	begin
		select @fechaini = convert(date, @Param3),
		@fechafin = case when year (convert(date, @Param3)) = 1899 then
						convert (date, '2099-12-31')
					else
						convert(date, @Param3)
					end
					
		if @Funcion = 1
			select e1.EmbId [Código], e1.Fchemb Fecha, e1.Pesoemb [Peso Embarcado], e1.Reftrans [Ref. Transporte],
			od.OrdenId Orden, od.Tnladas [Ton. Orden], od.LoteId Lote, e1.Factfl [Factura Flete], e1.EstadoId		
			from sEmb1 e1 inner join sOrdenes od
				on e1.OrdenId = od.OrdenId
			inner join sLotes lo
				on od.LoteId = lo.LoteId
			where e1.EmbId like '%' + replace (@Param1, '*', '%') + '%'
			and e1.EstadoId like '%' + replace (@Param2, '*', '%') + '%'
			and e1.Fchemb between @fechaini and @fechafin
			and e1.OrdenId like '%' + replace (@Param4, '*', '%') + '%'
			and od.LoteId like '%' + replace (@Param5, '*', '%') + '%'
			and e1.Reftrans like '%' + replace (@Param6, '*', '%') + '%'
			
			
		return
	end
	
	

	
	--Búsquedas de ajustes
	if @Opcion = 9
	begin
		select @fechaini = convert(date, @Param3),
		@fechafin = case when year (convert(date, @Param3)) = 1899 then
						convert (date, '2099-12-31')
					else
						convert(date, @Param3)
					end
					
		if @Funcion = 1
			select aj.AjustId [Código], aj.Fchajus Fecha,
			od.OrdenId Orden, od.Tnladas [Ton. Orden], od.LoteId Lote,
			aj.Compensa [Compensación], aj.Merma1 [Merma 1], aj.Merma2 [Merma 2],
			aj.Merma3 [Merma 3]
			from sAjustes aj inner join sOrdenes od
				on aj.OrdenId = od.OrdenId
			where aj.AjustId like '%' + replace (@Param1, '*', '%') + '%'
			and aj.EstadoId like '%' + replace (@Param2, '*', '%') + '%'
			and aj.Fchajus between @fechaini and @fechafin						
			and aj.OrdenId like '%' + replace (@Param4, '*', '%') + '%'
			
		return
	end
	
	

	--Búsquedas de ventas
	if @Opcion = 10
	begin
		select @fechaini = convert(date, @Param3),
		@fechafin = case when year (convert(date, @Param3)) = 1899 then
						convert (date, '2099-12-31')
					else
						convert(date, @Param3)
					end
					
		if @Funcion = 1
			select ve.VentaId [Código], ve.Fchventa Fecha,
			od.OrdenId Orden, od.Tnladas [Ton. Orden], od.LoteId Lote,
			ve.Tonventa [Venta]
			from sVentas ve inner join sOrdenes od
				on ve.OrdenId = od.OrdenId
			where ve.VentaId like '%' + replace (@Param1, '*', '%') + '%'
			and ve.EstadoId like '%' + replace (@Param2, '*', '%') + '%'
			and ve.Fchventa between @fechaini and @fechafin						
			and ve.OrdenId like '%' + replace (@Param4, '*', '%') + '%'
			
		return
	end
	
	

	
	
	--Búsquedas de silos
	if @Opcion = 11
	begin
					
		if @Funcion = 1
			select e1.Silo, count (e1.Silo) Uso
			from sEmb1 e1
			where e1.EstadoId <> 'L'
			and e1.Silo like '%' + replace (@Param1, '*', '%') + '%'
			group by e1.Silo
			
			
			
		return
	end
	
	
	
	
	
	--Búsqueda de moneda
	if @Opcion = 12
	begin
		if @Funcion = 1
			select MonedaId, Descripcion
			from cMoneda cm
			where cm.Activo = 1
			
		
		return
	end




	--Busqueda de logeos
	if @Opcion = 13
	begin
		select @fechaini = convert(date, @Param3),
		@fechafin = case when year (convert(date, @Param3)) = 1899 then
						convert (date, '2099-12-31')
					else
						convert(date, @Param3)
					end
		if @Funcion = 1
			select LogId, Fchconex, HostId
			from sLogeo lgo
			where UsrId=@Param1 and Fchconex between @fechaini and @fechafin
			
		
		return
	end
	
	
	
	--Búsqueda de Silos por Destino
	if @Opcion = 14
	begin
		if @Funcion = 1
			select SiloId
			from sSilos si
			where si.DstinoId = @Param1
			and si.Activo = 1
			order by LEFT(si.SiloId,1), right ('000' + si.SiloId, 3)

		return
	end
		
	
	
	
	--Búsquedas de Perfiles
	if @Opcion = 15
	begin
		if @Funcion = 1
			select p1.PerfilId [Código], p1.Nombre Nombre,
			case when p1.Activo = 1 then
				'Sí'
			else
				'No'
			end Activo
			from sPrfls1 p1
			where p1.PerfilId like '%' + replace (@Param1, '*', '%') + '%'
			and p1.Nombre like '%' + replace (@Param2, '*', '%') + '%'
			and p1.Activo = convert (bit, @Param3)

			
		return
	end
	
	
	
	
	--Búsquedas de Usuarios
	if @Opcion = 16
	begin
		if @Funcion = 1
			select us.UsrId [Código], us.Nkname, us.Nombre + ' ' + us.Apllidom + ' ' + us.Apllidom Nombre,
			case when us.Activo = 1 then
				'Sí'
			else
				'No'
			end Activo
			from sUsuarios us
			where us.UsrId like '%' + replace (@Param1, '*', '%') + '%'
			and us.Nkname like '%' + replace (@Param2, '*', '%') + '%'
			and us.Nombre like '%' + replace (@Param3, '*', '%') + '%'
			and us.Apllidop like '%' + replace (@Param4, '*', '%') + '%'
			and us.Apllidom like '%' + replace (@Param5, '*', '%') + '%'
			and us.Activo = convert (bit, @Param6)

			
		return
	end
	
	


GO
/****** Object:  StoredProcedure [dbo].[PA_Catalogos]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Catalogos](
	@Opcion smallint,
	@Funcion smallint,
	@Param1 varchar (500),
	@Param2 varchar (500),
	@Param3 varchar (500),
	@Param4 varchar (500),
	@Param5 varchar (500)
	)


as


	if @Opcion = 1
	begin
		select EstadoId, Nombre
		from cEstados
		
		return
	end
	
	
	
	if @Opcion = 2
	begin
		select TpoprvId Tipo, Nombre
		from cTpoprov
		
		return
	end
	
	
	
	
	if @Opcion = 3
	begin
		select MonedaId, MonedaId + ' - ' + Descripcion Descripcion
		from cMoneda cm
		where cm.Activo = 1
			
		
		return
	end
	
	
	
	
	if @Opcion = 4
	begin
		select PuestoId, Nombre Descripcion
		from cPuestos cp

			
		return
	end	




	if @Opcion = 5
	begin
		select PerfilId, Nombre Descripcion
		from sPrfls1 p1
		where p1.Activo = 1
			
		return
	end	




	if @Opcion = 6
	begin

		select OprdorId, Nombre Descripcion
		from sOprador op
		where op.Activo = 1
			
		return
	end	



	if @Opcion = 7
	begin

		select SmtpId, Nombre Descripcion
		from sSmtp st
			
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_Embactestado]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Embactestado](
	@Ordenid varchar (10),
	@Estadoid char
	)

as


	--Declaración de variables de entrada
	declare @Embid varchar (10),
			@Reftrans varchar (60),
			@Dstinoid varchar (10),
			@Provflet varchar (10),
			@Pesoemb decimal (19,3),
			@Fchemb date,
			@Noselloe varchar (60),
			@Fchrec date,
			@Pesore decimal (19,3),
			@Dif decimal (19,3),
			@Oprdorid varchar (10),
			@Silo varchar (25),
			@Sellorec varchar (60),
			@Factfl varchar (20),
			@Obgen varchar (1000),
			@Usrcrea varchar (10),
			@Usrmod varchar (10),
			@Fchcrea datetime,
			@Fchmod datetime,
			@MonedaId varchar(10),
			@Tarifa decimal(16,4),
			@Refcrgmas varchar(40),
			@Nuevoest char
	
	set @Nuevoest = @Estadoid
		
	--Declaración de tabla de estados temporal
	declare @Embtemp table(
		EmbId varchar(10),
		EstadoId char);

	--Inserción en tabla de estados temporal
	insert into @Embtemp
	select EmbId, EstadoId
	from sEmb1
	where OrdenId = @OrdenId;
	


	--Declaración del cursor
	DECLARE CursorTipos CURSOR
	FOR
		--Consulta de entrada
		select e1.EmbId, e1.OrdenId, e1.Reftrans, e1.DstinoId, e1.Provflet, e1.Pesoemb, e1.Fchemb, e1.Noselloe, e1.Fchrec, 
		e1.Pesore, e1.Dif, e1.OprdorId, e1.Silo, e1.Sellorec, e1.Factfl, e1.Obgen, e1.Usrcrea, e1.Usrmod, e1.Fchcrea, 
		e1.Fchmod, e1.EstadoId, e1.MonedaId, e1.Tarifa, e1.Refcrgmas
		from sEmb1 e1 
		where OrdenId = @OrdenId;
		
	OPEN CursorTipos
	FETCH CursorTipos INTO @Embid, @Ordenid, @Reftrans, @Dstinoid, @Provflet, @Pesoemb, @Fchemb, @Noselloe, @Fchrec, @Pesore, @Dif, 
							@Oprdorid, @Silo, @Sellorec, @Factfl, @Obgen, @Usrcrea, @Usrmod, @Fchcrea, @Fchmod, @Estadoid, @Monedaid, @Tarifa, @Refcrgmas

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva
		

		 if @Nuevoest <> @Estadoid and @Estadoid <> 'L'
			exec[PA_sEmb1] 3,  @Embid, @Ordenid, @Reftrans, @Dstinoid, @Provflet, @Pesoemb, @Fchemb, @Noselloe, @Fchrec, @Pesore, @Dif, 
								@Oprdorid, @Silo, @Sellorec, @Factfl, @Obgen, @Usrcrea, @Usrmod, @Fchcrea, @Fchmod, @Nuevoest, @Monedaid, @Tarifa, @Refcrgmas

			
		FETCH CursorTipos INTO @Embid, @Ordenid, @Reftrans, @Dstinoid, @Provflet, @Pesoemb, @Fchemb, @Noselloe, @Fchrec, @Pesore, @Dif, 
							@Oprdorid, @Silo, @Sellorec, @Factfl, @Obgen, @Usrcrea, @Usrmod, @Fchcrea, @Fchmod, @Estadoid, @Monedaid, @Tarifa, @Refcrgmas
	END 

	--Cerrar cursor
	CLOSE CursorTipos
	DEALLOCATE CursorTipos




		--Declaración de variables de entrada Emb2
	declare @Condlimp bit,
			@Olor varchar (100),
			@Color varchar (100),
			@Danado varchar (100),
			@Plagas varchar (100),
			@Otros varchar (100)



	--Declaración del cursor
	DECLARE CursorTipos2 CURSOR
	FOR
		--Consulta de entrada
		select e2.Condlimp, e2.Olor, e2.Color, e2.Danado, e2.Plagas, e2.Otros, e2.EmbId, e2.Usrmod, e2.Fchmod, et.EstadoId
		from sEmb2 e2 inner join @Embtemp et
			on e2.EmbId = et.EmbId
		
		
	OPEN CursorTipos2
	FETCH CursorTipos2 INTO @Condlimp, @Olor, @Color, @Danado, @Plagas, @Otros, @Embid, @Usrmod, @Fchmod, @EstadoId

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva
		 
		if @Nuevoest <> @Estadoid and @Estadoid <> 'L'
			exec[PA_sEmb2] 3, @Condlimp, @Olor, @Color, @Danado, @Plagas, @Otros, @Embid, @Usrmod, @Fchmod
		
		FETCH CursorTipos2 INTO @Condlimp, @Olor, @Color, @Danado, @Plagas, @Otros, @Embid, @Usrmod, @Fchmod, @EstadoId

	END 

	--Cerrar cursor
	CLOSE CursorTipos2
	DEALLOCATE CursorTipos2

	declare @Condtra int,
	        @Libreba varchar(100),
			@Libregr varchar (100),
			@Sellosc varchar(100),
			@Servtra varchar(100)
			
			
	--Declaración del cursor
	DECLARE CursorTipos3 CURSOR
	FOR
		--Consulta de entrada
		select e3.Condtra, e3.Libreba, e3.Libregr, e3.Otros, e3.Sellosc, e3.Servtra, e3.EmbId, e3.Usrmod, e3.Fchmod, et.EstadoId
		from sEmb3 e3 inner join @Embtemp et
			on e3.EmbId = et.EmbId
		
		
	OPEN CursorTipos3
	FETCH CursorTipos3 INTO @Condtra, @Libreba, @Libregr,@Otros,@Sellosc,@Servtra,@EmbId,@Usrmod,@Fchmod, @Estadoid

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva


		if @Nuevoest <> @Estadoid and @Estadoid <> 'L'
			exec[PA_sEmb3] 3,@Condtra, @Libreba, @Libregr,@Otros,@Sellosc,@Servtra,@EmbId,@Usrmod,@Fchmod
		
		FETCH CursorTipos3 INTO @Condtra, @Libreba, @Libregr,@Otros,@Sellosc,@Servtra,@EmbId,@Usrmod,@Fchmod,@Estadoid

	END 

	--Cerrar cursor
	CLOSE CursorTipos3
	DEALLOCATE CursorTipos3

	declare @Eprot decimal(19,3),
	        @Ehum decimal(19,3),
			@Ephl decimal(19,3),
			@Eimp decimal(19,3),
			@Rprot decimal(19,3),
			@Rhum decimal(19,3),
			@Rphl decimal(19,3),
			@Rimp decimal(19,3),
			@Oblab varchar(1000),
			@Lab bit


--Declaración del cursor
	DECLARE CursorTipos4 CURSOR
	FOR
		--Consulta de entrada
		select e4.Eprot, e4.Ehum, e4.Ephl, e4.Eimp, e4.Rprot, e4.Rhum, e4.Rphl, e4.Rimp, e4.Oblab,e4.EmbId,e4.Usrmod,e4.Fchmod,e4.Lab, et.EstadoId
		from sEmb4 e4 inner join @Embtemp et
			on e4.EmbId = et.EmbId
		
		
	OPEN CursorTipos4
	FETCH CursorTipos4 INTO @Eprot,@Ehum,@Ephl,@Eimp,@Rprot,@Rhum,@Rphl,@Rimp,@Oblab,@EmbId,@Usrmod,@Fchmod,@Lab,@Estadoid
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva
	
		if @Nuevoest <> @Estadoid and @Estadoid <> 'L'
			exec[PA_sEmb4] 3, @Eprot,@Ehum,@Ephl,@Eimp,@Rprot,@Rhum,@Rphl,@Rimp,@Oblab,@EmbId,@Usrmod,@Fchmod,@Lab
		
		FETCH CursorTipos4 INTO @Eprot,@Ehum,@Ephl,@Eimp,@Rprot,@Rhum,@Rphl,@Rimp,@Oblab,@EmbId,@Usrmod,@Fchmod,@Lab,@Estadoid

	END 

	--Cerrar cursor
	CLOSE CursorTipos4
	DEALLOCATE CursorTipos4

GO
/****** Object:  StoredProcedure [dbo].[PA_Ordactestado]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Ordactestado](
	@Ordenid varchar (10),
	@Estadoid char
	)

as


	--Declaración de variables de entrada
	declare @Ctrtoid varchar (30),
	@Loteid varchar (10),
	@Origenid varchar (10),
	@Tnladas decimal (19,3),
	@Tlrancia varchar (30),
	@Peremb varchar (30),
	@Incoterm varchar (50),
	@Ritmo varchar (50),
	@Moneda varchar (10),
	@Refftro varchar (30),
	@Base decimal (19,4),
	@Mesfutu decimal (19,4),
	@Prcionto decimal (19,4),
	@Obsrv varchar (2000),
	@Laycan varchar (30),
	@Ptocarga varchar (50),
	@Ptodscg varchar (50),
	@Norcg varchar (20),
	@Nordscg varchar (20),
	@Laytime varchar (30),
	@Condpgo varchar (200),
	@Tasadmra varchar (20),
	@Usrmod varchar (10),
	@Usrcrea varchar (10),
	@Fchcrea datetime,
	@Fchmod datetime,
	@Provid varchar (10),
	@Fchord date,
	@Rspnsble varchar (50),
	@Nuevoest char,
	@Ritmod varchar (50)
	
	set @Nuevoest = @Estadoid
		
	
	
	--Declaración del cursor
	DECLARE CursorTipos CURSOR
	FOR
		--Consulta de entrada
		select rd.OrdenId, rd.CtrtoId, rd.LoteId, rd.OrigenId, og.Nombre Nmborigen, rd.Tnladas, rd.Tlrancia,
		rd.Peremb, rd.Incoterm, rd.Ritmo, rd.Moneda, rd.Refftro, rd.Base, rd.Mesfutu, rd.Prcionto,
		rd.Obsrv, rd.Laycan, rd.Ptocarga, rd.Ptodscg, rd.Norcg, rd.Nordscg, rd.Laytime, rd.Condpgo,
		rd.Tasadmra, rd.Usrmod, rd.Usrcrea, rd.Fchcrea, rd.Fchmod, rd.EstadoId, rd.ProvId, pr.Nombre Nmbprvfl,
		rd.Fchord, rd.Rspnsble,rd.Ritmod
		from sOrdenes rd inner join sOrigen og
			on rd.OrigenId = og.OrigenId
		left outer join sProveed pr
			on rd.ProvId = pr.ProvId
		where OrdenId=@Ordenid
		
	OPEN CursorTipos
	FETCH CursorTipos INTO @ordenid,@Ctrtoid, @Loteid,@Origenid, @Tnladas,@Tlrancia,@Peremb, @Incoterm,@Ritmo,@Moneda,@Refftro,@Base,
			@Mesfutu, @Prcionto, @Obsrv, @Laycan,@Ptocarga, @Ptodscg, @Norcg,@Nordscg,@Laytime,@Condpgo,@Tasadmra,@Usrmod,@Fchmod,
			@Estadoid, @Provid, @Fchord,@Rspnsble,@Ritmod

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva
		 
		 if @Nuevoest <> @Estadoid and @Estadoid <> 'L'

		exec[PA_sOrdenes] 3,@ordenid,@Ctrtoid, @Loteid,@Origenid, @Tnladas,@Tlrancia,@Peremb, @Incoterm,@Ritmo,@Moneda,@Refftro,@Base,
			@Mesfutu, @Prcionto, @Obsrv, @Laycan,@Ptocarga, @Ptodscg, @Norcg,@Nordscg,@Laytime,@Condpgo,@Tasadmra,@Usrmod,@Fchmod,
			@Estadoid, @Provid, @Fchord,@Rspnsble,@Ritmod
		
		FETCH CursorTipos INTO @ordenid,@Ctrtoid, @Loteid,@Origenid, @Tnladas,@Tlrancia,@Peremb, @Incoterm,@Ritmo,@Moneda,@Refftro,@Base,
			@Mesfutu, @Prcionto, @Obsrv, @Laycan,@Ptocarga, @Ptodscg, @Norcg,@Nordscg,@Laytime,@Condpgo,@Tasadmra,@Usrmod,@Fchmod,
			@Estadoid, @Provid, @Fchord,@Rspnsble, @Ritmod
	END 

	--Cerrar cursor
	CLOSE CursorTipos
	DEALLOCATE CursorTipos

GO
/****** Object:  StoredProcedure [dbo].[PA_Rajve]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rajve](
			@OrdenId varchar (30)
)
as

	select og.Nombre as 'Origen', pr.Nombre as 'Proveedor', tr.Nombre as 'Trigo', od.OrdenId as 'No. Orden', 
	lo.Grado, lo.Proteina as 'Proteina', od.Tnladas as 'T.M. Facturadas', isnull(ve.Venta, 0) as 'T.M. Vendidas',
	isnull (aju.compensa, 0) as 'Ajustes', od.Tnladas- isnull (e1.PesoRecibido, 0) as 'T.M. Disponibles',
	od.Tnladas - isnull (ve.Venta, 0) +isnull(aju.compensa,0)+(isnull(aju.m1,0) +isnull(aju.m2,0) +isnull(aju.m3,0))-isnull(e1.PesoRecibido, 0) [Disponible por recibir],
	(od.Tnladas+ isnull (aju.compensa, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0)) - isnull(e1.PesoEmbarcado,0) [Disponible por enviar]
	from sLotes lo inner join sOrdenes od
			on lo.LoteId=od.LoteId
	inner join sProveed pr
			on pr.ProvId = lo.ProvId 
	inner join sTrigos tr
			on tr.TrigoId = lo.TrigoId 
	inner join sOrigen og
			on og.OrigenId = od.OrigenId 

	left outer join (select em1.OrdenId, sum(em1.PesoEmb) PesoEmbarcado, sum(em1.PesoRe) PesoRecibido
					from sEmb1 em1
					where em1.EstadoId <> 'L'
					group by em1.OrdenId
					) e1
		on od.OrdenId = e1.OrdenId
	left outer join (select ven.OrdenId, sum(ven.TonVenta) Venta
				from sVentas ven
				where ven.EstadoId <> 'L'
				group by ven.OrdenId
				) ve
		on od.OrdenId = ve.OrdenId
	left outer join (select aj.OrdenId, sum(aj.compensa) compensa, sum(aj.merma1) m1, sum(aj.merma2) m2, sum(aj.merma3) m3
					from sAjustes aj
					where aj.EstadoId <> 'L'
					group by aj.Ordenid) aju
		on od.OrdenId = aju.OrdenId
	where od.OrdenId like '%'+@OrdenId+'%' 
	AND lo.EstadoId <> 'L'
	AND od.EstadoId <> 'L'
	and (isnull (aju.compensa, 0) <> 0 or isnull (ve.Venta, 0) > 0)
	group by  od.OrdenId, og.Nombre, pr.Nombre, tr.Nombre, lo.Grado, lo.Proteina, ve.Venta, aju.compensa ,  od.Tnladas, e1.PesoRecibido, aju.m1, aju.m2, aju.m3, e1.PesoEmbarcado
	order by od.OrdenId

--, sEmb1 e1, sDestino de, sTrigos
--select  * from sOprador;
--select  * from sOrigen;
--select  * from sEmb1;
-- select TOP 100 * from sLotes;
--select * from sTrigos
--select  *from sOrdenes;
--select  * from sEmb1 order by 2
--select * from sProveed
--select TOP 10 * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select * from sVentas order by 3
--select * from sAjustes order by 2

GO
/****** Object:  StoredProcedure [dbo].[PA_Rcontratocv]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Rcontratocv](
	@ordenid varchar(10)
)
as

--Reporte de contrato de Compra venta
select  od.ordenid [Orden], od.CtrtoId [Contrato], od.loteid [Lote], pv.Providan [Nombre proveedor], pv.Nombre, pv.Calle Direccion,
	tr.Nombre Trigo, lo.Proteina, lo.Humedad,lo.Pesohtl [Peso por Hectolitro], lo.Impureza, lo.Vomitoxn Vomitoxina,lo.Ergot,
	lo.Fllngnum [Fallin Number], lo.Dockage, lo.Otros, lo .Obsrv Observaciones, od.Tnladas Toneladas, od.Tlrancia Tolerancia,
	 od.Peremb [Periodo Embarque], od.ritmo [Ritmo de embarque], od.Obsrv [Observaciones], od.Base [Precio Base], od.Mesfutu [Precio Futuro],
	od.Refftro [Referencia Futuro], od.prcionto [Precio Neto], od.Moneda, od.Condpgo [Condiciones],'' Fecha, 
	od.rspnsble Compreador, pv.Cntcto Vendedor 
from sOrdenes od inner join sLotes lo
		on lo.loteid=od.loteid
	inner join sProveed pv
		on pv.ProvId=lo.ProvId
	inner join sTrigos tr
		on tr.TrigoId=lo.TrigoId
where od.OrdenId=@ordenid

GO
/****** Object:  StoredProcedure [dbo].[PA_Rembpend1]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rembpend1](
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
--, sEmb1 e1, sDestino de, sTrigos

--select  * from sEmb1;
--select TOP 100 * from sLotes;
--select  *from sOrdenes;
--select * from sProveed
--select TOP 10 * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select TOP 10 * from sLotes

GO
/****** Object:  StoredProcedure [dbo].[PA_Rembpend2]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rembpend2](
			@DstinoId varchar (30)
)
as

	select e1.Noselloe as 'No. Sello Emb.', od.OrdenId, e1.EmbId as 'No. Embarque', e1.Reftrans as 'Ref. Transporte',
		e1.Fchemb as 'Fecha Embarque', e1.Pesoemb as 'Peso Embarque', lo.LoteId, pr.Nombre Proveedor,
	og.Nombre Origen, tr.Nombre Trigo, lo.Grado, lo.Proteina, de.Nombre Destino
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
	where e1.DstinoId = @DstinoId
	AND e1.EstadoId <> 'L' 
	and lo.EstadoId <> 'L'
	and od.EstadoId <> 'L'
	and e1.Silo is null
	
--, sEmb1 e1, sDestino de, sTrigos

--select TOP 100 *  from sEmb1 where DstinoId = 'DE0005';
--select TOP 100 * from sLotes;
--select  *from sOrdenes;
--select * from sProveed
--select * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select TOP 10 * from sLotes

GO
/****** Object:  StoredProcedure [dbo].[PA_Rembsin4]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rembsin4](
			@OrdenId1 varchar (30),
			@OrdenId2 varchar (30),
			@ProvId varchar (30),
			@TrigoId varchar (30)
)
as



	select lo.LoteId NUMLOTE,tr.Nombre TRIGO,lo.Proteina PROTEINA,lo.Grado GRADO,og.Nombre ORIGEN,od.OrdenId ORDENID,
	od.CtrtoId NUMCONTRATO,pr.Nombre PROVEEDOR,de.Nombre DESTINO,e1.EmbId NOEMBARQUE, e1.Reftrans REFTRASPPORTE,
	e1.Fchrec FECHARECEPCION,e1.Pesoemb PESOEMBARQUE
	from sTrigos tr inner join  sLotes lo 
		on tr.TrigoId=lo.TrigoId 
	inner join sOrdenes od 
		on lo.LoteId=od.LoteId 
	inner join sOrigen og
		on og.OrigenId = od.OrigenId
	inner join sEmb1 e1
		on od.OrdenId=e1.OrdenId
	inner join sEmb4 e4
		on e1.EmbId = e4.EmbId
	inner join sDestino de 
		on e1.DstinoId=de.DstinoId
	inner join sProveed pr
		on lo.ProvId=pr.ProvId
	where od.OrdenId between @OrdenId1 and @OrdenId2 
	and lo.ProvId like '%'+ @ProvId + '%' 
	and lo.TrigoId like '%'+ @TrigoId + '%'
	and e4.Lab = 0
	AND e1.EstadoId <> 'L' 
	and lo.EstadoId <> 'L'
	and od.EstadoId <> 'L'
	and e1.Silo is not null	
	order by de.DstinoId

GO
/****** Object:  StoredProcedure [dbo].[PA_Rinprtrg]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rinprtrg](
			@OrdenId1 varchar (30),
			@OrdenId2 varchar (30),
			@DstinoId varchar (30),
			@Fchemb1 date,
			@Fchemb2 date
)
as

		select e1.EmbId, od.OrdenId as 'No. Orden', e1.Fchemb as 'Fecha Embarque', e1.Fchrec as 'Fecha Recepción',
				e1.Reftrans as 'Ref. Transporte', de.DstinoId, de.Nombre as 'Destino', e2.Olor, e2.Color, e2.Danado, e2.Plagas, e2.Otros,
				ec.CantOrdenes
		from sEmb1 e1 inner join sOrdenes od
				on e1.OrdenId = od.OrdenId
		inner join sEmb2 e2
				on e2.EmbId = e1.EmbId
		inner join sDestino de
				on de.DstinoId = e1.DstinoId
		inner join (select e1.OrdenId, count (OrdenId) CantOrdenes
					from sEmb1 e1
					where e1.OrdenId between @OrdenId1 and @OrdenId2
					AND e1.Fchrec between @Fchemb1 and @Fchemb2
					--AND od.Fchcrea between @Fchemb1 and @Fchemb2
					AND e1.DstinoId like '%' + @DstinoId+'%'
					AND e1.EstadoId <> 'L'
					group by e1.OrdenId) ec
			on e1.OrdenId = ec.OrdenId
		where od.OrdenId between @OrdenId1 and @OrdenId2
		AND e1.Fchrec between  @Fchemb1 and @Fchemb2
		--AND od.Fchcrea between  @Fchemb1 and @Fchemb2
		AND de.DstinoId like '%'+@DstinoId+'%'
		AND  e2.Condlimp =1
		AND e1.EstadoId <> 'L'
		AND od.EstadoId <> 'L'




--, sEmb1 e1, sDestino de, sTrigos
--select  * from sOprador;
--select  * from sOrigen;
--select  * from sEmb2;
--select TOP 100 * from sLotes;
--select * from sTrigos
--select  *from sOrdenes;
--select * from sProveed
--select TOP 10 * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select TOP 10 * from sVentas

GO
/****** Object:  StoredProcedure [dbo].[PA_Rinstrsp]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rinstrsp](
			@OrdenId1 varchar (30),
			@OrdenId2 varchar (30),
			@Provflet varchar (30),
			@Fchemb1 date,
			@Fchemb2 date


)
as


	select  pr.Nombre Flete,e1.EmbId NoEmbarque,e1.OrdenId NoOrden,e1.Fchemb FechaEmbarque,e1.Fchrec FechaRecepcion,
		e1.Reftrans RefTrasporte,e3.Libreba,e3.Libregr,e3.Otros,e3.Sellosc,e3.Servtra, ec.CantEmbarques
	from sProveed pr 
	inner join  sEmb1 e1 
		on pr.ProvId=e1.Provflet 
	inner join sEmb3 e3 
		on e3.EmbId=e1.EmbId
	inner join (select e1.Provflet, count (Provflet) CantEmbarques
				from sEmb1 e1
				where e1.Fchrec between @Fchemb1 and @Fchemb2
				and e1.OrdenId  between @OrdenId1  and @OrdenId2  
				and e1.Provflet = @Provflet
				and e1.EstadoId <> 'L'
				group by Provflet) ec
		on e1.Provflet = ec.Provflet
	where e1.Fchrec between @Fchemb1 and @Fchemb2
	and e1.OrdenId  between @OrdenId1  and @OrdenId2  
	and e1.Provflet = @Provflet
	and e3.Condtra= 1
	and e1.EstadoId <> 'L'

GO
/****** Object:  StoredProcedure [dbo].[PA_Rlabprov]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rlabprov](
			@LoteId1 varchar(30),
			@LoteId2 varchar(30),
			@OrdenId1 varchar (30),
			@OrdenId2 varchar (30),
			@ProvId varchar (30),
			@TrigoId varchar (30),
			@DstinoId varchar (30),
			@Fchemb1 date,
			@Fchemb2 date,
			@Solores bit
)
as
	declare @Emb table(OrdenId varchar(40), Proveedor varchar(50),Lote varchar(50),Origen varchar(50),Destino varchar(50),Trigo varchar(50),
						Grado int, Noembarque varchar(50),RefTransporte varchar(50),FechaRecepcion varchar(50),
						PesoRecibido decimal (10,3), Ehum decimal (10,2),Epes decimal (10,2),Eimp decimal (10,2),
						Epro decimal (10,2), Chum decimal (10,2), Cpes decimal (10,2),Cimp decimal (10,2),Cpro decimal (10,2));
	insert into @Emb (OrdenId, Proveedor, Lote, Origen, Destino, Trigo, Grado, Noembarque, RefTransporte, FechaRecepcion, PesoRecibido, 
					Ehum, Epes, Eimp, Epro, Chum, Cpes, Cimp, Cpro)

	select  od.OrdenId, pr.Nombre as 'Proveedor', lo.LoteId as 'Lote', og.Nombre as 'Origen', de.Nombre as 'Destino',tr.Nombre as 'Trigo',
	lo.Grado, e1.EmbId as 'No. Embarque',
	e1.Reftrans as 'Ref. Transporte', e1.Fchrec as 'Fecha Recepción', e1.Pesore as 'Peso Recibido',
	e4.Rhum as 'Humedad', e4.Rphl as 'Peso HL', e4.Rimp as 'Impurezas', e4.Rprot as 'Proteina', lo.Humedad, lo.Pesohtl, lo.Impureza, lo.Proteina
	from sLotes lo inner join sOrdenes od
			on lo.LoteId=od.LoteId 
	inner join sEmb1 e1
			on od.OrdenId = e1.OrdenId 
	inner join sDestino de
			on e1.DstinoId = de.DstinoId
	inner join sEmb4 e4
			on e4.EmbId = e1.EmbId 
	inner join sOrigen og
			on og.OrigenId = od.OrigenId
	inner join sTrigos tr
			on tr.TrigoId = lo.TrigoId 
	inner join sProveed pr
			on pr.ProvId = lo.ProvId 
	where lo.LoteId between @LoteId1 and @LoteId2
	AND od.OrdenId between @OrdenId1 and @OrdenId2
	AND lo.ProvId like '%'+@ProvId+'%' 
	AND lo.TrigoId like '%'+@TrigoId+'%' 			
	AND e1.DstinoId like '%'+@DstinoId+'%' 
	AND e1.Fchrec between @Fchemb1 and @Fchemb2
	AND lo.EstadoId <> 'L'
	AND e1.EstadoId <> 'L'
	AND od.EstadoId <> 'L'
	and e4.Lab = 1;
	



	select OrdenId, Proveedor, Lote, Origen, Destino, Trigo, Grado, Noembarque, RefTransporte, FechaRecepcion, PesoRecibido, 
					Ehum, Epes, Eimp, Epro, Chum, Cpes, Cimp, Cpro
	from @Emb
	Order By OrdenId

GO
/****** Object:  StoredProcedure [dbo].[PA_Roperador]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Roperador](
			@OprdorId varchar (30),
			@Silo varchar (30),
			@Fchrec1 date,
			@Fchrec2 date
)
as

	select op.Nombre as 'Operador', pr.Nombre as 'Proveedor', e1.Reftrans as 'Ref. Transporte', e1.Fchrec as 'Fecha Recepción', og.Nombre as 'Origen', 
			od.OrdenId as 'No. Orden', tr.Nombre as 'Trigo', lo.Grado, lo.Proteina as 'Proteina', lo.Humedad as 'Humedad', 
			e1.Pesoemb as 'T.M. Embarcadas', e1.Pesore as 'T.M. Recibidas'
	from sLotes lo inner join sOrdenes od
			on lo.LoteId=od.LoteId 
	inner join sEmb1 e1
			on od.OrdenId = e1.OrdenId
	inner join sTrigos tr
			on tr.TrigoId = lo.TrigoId 
	inner join sOrigen og
			on og.OrigenId = od.OrigenId 
	inner join sOprador op
			on op.OprdorId = e1.OprdorId
	inner join sProveed pr
			on pr.ProvId = lo.ProvId
	where e1.OprdorId like '%'+@OprdorId+'%'
	AND e1.Silo like '%'+@Silo+'%'
	AND e1.Fchrec between  @Fchrec1 and @Fchrec2
	AND e1.EstadoId <> 'L'
	and lo.EstadoId <> 'L'
	AND od.EstadoId <> 'L'
	order by op.nombre, od.ordenId
	


--, sEmb1 e1, sDestino de, sTrigos
--select  * from sOprador;
--select  * from sOrigen;
--select  * from sEmb1;
--select TOP 100 * from sLotes;
--select * from sTrigos
--select  *from sOrdenes;
--select * from sProveed
--select TOP 10 * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select TOP 10 * from sVentas

GO
/****** Object:  StoredProcedure [dbo].[PA_Rprvflt]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Rprvflt](
			@OrdenId1 varchar (30),
			@OrdenId2 varchar (30),
			@Fchemb1 date,
			@Fchemb2 date,
			@ProvId varchar (30)
)
as

	select  e1.EmbId as 'No. Embarque', e1.Reftrans as 'Ref. Transporte',e1.Factfl as 'Factura Flete',e1.Fchemb as 'Fecha Embarque',
			e1.Fchrec as 'Fecha Recepcion', e1.Pesoemb as 'Peso Embarque',e1.Pesore as 'Peso Recibido',
			e1.Pesore-e1.Pesoemb as 'Diferencia',tr.nombre Trigo, lo.proteina Proteina,lo.humedad Humedad,lo.Grado Grado,og.Nombre Origen,de.Nombre as 'Destino',od.OrdenId as 'No. Orden',
			lo.loteid, pv.Nombre Proveedor
	from sLotes lo inner join sOrdenes od
			on lo.LoteId=od.LoteId 
	inner join sEmb1 e1
			on od.OrdenId = e1.OrdenId 
	inner join sTrigos tr
			on tr.trigoid=lo.trigoid
	inner join sDestino de
			on e1.DstinoId = de.DstinoId
	inner join sOrigen og
			on og.origenid = od.OrigenId
	inner join sProveed pv
			on pv.ProvId= e1.Provflet
	where   e1.Provflet like '%'+@ProvId+'%' 
			and e1.fchemb between @fchemb1 and @Fchemb2
			and e1.OrdenId between @OrdenId1 and @OrdenId2 
			--AND e1.DstinoId like '%'+@DstinoId+'%' 
			--AND e1.fchemb between @Fchemb1 and @Fchemb2
			--AND lo.ProvId like '%'+@ProvId+'%' 
			--AND lo.TrigoId like '%'+@TrigoId+'%'
			and lo.EstadoId <> 'L'
			and e1.EstadoId <> 'L'
			and od.EstadoId <> 'L'
	--order by od.OrdenId

GO
/****** Object:  StoredProcedure [dbo].[PA_Rsilo]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rsilo](
			@Silo varchar (30),
			@TrigoId varchar (30),
			@Fchrec1 date,
			@Fchrec2 date
)
as

	select e1.Silo, op.Nombre as 'Operador', pr.Nombre as 'Proveedor', e1.Reftrans as 'Ref. Transporte', e1.Fchrec as 'Fecha Recepción', og.Nombre as 'Origen', 
			od.OrdenId as 'No. Orden', tr.Nombre as 'Trigo', lo.Grado, lo.Proteina as 'Proteina', lo.Humedad as 'Humedad', 
			e1.Pesoemb as 'T.M. Embarcadas', e1.Pesore as 'T.M. Recibidas'
	from sLotes lo inner join sOrdenes od
			on lo.LoteId=od.LoteId 
	inner join sEmb1 e1
			on od.OrdenId = e1.OrdenId
	inner join sTrigos tr
			on tr.TrigoId = lo.TrigoId 
	inner join sOrigen og
			on og.OrigenId = od.OrigenId 
	inner join sOprador op
			on op.OprdorId = e1.OprdorId
	inner join sProveed pr
			on pr.ProvId = lo.ProvId
	where e1.Silo like '%' + replace (@Silo, '*', '%')+ '%'
	and lo.TrigoId like '%' + @TrigoId + '%'
	AND e1.Fchrec between  @Fchrec1 and @Fchrec2
	AND e1.EstadoId <> 'L'
	and lo.EstadoId <> 'L'
	AND od.EstadoId <> 'L'
	order by op.nombre, od.ordenId
	


--, sEmb1 e1, sDestino de, sTrigos
--select  * from sOprador;
--select  * from sOrigen;
--select  * from sEmb1;
--select TOP 100 * from sLotes;
--select * from sTrigos
--select  *from sOrdenes;
--select * from sProveed
--select TOP 10 * from sDestino
--select TOP 10 * from h_Destino
--select * from sTrigos
--select TOP 10 * from sVentas

--USE [TNLTRG]
--GO
--CREATE NONCLUSTERED INDEX IX_Rsilo
--ON dbo.sEmb1 (Fchrec,Silo,EstadoId)
--INCLUDE (OrdenId,Reftrans,Pesoemb,Pesore,OprdorId)
--GO

GO
/****** Object:  StoredProcedure [dbo].[PA_Rtrigoemb]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure[dbo].[PA_Rtrigoemb](
@LoteId varchar(30),
@OrdenId1 varchar (30),
@OrdenId2 varchar (30),
@OrigenId varchar (30),
@DstinoId varchar (30),
@TrigoId varchar (30),
@ProvId varchar (30),--sLotes
@Fchemb1 date,
@Fchemb2 date
)
as

declare @Porcentaje decimal (2,2);
select lo.Grado, lo.LoteId, od.OrdenId, od.OrigenId, og.Nombre as'Origen', e1.DstinoId, de.Nombre as 'Destino', e1.EmbId as 'No. Embarque',
e1.Reftrans as 'Ref. Transporte', lo.ProvId, pr.Nombre as 'Embarcador',od.CtrtoId as 'No.Contrato', e1.Fchemb as 'Fecha Embarque', 
lo.TrigoId, tr.Nombre as 'Trigo', lo.Proteina, e1.Fchrec as 'Fecha Recepción', e1.Pesoemb as 'Peso Embarque', case when e1.silo is null then 0 else e1.Pesore end  'Peso Recepción', 
e1.Pesore-e1.Pesoemb  as 'Diferencia', 
case when e1.Pesore-e1.Pesoemb>0 then
0
else
case when e1.Pesoemb*e1.Pesore = 0 then
1
else
(abs(e1.Pesore - e1.Pesoemb)/e1.Pesoemb) * 100
end
end as 'por', round (case when e1.Pesore-e1.Pesoemb>0 then
1
else
(e1.Pesore/case when e1.Pesoemb = 0 then
1
else
e1.Pesoemb
end)
end * 100, 2) Porc
--convert(varchar(10),convert(decimal(10,2),round(100/e1.Pesoemb*e1.Pesore,2))) +' %'as'Porcentaje'
from sLotes lo inner join sOrdenes od
on lo.LoteId=od.LoteId 
inner join sEmb1 e1
on od.OrdenId = e1.OrdenId 
inner join sDestino de
on e1.DstinoId = de.DstinoId
inner join sProveed pr
on pr.ProvId = lo.ProvId
inner join sOrigen og
on og.OrigenId = od.OrigenId
inner join sTrigos tr
on tr.TrigoId = lo.TrigoId
where lo.LoteId like '%'+@LoteId+'%'
AND od.OrdenId between @OrdenId1 and @OrdenId2
AND od.OrigenId like '%'+@OrigenId+'%'
AND e1.DstinoId like '%'+@DstinoId+'%' 
AND lo.TrigoId like '%'+@TrigoId+'%'
AND lo.ProvId like '%'+@ProvId+'%' 
AND e1.Fchemb between @Fchemb1 and @Fchemb2
AND lo.EstadoId <> 'L'
AND e1.EstadoId <> 'L'
AND od.EstadoId <> 'L';

--select TOP 10 * from sEmb1;
--select TOP 100 * from sLotes
--select * from sProveed
--select  *from sOrdenes;
GO
/****** Object:  StoredProcedure [dbo].[PA_Rtrigos]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Rtrigos]
(
	@Ordenid varchar (10),
	@Loteid varchar (20),
	@fchini date,
	@fchfin date,
	@Cerradas bit

)


as

	declare @cant decimal (19, 3)

	select @cant = case when @Cerradas = 1 then
						0
					else
						0.003
					end



	--pr.nombre nombre de proveedor
	select lo.LoteId, od.OrdenId, od.ctrtoid Contrato, od.Tnladas Toneladas, isnull (ve.Venta, 0) TM_Venta, isnull (aju.compensa, 0) Compen,
	isnull (aju.m1, 0) Merma1, isnull (aju.m2, 0) Merma2, isnull (aju.m3, 0) Merma3,
	isnull(aju.compensa, 0) + isnull(aju.m1, 0) + isnull(aju.m2, 0) + isnull(aju.m3, 0) Ajustes,
	od.Tnladas - isnull (ve.Venta, 0) + isnull (aju.compensa, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0) T_M_Disponibles,
	isnull(e1.PesoEmbarcado,0) T_M_Embarcadas, isnull(e1.PesoRecibido,0) T_M_Recibidas,
	(od.Tnladas - isnull (ve.Venta, 0) + isnull (aju.compensa, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0))-isnull(e1.PesoEmbarcado,0)	[Disponible por enviar],
	isnull (e1.PesoEmbarcado, 0) - isnull(e1.PesoRecibido, 0) [Embarcado por recibir],
	((od.Tnladas - isnull (ve.Venta, 0) + isnull (aju.compensa, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0))-isnull(e1.PesoEmbarcado,0)) + (isnull (e1.PesoEmbarcado, 0) - isnull(e1.PesoRecibido, 0)) [Disponible por recibir],
	--od.Tnladas - isnull (ve.Venta, 0) +isnull(aju.compensa,0)+(isnull(aju.m1,0) +isnull(aju.m2,0) +isnull(aju.m3,0))-isnull(e1.PesoRecibido, 0) [Disponible por recibir],
	pr.nombre [Nombre Proveedor], tr.nombre Trigo, lo.Proteina Proteina, lo.Grado Grado, og.Nombre  Origen,
	ROUND(case when od.Tnladas = 0 then 0
			--isnull( ((aju.compensa - isnull (ve.Venta, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0) - isnull (e1.PesoEmbarcado, 0)) + (isnull (e1.PesoEmbarcado, 0) - isnull(e1.PesoRecibido, 0)))/aju.compensa,0)
	 
			ELSE
				((od.Tnladas - isnull (ve.Venta, 0) + isnull (aju.compensa, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0) - isnull (e1.PesoEmbarcado, 0)) + (isnull (e1.PesoEmbarcado, 0) - isnull(e1.PesoRecibido, 0)))/od.Tnladas
			end, 3) PorcDif
	--Ajustar los campos que le suceden: ...
	--lo.loteid [No de Lote]--, pr.nombre [Nombre Proveedor], tr.nombre Trigo, lo.Proteina Proteina, lo.Grado Grado, og.Nombre  Origen
	from sLotes lo inner join sOrdenes od
		on lo.LoteId = od.LoteId
	inner join sProveed pr
		on lo.ProvId = pr.ProvId
	inner join sTrigos tr
		on lo.trigoid=tr.trigoid
	inner join sOrigen og
		on og.origenid=od.origenid
	left outer join (select em1.OrdenId, sum(em1.PesoEmb) PesoEmbarcado,
					sum(case when em1.Silo is not null then
							em1.PesoRe
						else
							0
						end) PesoRecibido
					from sEmb1 em1
					where em1.Fchemb between @fchini and @fchfin and em1.EstadoId <> 'L'
					group by em1.OrdenId
					) e1
		on od.OrdenId = e1.OrdenId
	left outer join (select ven.OrdenId, sum(ven.TonVenta) Venta
				from sVentas ven
				where  ven.Fchventa between @fchini and @fchfin and ven.EstadoId <> 'L'
				group by ven.OrdenId
				) ve
		on od.OrdenId = ve.OrdenId
	left outer join (select aj.OrdenId, sum(aj.compensa) compensa, sum(aj.merma1) m1, sum(aj.merma2) m2, sum(aj.merma3) m3
					from sAjustes aj
					where  aj.Fchajus between @fchini and @fchfin and aj.EstadoId <> 'L'
					group by aj.Ordenid) aju
		on od.OrdenId = aju.OrdenId
	where od.ordenId like '%'+@ordenid+'%'
	and lo.loteId like '%'+@Loteid+'%'
	and lo.EstadoId <> 'L'
	and od.EstadoId <> 'L'
	and ROUND( case when od.Tnladas = 0  then 
		(((od.Tnladas + isnull (aju.compensa, 0))-od.Tnladas - isnull (ve.Venta, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0) - isnull (e1.PesoEmbarcado, 0)) + (isnull (e1.PesoEmbarcado, 0) - isnull(e1.PesoRecibido, 0)))/ isnull (case when aju.compensa =0 then 1 else aju.compensa end,1)		
			ELSE
				((od.Tnladas - isnull (ve.Venta, 0) + isnull (aju.compensa, 0) +isnull (aju.m1, 0) + isnull (aju.m2, 0) + isnull (aju.m3, 0) - isnull (e1.PesoEmbarcado, 0)) + (isnull (e1.PesoEmbarcado, 0) - isnull(e1.PesoRecibido, 0)))/od.Tnladas
			end,3)  > =   @cant
			
order by od.ordenId , lo.loteid

GO
/****** Object:  StoredProcedure [dbo].[PA_Rtrigrec]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Rtrigrec] (
	@fch1 date,
	@fch2 date,
	@LoteId varchar(10),
	@OrdenId varchar(10),
	@TrigoId varchar (10),
	@DstinoId varchar (10),
	@Solores bit,
	@Aorden bit,
	@Atrigo bit,
	@Adstino bit
	)

as


	select lo.LoteId, od.OrdenId, od.CtrtoId Contrato,e1.Fchrec Fecha_Recepcion, e1.Fchemb Fch_Embarque, e1.EmbId embarque, de.nombre Destino, e1.Reftrans Referencia_trans, 
	e1.Pesoemb as  Peso_embarcado, 
	e1.Pesore as  Peso_recibido,
	

	e1.Pesore-e1.Pesoemb Diferencia,
	(( e1.Pesore-e1.Pesoemb)*100)/case when e1.pesore = 0 then
										1
									else
										e1.pesore
									end Procentaje,
	e1.Silo, pv.Nombre Proveedor,tr.Nombre Trigo,og.nombre Origen, lo.Grado, lo.Proteina--, sum(isnull(e1.Pesoemb,0)) Sum_pesoEmb 
	from semb1 e1 inner join sDestino de
		on de.DstinoId=e1.DstinoId  
	inner join sOrdenes od 
		on e1.OrdenId=od.ordenid 
	inner join sLotes lo
		on lo.LoteId=od.LoteId
	inner join sProveed pv
		on lo.provid=pv.ProvId
	inner join strigos tr
		on tr.TrigoId=lo.TrigoId
	inner join sOrigen og
		on og.origenid=od.OrigenId
	--where e1.Fchemb between @fch1 and @fch2
	where e1.Fchrec between @fch1 and @fch2
	and lo.loteId like '%' + @LoteId + '%'
	and od.ordenid like '%' + @OrdenId + '%'
	and tr.TrigoId like '%' + @TrigoId + '%'
	and e1.DstinoId like '%' + @DstinoId + '%'
	and lo.EstadoId <> 'L'
	and od.EstadoId <> 'L'
	and e1.EstadoId <> 'L'
	and e1.silo is not null
--group by od.OrdenId
order by e1.Fchrec




--select @loteid Lote
--select * from semb1 e1
--select * from sDestino
--select * from strigos
--select * from slotes

GO
/****** Object:  StoredProcedure [dbo].[PA_Rvistaimp]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Rvistaimp](
	@doc smallint,
	@instid varchar(10),
	@docid varchar(10)
)
as
 


--Consulta sLotes
 if @doc=1
	begin

	if @instid != '' 
		begin
			select lo.Fchlote, lo.Fchmod,lo.LoteId, lo.ProvId,
			pr.Nombre Proveedor, lo.TrigoId, tr.Nombre Trigo, lo.Proteina, lo.Grado, lo.Humedad,
			lo.Pesohtl, lo.Impureza,
			lo.Dockage, lo.Vomitoxn, lo.Ergot, lo.Fllngnum, lo.Obsrv, lo.Otros, lo.EstadoId
			from sLotesh lo inner join sProveed pr
				on lo.ProvId = pr.ProvId
			inner join sTrigos tr
				on lo.TrigoId = tr.TrigoId
			where LoteId=@docid and lo.instid=@instid	
		end
	else
			exec [PA_sLotes]4,@docid,null,null,null,null,null,null,null,null,null,null,null,null,
					null,null,null,null,null,null,null
	end



 --Consulta sOrdenes
 if @doc=2
	begin
		if @instid != ''
			begin
				select rd.OrdenId, rd.CtrtoId, rd.LoteId, rd.OrigenId, og.Nombre Nmborigen, rd.Tnladas, rd.Tlrancia,
				rd.Peremb, rd.Incoterm, rd.Ritmo, rd.Moneda, rd.Refftro, rd.Base, rd.Mesfutu, rd.Prcionto,
				rd.Obsrv, rd.Laycan, rd.Ptocarga, rd.Ptodscg, rd.Norcg, rd.Nordscg, rd.Laytime, rd.Condpgo,
				rd.Tasadmra, rd.Usrmod, rd.Usrcrea, rd.Fchcrea, rd.Fchmod, rd.EstadoId, rd.ProvId, pr.Nombre Nmbprvfl,
				rd.Fchord, rd.Rspnsble,rd.Ritmod
				from sOrdenesh rd inner join sOrigen og
					on rd.OrigenId = og.OrigenId
				left outer join sProveed pr
					on rd.ProvId = pr.ProvId
				where OrdenId=@docid and @instid=instid
			end
		else
			exec [PA_sOrdenes] 4 ,@docid,null,null,null,null,null,null,null,null,null,null,null,null,
			null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
	end


--Consulta sEmb1
if @doc=3
	begin	
	if @instid != ''
		begin
			select e1.EmbId, e1.OrdenId, od.LoteId, e1.Reftrans, e1.DstinoId, de.Nombre Dstino, e1.Provflet, e1.Pesoemb, convert(varchar (30) ,
			e1.Fchemb, 126) as 'Fchemb', e1.Noselloe, convert(varchar (30) ,e1.Fchrec, 126) as 'Fchrec', e1.Pesore,
			e1.Dif, e1.OprdorId, e1.Silo, e1.Sellorec, e1.Factfl, e1.Obgen, e1.EstadoId, e1.MonedaId, e1.Tarifa, od.OrdenId, od.OrigenId, og.Nombre Origen,
			lo.TrigoId, tr.Nombre Trigo, lo.ProvId ProvTrigoId, pr1.Nombre ProvTrigo, e1.Provflet, pr2.Nombre Provfletn, op.Nombre Oprdor,
			 convert(varchar (30) ,e1.Fchcrea, 126) as 'Fchcrea',  convert(varchar (30) ,e1.Fchmod, 126) as 'Fchmod'
			from sEmb1h e1 inner join sOrdenes od
				on e1.OrdenId = od.OrdenId
			inner join sOrigen og
				on od.OrigenId = og.OrigenId
			inner join sDestino de
				on e1.DstinoId = de.DstinoId
			inner join sLotes lo
				on od.LoteId = lo.LoteId
			inner join sTrigos tr
				on lo.TrigoId = tr.TrigoId
			inner join sProveed pr1
				on lo.ProvId = pr1.ProvId
			inner join sProveed pr2
				on e1.Provflet = pr2.ProvId
			left outer join sOprador op
				on e1.OprdorId = op.OprdorId
			where EmbId=@docid and @instid=instid
		return
		end
		else
			exec[PA_sEmb1] 4,@docid,null,null,null,null,null,null,null,null,null,null,null,null,
					null,null,null,null,null,null,null,null,null,null
		return
	end

--Consulta semb2
if @doc=4
	begin		
		if @instid !=''
			begin
				select Condlimp, Olor, Color, Danado, Plagas, Otros, EmbId,  convert(varchar (30) ,Fchmod, 126) as 'Fchmod'
				from sEmb2h where Embid=@docid and @instid=instid;
			end 
		else
			exec [PA_sEmb2]4,null,null,null,null,null,null,@docid,null,null
	end
			

--Consulta sEmb3
if @doc=5
	begin
		if @instid !=''
			begin
				select Condtra, Libreba, Libregr, Otros, Sellosc, Servtra, EmbId, convert(varchar (30) ,Fchmod, 126) as 'Fchmod'
				from sEmb3h where Embid=@docid and @instid=instid;
			end
		else
			exec [PA_sEmb3]4,null,null,null,null,null,null,@docid,null,null
	end


--Consulta sEmb4
if @doc=6
	begin
		if @instid !=''
			begin
				select lo.Proteina, Eprot, lo.Humedad Ehum, lo.Pesohtl Ephl, lo.Impureza Eimp,
				e4.Lab, e4.Rprot, e4.Rhum, e4.Rphl, e4.Rimp, e4.Oblab, e4.EmbId, e4.Lab, e4.Oblab, convert(varchar (30) , e4.Fchmod, 126) as 'Fchmod'
				from sEmb4h e4 inner join sEmb1 e1
					on e4.EmbId = e1.EmbId
				inner join sOrdenes od
					on e1.OrdenId = od.OrdenId
				inner join sLotes lo
					on lo.LoteId = od.LoteId
				where e4.Embid=@docid and InstId=@instid;
			end
		else
			exec [Pa_sEmb4]4,null,null,null,null,null,null,null,null,null,@docid,null,null,null
	end

--Consulta sTrigos
if @doc=7
	begin
		if @instid !=''
			begin
				select TrigoId,Nombre, Activo,ItemCode,Trgoidan 
				from sTrigosh
				where TrigoId=@docid and instid=@instid
			end
		else
		exec [Pa_sTrigos]4,@docid,null,null,null,null,null,null,null,null
	end

--Consulta sAjustes
if @doc=8
	begin
		if @instid !=''
			begin
				select   AjustId,OrdenId,Fchajus,Compensa,Merma1,Merma2,Merma3,Obsrv,Fchcrea,Usrcrea,
				 Fchmod,Usrmod,EstadoId
				from sAjustesh
				where AjustId=@docid and instid=@instid
			end
		else
			exec [PA_sAjustes]4,@docid,null,null,null,null,null,null,null,null,null,null,null,null
	end



--Consulta sVentas
if @doc=9
	begin
		if @instid !=''
			begin
				select VentaId,Tonventa,OrdenId,Fchventa,EstadoId,Obsrv,Fchcrea,Fchmod,Usrcrea,Usrmod
				from sVentash
				where VentaId=@docId and instid=@instid
			end
		else
			exec [PA_sVentas] 4,@docid,null,null,null,null,null,null,null,null,null
	end


--Consulta sOrigen
if @doc=10
	begin
		if @instid !=''
			begin
				select  OrigenId,Nombre,Activo,Orgnidan
				from sOrigenh
				where OrigenId=@docid and instid=@instid				
			end
		else
			exec [PA_sOrigen] 4,@docid,null,null,null,null,null,null,null
	end


--Consulta sDestino
if @doc=11
	begin
		if @instid !=''
			begin
				select DstinoId, Nombre, Activo, Dstnidan
				from sDestinoh
				where DstinoId = @docid and instid=@instid;
			end
		else
			exec [PA_sDestino] 4,@docid,null,null,null,null,null,null,null
	end

--Consulta sProveed
if @doc=12
	begin
		if @instid !=''
			begin
				select ProvId, Nombre, Calle, Noext, Noint, Colonia, Rferenc, Lcalidad, Mnicipio, Estado, Pais,
				Cdgpstl, Cntcto, TpoprvId, Activo
				from sProveedh
				where ProvId = @docid and instid=qinstid
				return
			end
			
		else
			exec [PA_sProveed]4,@docid,null,null,null,null,null,null,null,null,null,null,null,
			null,null,null,null,null,null,null,null,null
	end

--Consulta sOprador
if @doc=13
	begin
		if @instid !=''
			begin
				select OprdorId, Nkname, Nombre, Activo, Fchcrea, Usrcrea, Fchmod, Usrmod, Usridan
				from sOpradorh
				where OprdorId=@docId and instid=@instid
			end
		else
			exec [PA_sOprador]4,@docid,null,null,null,null,null,null,null,null,null
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sAjustes]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sAjustes](
	@Opcion smallint,
	@Ajustid varchar (10),
	@Ordenid varchar (10),
	@Fchajus date,
	@Compensa decimal (19,3),
	@Merma1 decimal (19,3),
	@Merma2 decimal (19,3),
	@Merma3 decimal (19,3),
	@Obsrv varchar (1000),
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10),
	@Estadoid char
	)
	
as

	declare @pref varchar (3),
			@cantDig tinyint,
			@InstIdC smallint
	
	
	select @pref = 'A',
	@cantDig = 7
	

	if @Opcion=1
	begin
		select isnull ((select 'A' + right ('0000000' + convert(varchar(10),max (convert(int,replace(aj.AjustId,'A',''))) + 1),7)
							 from sAjustes aj),'A0000001') Consecutivo

		return 
	end


	-------inserta nuevo ajuste
	if @Opcion=2
	begin
		insert into sAjustes(AjustId,OrdenId,Fchajus,Compensa,Merma1,Merma2,Merma3,Obsrv,
							 Fchcrea,Usrcrea,Fchmod,Usrmod,EstadoId) 
		values (@Ajustid,@Ordenid,@Fchajus,@Compensa,@Merma1,@Merma2,@Merma3,@Obsrv,getdate(),
				@Usrcrea,getdate(),@Usrmod,@Estadoid)

		return
	end




	-------actualiza ajuste
	if @Opcion=3
	begin
	if (select estadoid from sAjustes where @Ajustid=AjustId)='L'
			begin
				 raiserror('El ajuste %s no se puede modificar porque ha sido cancelado',11,0,@ajustid)
			return
			end
		--Inserta un nuevo registro en el histórico
		insert into sAjustesh (InstId, Usrefect, AjustId,OrdenId,Fchajus,Compensa,Merma1,Merma2,Merma3,
								Obsrv,Fchcrea,Usrcrea, Fchmod,Usrmod,EstadoId)
		select isnull ((select max (InstId) + 1
				from sAjustesh
				where AjustId = @Ajustid), 0) InstId, @Usrmod, --InstId: Número de instancia, Usrefect: el usuario que efectúa el cambio
		AjustId,OrdenId,Fchajus,Compensa,Merma1,Merma2,Merma3,Obsrv,Fchcrea,Usrcrea,
		Fchmod,Usrmod,EstadoId
		from sAjustes
		where AjustId= @Ajustid

			
		update sAjustes
		set OrdenId = @Ordenid,
		Fchajus = @Fchajus,
		Compensa = @Compensa,
		Merma1 = @Merma1,
		Merma2 = @Merma2,
		Merma3 = @Merma3,
		Obsrv = @Obsrv,
		Fchmod = getdate(),
		Usrmod = @Usrmod,
		EstadoId = @Estadoid
		where AjustId = @Ajustid
			and EstadoId<>'L'
		
		return
	end

	if @Opcion in (2, 3)
	begin
		if exists (select aj.EstadoId
					from sAjustes aj
					where aj.AjustId=@Ajustid
					and (aj.EstadoId = 'L'
					or (aj.EstadoId = 'C' and @Estadoid = 'C')))
			begin
				raiserror ('El ajuste %s no se puede modificar porque ha sido cancelado/cerrado.', 11, 0, @Ajustid)
				return
			end

	end

	-------consulta ajuste
	if @Opcion=4
	begin
		select   AjustId,OrdenId,Fchajus,Compensa,Merma1,Merma2,Merma3,Obsrv,Fchcrea,Usrcrea,
				 Fchmod,Usrmod,EstadoId
		from sAjustes
		where AjustId=@AjustId
		
		return
	end
	
	
	
	--Consulta el AjustId anterior al actual
	if @Opcion = 5
	begin
		select @AjustId = right (@AjustId, len (@AjustId) - len (@pref))
		
		if (select max (convert (int, right(AjustId, len (AjustId) - len (@pref))))
			from sAjustes
			where convert (int, right(AjustId, len (AjustId) - len (@pref))) < @AjustId) is not null
			select max (AjustId) AjustId
			from sAjustes
			where convert (int, right(AjustId, len (AjustId) - len (@pref))) < @AjustId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), max (convert (int, right(AjustId, len (AjustId) - len (@pref))))), @cantDig)
							from sAjustes), @pref + right ('0000000001', @cantDig)) AjustId
	
		return
	end

	
	
	
	--Consulta el AjustId siguiente al actual
	if @opcion = 6
	begin
		select @AjustId = right (@AjustId, len (@AjustId) - len (@pref))
		
		if (select min (convert (int, right(AjustId, len (AjustId) - len (@pref))))
		from sAjustes
		where convert (int, right(AjustId, len (AjustId) - len (@pref))) > @AjustId) is not null
			select min (AjustId) AjustId
			from sAjustes
			where convert (int, right(AjustId, len (AjustId) - len (@pref))) > @AjustId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), min (convert (int, right(AjustId, len (AjustId) - len (@pref))))), @cantDig)
							from sAjustes), @pref + right ('0000000001', @cantDig)) AjustId
	 
		return
	end


	--Consulta todo el histórico de cambios sobre el Lote
	if @Opcion = 7
	begin
		select @InstIdC = max(InstId) + 1
		from sAjustesh ajh
		where ajh.AjustId = @Ajustid
		--Primeras 5 columnas se presentan en el visor de cambios
		select ajh.InstId Instancia, ajh.Fchajus [Fecha de Lote],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		ajh.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		ajh.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		ajh.AjustId,ajh.OrdenId,ajh.Fchajus,ajh.Compensa,ajh.Merma1,ajh.Merma2,ajh.Merma3,ajh.Obsrv,
		ajh.EstadoId
		from sAjustesh ajh inner join sUsuarios us1
			on ajh.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on ajh.Usrmod = us2.UsrId
		where ajh.AjustId=@Ajustid
		--Valores de la instancia actual (tabla de documentos).
		union
		select isnull (@InstIdc, 0) Instancia, aj.Fchajus [Fecha de Lote],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		aj.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		aj.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		aj.AjustId,aj.OrdenId,aj.Fchajus,aj.Compensa,aj.Merma1,aj.Merma2,aj.Merma3,aj.Obsrv,
		aj.EstadoId
		from sAjustes aj inner join sUsuarios us1
			on aj.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on aj.Usrmod = us2.UsrId
		where aj.AjustId=@Ajustid
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sConfig]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sConfig](
	@Opcion smallint,
	@ConfId varchar(10), 
	@Carpanx text,
	@Carpimg text, 
	@CarpImp text,
	@Tnlmax decimal(19,3), 
	@Tnlmin decimal(19,3), 
	@Difmin decimal(19,3), 
	@Difmax decimal(19,3), 
	@Usrmod varchar(10),
	@Fchmod datetime,
	@Nombre varchar (500),
	@Calle varchar(250),
	@Noext varchar(40),
	@Noint varchar(40),
	@Colonia varchar(100),
	@Rferenc varchar(80),
	@Lcalidad varchar(80),
	@Mnicipio varchar(100),
	@Estado varchar(100),
	@Pais varchar(100),
	@Cdgstl varchar(30)



)

as

--insertar o Actualizar
if @opcion in (1,2) 
	begin
		if not exists (select ConfId from sConfig where Confid=@ConfId)
			begin
				insert into sConfig (ConfId,Carpanx,Carpimg,CarpImp,Tnlmax,Tnlmin,Difmin,Difmax,Usrmod,Fchmod,Nombre,Calle,
				Noext ,Noint ,Colonia ,Rferenc ,Lcalidad ,Mnicipio ,Estado,Pais,Cdgstl)
				values(@ConfId,@Carpanx,@Carpimg,@CarpImp,@Tnlmax,@Tnlmin,@Difmin,@Difmax,@Usrmod,@Fchmod,@Nombre,@Calle,
				@Noext ,@Noint ,@Colonia ,@Rferenc ,@Lcalidad ,@Mnicipio ,@Estado,@Pais,@Cdgstl)
			end
		else
			update sConfig
			set Carpanx=@Carpanx,
				Carpimg=@Carpimg,
				CarpImp=@CarpImp,
				Tnlmax=@Tnlmax,
				Tnlmin=@Tnlmin,
				Difmin=@Difmin,
				Difmax=@Difmax,
				Usrmod=@Usrmod,
				Fchmod=@Fchmod,
				Nombre=@Nombre,
				Calle=@Calle,
				Noext=@Noext ,
				Noint=@Noint ,
				Colonia=@Colonia ,
				Rferenc=@Rferenc ,
				Lcalidad =@Lcalidad ,
				Mnicipio=@Mnicipio ,
				Estado=@Estado,
				Pais=@Pais,
				Cdgstl=@Cdgstl 
				where ConfId=@ConfId
	end

--Consultar
if @opcion=3
	begin
		select ConfId,Carpanx,Carpimg,CarpImp,Tnlmax,Tnlmin,Difmin,Difmax,Usrmod,Fchmod,Nombre,Calle,
				Noext ,Noint ,Colonia ,Rferenc ,Lcalidad ,Mnicipio ,Estado,Pais,Cdgstl 
		from sConfig 
		where confid=@ConfId
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sDestino]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sDestino](
@Opcion smallint,
@Dstinoid varchar (10),
@Nombre varchar (500),
@Activo bit,
@Fchcrea datetime,
@Usrcrea varchar (10),
@Fchmod datetime,
@Usrmod varchar (10),
@Dstnidan varchar (10)
)
as

	declare @pref varchar (3),
			@cantDig tinyint
	
	
	select @pref = 'DE',
	@cantDig = 4
	
--Consecutivo siguiente
	if @Opcion=1
			begin
				select isnull((select 'DE' + right('0000'+convert(varchar(20), max(convert(int,replace(de.DstinoId, 'DE', '')))+1),4)
				from sDestino de), 'DE0001')  CONSECUTIVO
			return
			end
			
			
			
--Insa un nuevo registro
	if @Opcion =2
	begin
		insert into sDestino (DstinoId, Nombre, Activo, Fchcrea, Usrcrea, Fchmod, Usrmod, Dstnidan) 
		values (@Dstinoid, @Nombre, @Activo, getdate(), @Usrcrea, getdate(), @Usrmod, @Dstnidan)
	return
	end
	
	
	
--Actualiza un destino
	if @opcion = 3
	begin
		update sDestino
		set Nombre = @Nombre,
		Activo = @Activo,
		Fchmod = getdate(),
		Usrmod = @Usrmod
		where DstinoId = @Dstinoid
		
		RETURN

	end


--Consulta un destino
	if @Opcion=4
	begin
		select DstinoId, Nombre, Activo, Dstnidan
		from sDestino
		where DstinoId = @Dstinoid;
		
		return
	end



	--Consulta el DstinoId anterior al actual
	if @Opcion = 5
	begin
		select @DstinoId = right (@DstinoId, len (@DstinoId) - len (@pref))
		
		if (select max (convert (int, right(DstinoId, len (DstinoId) - len (@pref))))
			from sDestino
			where convert (int, right(DstinoId, len (DstinoId) - len (@pref))) < @DstinoId) is not null
			select max (DstinoId) DstinoId
			from sDestino
			where convert (int, right(DstinoId, len (DstinoId) - len (@pref))) < @DstinoId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), max (convert (int, right(DstinoId, len (DstinoId) - len (@pref))))), @cantDig)
							from sDestino), @pref + right ('0000000001', @cantDig)) DstinoId
	
		return
	end

	
	
	
	--Consulta el DstinoId siguiente al actual
	if @opcion = 6
	begin
		select @DstinoId = right (@DstinoId, len (@DstinoId) - len (@pref))
		
		if (select min (convert (int, right(DstinoId, len (DstinoId) - len (@pref))))
		from sDestino
		where convert (int, right(DstinoId, len (DstinoId) - len (@pref))) > @DstinoId) is not null
			select min (DstinoId) DstinoId
			from sDestino
			where convert (int, right(DstinoId, len (DstinoId) - len (@pref))) > @DstinoId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), min (convert (int, right(DstinoId, len (DstinoId) - len (@pref))))), @cantDig)
							from sDestino), @pref + right ('0000000001', @cantDig)) DstinoId
	 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sEmb1]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1.Doc siguiente 2.Insercion 3. Actualizacion 4.Consulta
CREATE procedure [dbo].[PA_sEmb1](
				@Opcion smallint,
				@Embid varchar (10),
				@Ordenid varchar (10),
				@Reftrans varchar (60),
				@Dstinoid varchar (10),
				@Provflet varchar (10),
				@Pesoemb decimal (19,3),
				@Fchemb date,
				@Noselloe varchar (60),
				@Fchrec date,
				@Pesore decimal (19,3),
				@Dif decimal (19,3),
				@Oprdorid varchar (10),
				@Silo varchar (25),
				@Sellorec varchar (60),
				@Factfl varchar (20),
				@Obgen varchar (1000),
				@Usrcrea varchar (10),
				@Usrmod varchar (10),
				@Fchcrea datetime,
				@Fchmod datetime,
				@Estadoid char,
				@MonedaId varchar(10),
				@Tarifa decimal(16,4),
				@Refcrgmas varchar(40)
)
as

	declare @pref varchar (3),
			@cantDig tinyint,
			@docto varchar(20),
			@InstIdc smallint
	
	select @pref = 'E',
	@cantDig = 7
	
	

	if @Opcion=1
	begin
		select isnull((select 'E' + right('0000000'+convert(varchar(20), max(convert(int,replace(mb.Embid, 'E', '')))+1),7)
		from sEmb1 mb), 'E0000001')  CONSECUTIVO
		
		return
	end


	if @Opcion = 2
	begin
		if not exists (select ProvId
					from sProveed
					where ProvId = @Provflet
					and Activo = 1
					and TpoprvId = 'T002')
		begin
			raiserror ('El proveedor %s no existe, no se encuentra activo o no es del tipo de proveedor requerido.', 11, 0, @Provflet)
			return
		end
		
		if not exists (select DstinoId
					from sDestino
					where DstinoId = @Dstinoid
					and Activo = 1)
		begin
			raiserror ('El destino %s no existe o no se encuentra activo.', 11, 0, @Dstinoid)
			return
		end
		
		if isnull (ltrim(rtrim(@Refcrgmas)), '') = ''
			set @Refcrgmas = NULL
		else
		begin
			select @docto = EmbId
			from sEmb1 e1
			where e1.Refcrgmas = @Refcrgmas
			and e1.OrdenId = @Ordenid
			and e1.Provflet = @Provflet
			and e1.Noselloe = @Noselloe
			
			if not @docto is null
			begin
				raiserror ('El embarque %s tiene características similares a las del nuevo embarque que desea importar.', 11, 0, @docto)
				return
			end
		end
		
		if not exists (select OrdenId
					from sOrdenes
					where OrdenId= @OrdenId
					and EstadoId = 'A')
		begin
			raiserror ('La Orden %s no existe o se encuentra Cerrada o Cancelada.', 11, 0, @OrdenId)
			return
		end
				
	end
	
	
	if @Opcion in (2, 3)
	begin
		if ltrim(rtrim(isnull (@Oprdorid, ''))) = ''
			set @Oprdorid = NULL
		else
		begin
			if exists (select op.OprdorId 
						from sOprador op
						where op.OprdorId=@Oprdorid )
			begin
					if exists (select op.OprdorId 
							  from sOprador op
							  where op.OprdorId=@Oprdorid and Activo= 0)
					begin
						raiserror ('El operador %s no esta activo ', 11, 0, @Oprdorid)
					
						return
					end
			end
			else 
			begin
					raiserror ('El operador %s no existe ', 11, 0, @Oprdorid)
				
					return
			end
		end


		if ltrim(rtrim(@Silo)) in ('', '-')
			set @Silo = NULL

		if ltrim(rtrim(@Factfl))= ''
			set @Factfl=null
		if ltrim(rtrim(@MonedaId)) = ''
			set @MonedaId = NULL

				
		if exists (select estadoId
					from sEmb1
					where EmbId=@EmbId
					and (EstadoId = 'L'
					or (EstadoId = 'C' and @Estadoid = 'C')))
		begin
			raiserror ('El embarque %s no se puede modificar porque ha sido cancelado/cerrado.', 11, 0, @Embid)
			return
		end

	end
	
	
	if @Opcion =2
	begin
		insert into sEmb1 (EmbId, OrdenId, Reftrans, DstinoId, Provflet, Pesoemb, Fchemb, Noselloe, Fchrec, Pesore, Dif, OprdorId,
						   Silo, Sellorec, Factfl, Obgen, Usrcrea, Usrmod, Fchcrea, Fchmod,EstadoId, MonedaId, Tarifa, Refcrgmas)
		values (@Embid, @Ordenid, @Reftrans, @Dstinoid, @Provflet, @Pesoemb, @Fchemb, @Noselloe, @Fchrec, @Pesore,
				@Dif, @Oprdorid, @Silo, @Sellorec, @Factfl, @Obgen, @Usrcrea, @Usrmod, getdate(), getdate(), @Estadoid, @MonedaId, @Tarifa, @Refcrgmas)
								
		return
	end

	if @opcion =3
		begin

				--Inserta un nuevo registro en el histórico
		insert into sEmb1h (InstId, Usrefect, EmbId, OrdenId, Reftrans, DstinoId, Provflet, Pesoemb, Fchemb, Noselloe, Fchrec, Pesore,
							Dif, OprdorId, Silo, Sellorec, Factfl, Obgen, Usrcrea, Usrmod, Fchcrea, Fchmod, EstadoId, MonedaId, Tarifa, Refcrgmas)
		select isnull ((select max (InstId) + 1
				from sEmb1h
				where EmbId = @EmbId), 0) InstId, @Usrmod, --InstId: Número de instancia, Usrefect: el usuario que efectúa el cambio
					EmbId, OrdenId, Reftrans, DstinoId, Provflet, Pesoemb, Fchemb, Noselloe, Fchrec, Pesore,
					Dif, OprdorId, Silo, Sellorec, Factfl, Obgen, Usrcrea, Usrmod, Fchcrea, Fchmod, EstadoId, MonedaId, Tarifa, Refcrgmas
		from sEmb1
		where EmbId= @Embid

		update sEmb1
		set EmbId = @Embid,
			OrdenId = @Ordenid,
			Reftrans = @Reftrans,
			DstinoId = @Dstinoid,
			Provflet = @Provflet,
			Pesoemb = @Pesoemb,
			Fchemb = @Fchemb,
			Noselloe = @Noselloe,
			Fchrec = @Fchrec,
			Pesore = @Pesore,
			Dif = @Dif,
			OprdorId = @Oprdorid,
			Silo = @Silo,
			Sellorec = @Sellorec,
			Factfl = @Factfl,
			Obgen = @Obgen,
			Usrmod = @Usrmod,
			Fchmod = getdate(),
			EstadoId = @Estadoid,
			MonedaId = @MonedaId, 
			Tarifa = @Tarifa
		where Embid=@Embid
		and EstadoId <> 'L';
		
		RETURN
	end
		
		
		
	if @Opcion=4
	begin
		select e1.EmbId, e1.OrdenId, od.LoteId, e1.Reftrans, e1.DstinoId, de.Nombre Dstino, e1.Provflet, e1.Pesoemb, convert(varchar (30) ,
		e1.Fchemb, 126) as 'Fchemb', e1.Noselloe, convert(varchar (30) ,e1.Fchrec, 126) as 'Fchrec', e1.Pesore,
		e1.Dif, e1.OprdorId, e1.Silo, e1.Sellorec, e1.Factfl, e1.Obgen, e1.EstadoId, e1.MonedaId, e1.Tarifa, od.OrdenId, od.OrigenId, og.Nombre Origen,
		lo.TrigoId, tr.Nombre Trigo, lo.ProvId ProvTrigoId, pr1.Nombre ProvTrigo, e1.Provflet, pr2.Nombre Provfletn, op.Nombre Oprdor,
		 convert(varchar (30) ,e1.Fchcrea, 126) as 'Fchcrea',  convert(varchar (30) ,e1.Fchmod, 126) as 'Fchmod', e1.Refcrgmas
		from sEmb1 e1 inner join sOrdenes od
			on e1.OrdenId = od.OrdenId
		inner join sOrigen og
			on od.OrigenId = og.OrigenId
		inner join sDestino de
			on e1.DstinoId = de.DstinoId
		inner join sLotes lo
			on od.LoteId = lo.LoteId
		inner join sTrigos tr
			on lo.TrigoId = tr.TrigoId
		inner join sProveed pr1
			on lo.ProvId = pr1.ProvId
		inner join sProveed pr2
			on e1.Provflet = pr2.ProvId
		left outer join sOprador op
			on e1.OprdorId = op.OprdorId
		where EmbId=@Embid;
	
		return
	end
		
		
		
	--Consulta el EmbId anterior al actual
	if @Opcion = 5
	begin
		select @EmbId = right (@EmbId, len (@EmbId) - len (@pref))
		
		if (select max (convert (int, right(EmbId, len (EmbId) - len (@pref))))
			from sEmb1
			where convert (int, right(EmbId, len (EmbId) - len (@pref))) < @EmbId) is not null
			select max (EmbId) EmbId
			from sEmb1
			where convert (int, right(EmbId, len (EmbId) - len (@pref))) < @EmbId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), max (convert (int, right(EmbId, len (EmbId) - len (@pref))))), @cantDig)
							from sEmb1), @pref + right ('0000000001', @cantDig)) EmbId
	
		return
	end

	
	
	
	--Consulta el EmbId siguiente al actual
	if @opcion = 6
	begin
		select @EmbId = right (@EmbId, len (@EmbId) - len (@pref))
		
		if (select min (convert (int, right(EmbId, len (EmbId) - len (@pref))))
		from sEmb1
		where convert (int, right(EmbId, len (EmbId) - len (@pref))) > @EmbId) is not null
			select min (EmbId) EmbId
			from sEmb1
			where convert (int, right(EmbId, len (EmbId) - len (@pref))) > @EmbId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), min (convert (int, right(EmbId, len (EmbId) - len (@pref))))), @cantDig)
							from sEmb1), @pref + right ('0000000001', @cantDig)) EmbId
	 
		return
	end


	--Consulta todo el histórico de cambios sobre la Orden
	if @Opcion = 7
	begin
		select @InstIdc = max(e1h.InstId) + 1
		from sEmb1h e1h
		where e1h.embid = @embId


		--Primeras 5 columnas se presentan en el visor de cambios
		select e1h.InstId Instancia, e1h.Fchemb [Fecha de Embarque],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		e1h.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		e1h.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de sEmb1.
		e1h.EmbId, e1h.OrdenId, od.LoteId, e1h.Reftrans, e1h.DstinoId, de.Nombre Dstino, e1h.Provflet, e1h.Pesoemb, 
		convert(varchar (30) , e1h.Fchemb, 126) as 'Fchemb', e1h.Noselloe, convert(varchar (30) ,e1h.Fchrec, 126) as 'Fchrec', e1h.Pesore,
		e1h.Dif, e1h.OprdorId, e1h.Silo, e1h.Sellorec, e1h.Factfl, e1h.Obgen, e1h.EstadoId, e1h.MonedaId, e1h.Tarifa, od.OrdenId, od.OrigenId, og.Nombre Origen,
		lo.TrigoId, tr.Nombre Trigo, lo.ProvId ProvTrigoId, pr1.Nombre ProvTrigo, e1h.Provflet, pr2.Nombre Provfletn, op.Nombre Oprdor,
		 convert(varchar (30) ,e1h.Fchcrea, 126) as 'Fchcrea',  convert(varchar (30) ,e1h.Fchmod, 126) as 'Fchmod',
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de sEmb2.
		e2h.Condlimp, e2h.Olor, e2h.Color, e2h.Danado, e2h.Plagas, e2h.Otros, e2h.EmbId,
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de sEmb3.
		e3h.Condtra, e3h.Libreba, e3h.Libregr, e3h.Otros, e3h.Sellosc, e3h.Servtra, e3h.EmbId,
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de sEmb4.
		lo.Proteina, e4h.Eprot, lo.Humedad Ehum, lo.Pesohtl Ephl, lo.Impureza Eimp,
			e4h.Lab, e4h.Rprot, e4h.Rhum, e4h.Rphl, e4h.Rimp, e4h.Oblab, e4h.EmbId, e4h.Lab, e4h.Oblab
		from sEmb1h e1h inner join sOrdenes od 
			on e1h.ordenid=od.ordenid
		inner join sUsuarios us1
			on e1h.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on e1h.Usrmod = us2.UsrId
		inner join sOrigen og
			on od.OrigenId = og.OrigenId
		inner join sDestino de
			on de.dstinoid=e1h.dstinoid
		inner join sLotes lo
			on lo.loteid =od.loteid
		inner join strigos tr
			on tr.TrigoId=lo.TrigoId
		inner join sproveed pr1
			on pr1.provid=lo.provid
		inner join sproveed pr2
			on pr2.provid=e1h.provflet
		left outer join sOprador op
			on op.OprdorId=e1h.oprdorid
		left outer join sProveed pr
			on od.ProvId = pr.ProvId
		inner join sEmb2h e2h 
			on e2h.Instid=e1h.Instid and e2h.EmbId=e1h.EmbId
		inner join sEmb3h e3h 
			on e3h.Instid=e1h.Instid and e3h.EmbId=e1h.EmbId
		inner join sEmb4h e4h 
			on e4h.Instid=e1h.Instid and e4h.EmbId=e1h.EmbId


		where e1h.EmbId=@EmbId --and e2h.EmbId=@EmbId and e3h.EmbId=@EmbId and e4h.EmbId=@EmbId 
		--Valores de la instancia actual (tabla de documentos).
		
		union
		select isnull (@InstIdc, 0) Instancia, e1.Fchemb [Fecha de Embarque],
				isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		e1.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		e1.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de sEmb1.
		e1.EmbId, e1.OrdenId, od.LoteId, e1.Reftrans, e1.DstinoId, de.Nombre Dstino, e1.Provflet, e1.Pesoemb, convert(varchar (30) ,
		e1.Fchemb, 126) as 'Fchemb', e1.Noselloe, convert(varchar (30) ,e1.Fchrec, 126) as 'Fchrec', e1.Pesore,
		e1.Dif, e1.OprdorId, e1.Silo, e1.Sellorec, e1.Factfl, e1.Obgen, e1.EstadoId, e1.MonedaId, e1.Tarifa, od.OrdenId, od.OrigenId, og.Nombre Origen,
		lo.TrigoId, tr.Nombre Trigo, lo.ProvId ProvTrigoId, pr1.Nombre ProvTrigo, e1.Provflet, pr2.Nombre Provfletn, op.Nombre Oprdor,
		 convert(varchar (30) ,e1.Fchcrea, 126) as 'Fchcrea',  convert(varchar (30) ,e1.Fchmod, 126) as 'Fchmod',
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de sEmb2.
		e2.Condlimp, e2.Olor, e2.Color, e2.Danado, e2.Plagas, e2.Otros, e2.EmbId,
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de smb3.
		e3.Condtra, e3.Libreba, e3.Libregr, e3.Otros, e3.Sellosc, e3.Servtra, e3.EmbId,
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4 de smb4.
		lo.Proteina, Eprot, lo.Humedad Ehum, lo.Pesohtl Ephl, lo.Impureza Eimp,
		e4.Lab, e4.Rprot, e4.Rhum, e4.Rphl, e4.Rimp, e4.Oblab, e4.EmbId, e4.Lab, e4.Oblab
		from sEmb1 e1 inner join sOrdenes od 
			on e1.ordenid=od.ordenid
		inner join sUsuarios us1
			on e1.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on e1.Usrmod = us2.UsrId
		inner join sOrigen og
			on od.OrigenId = og.OrigenId
		inner join sDestino de
			on de.dstinoid=e1.dstinoid
		inner join sLotes lo
			on lo.loteid =od.loteid
		inner join strigos tr
			on tr.TrigoId=lo.TrigoId
		inner join sproveed pr1
			on pr1.provid=lo.provid
		inner join sproveed pr2
			on pr2.provid=e1.provflet
		left outer join sOprador op
			on op.OprdorId=e1.oprdorid
		left outer join sProveed pr
			on od.ProvId = pr.ProvId
		inner join sEmb2 e2
			on e2.EmbId=e1.EmbId
		inner join sEmb3 e3
			on e3.EmbId=e1.EmbId
		inner join sEmb4 e4
			on e4.EmbId=e1.EmbId
		where e1.EmbId=@Embid



		return

	end

	if @opcion=8
	begin
		select e1.EmbId [Embarque], e1.Fchemb [Fecha de Embarque],e1.Reftrans [Referencia de Tansporte],e1.Pesoemb [Peso Embarcado],
		pv.Nombre [Proveedor], e1.Refcrgmas [Carga Masiva], e1.Factfl [No. de Factura] 
		from semb1 e1 inner join sProveed pv
			on pv.ProvId=e1.Provflet
		where EstadoId = 'A'  and Factfl is null
	end

 -- declare @Temp1 table(
 --  Tembid varchar (10),
 --  Testadoid char
 --   )
	
	--INSERT INTO @Temp1(Tembid, Testadoid)
 --   SELECT p.Tembid,p.Testadoid
 --   FROM @Temp1 p;

GO
/****** Object:  StoredProcedure [dbo].[PA_sEmb2]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sEmb2](
			@Opcion smallint,
			@Condlimp bit,
			@Olor varchar (100),
			@Color varchar (100),
			@Danado varchar (100),
			@Plagas varchar (100),
			@Otros varchar (100),
			@Embid varchar (10),
			@Usrmod varchar (10),
			@Fchmod date
)
as


		if @Opcion =2
		begin
			insert into sEmb2 (Condlimp, Olor, Color, Danado, Plagas, Otros, EmbId, Usrmod, Fchmod)
			values (@Condlimp, @Olor, @Color, @Danado, @Plagas, @Otros, @Embid, @Usrmod, getdate())
			return
		end




		if @opcion =3
		begin
			--Inserta un nuevo registro en el histórico
			insert into sEmb2h (InstId, Usrefect, Condlimp, Olor, Color, Danado, Plagas, Otros, EmbId, Usrmod, Fchmod)
			select isnull ((select max (InstId) + 1
					from sEmb2h
					where EmbId = @EmbId), 0) InstId, @Usrmod, --InstId: Número de instancia, Usrefect: el usuario que efectúa el cambio
						Condlimp, Olor, Color, Danado, Plagas, Otros, EmbId, Usrmod, Fchmod
			from sEmb2
			where EmbId= @Embid
			
			update sEmb2
			set Condlimp = @Condlimp,
				Olor = @Olor,
				Color = @Color,
				Danado = @Danado,
				Plagas = @Plagas,
				Otros = @Otros,
				EmbId = @Embid,
				Usrmod = @Usrmod,
				Fchmod = getdate()
			where Embid=@Embid;

			RETURN
		end
		
		
		
		
		
		if @Opcion=4
		begin
			select Condlimp, Olor, Color, Danado, Plagas, Otros, EmbId,  convert(varchar (30) ,Fchmod, 126) as 'Fchmod'
			from sEmb2 where Embid=@Embid;
			
			return
		end

GO
/****** Object:  StoredProcedure [dbo].[PA_sEmb3]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sEmb3](
	@Opcion int,
	@Condtra bit,
	@Libreba varchar (100),
	@Libregr varchar (100),
	@Otros varchar (100),
	@Sellosc varchar (100),
	@Servtra varchar (100),
	@Embid varchar (10),
	@Usrmod varchar (10),
	@Fchmod date
	)
as


		if @Opcion =2
		begin
			insert into sEmb3 (Condtra, Libreba, Libregr, Otros, Sellosc, Servtra, EmbId, Usrmod, Fchmod)
			values (@Condtra, @Libreba, @Libregr, @Otros, @Sellosc, @Servtra, @Embid, @Usrmod, getdate())
			
			return
		end



		if @opcion =3
		begin
			--Inserta un nuevo registro en el histórico
			insert into sEmb3h (InstId, Usrefect, Condtra, Libreba, Libregr, Otros, Sellosc, Servtra, EmbId, Usrmod, Fchmod)
			select isnull ((select max (InstId) + 1
					from sEmb3h
					where EmbId = @EmbId), 0) InstId, @Usrmod, --InstId: Número de instancia, Usrefect: el usuario que efectúa el cambio
						Condtra, Libreba, Libregr, Otros, Sellosc, Servtra, EmbId, Usrmod, Fchmod
			from sEmb3
			where EmbId= @Embid
			update sEmb3
			set Condtra = @Condtra, 
			Libreba = @Libreba, 
			Libregr = @Libregr, 
			Otros = @Otros, 
			Sellosc = @Sellosc, 
			Servtra = @Servtra,
			EmbId = @Embid, 
			Usrmod = @Usrmod, 
			Fchmod = getdate()
			where Embid=@Embid;

			RETURN
		end
		
		
		
		
		if @Opcion=4
		begin
			select Condtra, Libreba, Libregr, Otros, Sellosc, Servtra, EmbId, convert(varchar (30) ,Fchmod, 126) as 'Fchmod'
			from sEmb3 where Embid=@Embid;
			
			return
		end

GO
/****** Object:  StoredProcedure [dbo].[PA_sEmb4]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sEmb4](
			@Opcion int,
			@Eprot decimal (19,3),
			@Ehum decimal (19,3),
			@Ephl decimal (19,3),
			@Eimp decimal (19,3),
			@Rprot decimal (19,3),
			@Rhum decimal (19,3),
			@Rphl decimal (19,3),
			@Rimp decimal (19,3),
			@Oblab varchar (1000),
			@Embid varchar (10),
			@Usrmod varchar (10),
			@Fchmod date,
			@Lab bit
)
as


		if @Opcion =2
		begin
			insert into sEmb4 (Eprot, Ehum, Ephl, Eimp, Rprot, Rhum, Rphl, Rimp, Oblab, EmbId, Usrmod, Fchmod, Lab)
			values (@Eprot, @Ehum, @Ephl, @Eimp, @Rprot, @Rhum, @Rphl, @Rimp, @Oblab, @Embid, @Usrmod,getdate(),@Lab)
			
			return
		end

		if @opcion =3
		begin
			--Inserta un nuevo registro en el histórico
			insert into sEmb4h (InstId, Usrefect, Eprot, Ehum, Ephl, Eimp, Rprot, Rhum, Rphl, Rimp, Oblab, EmbId, Usrmod, Fchmod,Lab)
			select isnull ((select max (InstId) + 1
					from sEmb4h
					where EmbId = @EmbId), 0) InstId, @Usrmod, --InstId: Número de instancia, Usrefect: el usuario que efectúa el cambio
						Eprot, Ehum, Ephl, Eimp, Rprot, Rhum, Rphl, Rimp, Oblab, EmbId, Usrmod, Fchmod,Lab
			from sEmb4
			where EmbId= @Embid
			
			update sEmb4
			set Eprot = @Eprot,
				Ehum = @Ehum,
				Ephl = @Ephl,
				Eimp = @Eimp,
				Rprot = @Rprot,
				Rhum = @Rhum,
				Rphl = @Rphl,
				Rimp = @Rimp,
				Oblab = @Oblab,
				EmbId = @Embid,
				Usrmod = @Usrmod,
				Fchmod = getdate(),
				Lab=@Lab 
			where Embid=@Embid;

			RETURN
		end
		
		
		
		if @Opcion=4
		begin
			select lo.Proteina, Eprot, lo.Humedad Ehum, lo.Pesohtl Ephl, lo.Impureza Eimp,
			e4.Lab, e4.Rprot, e4.Rhum, e4.Rphl, e4.Rimp, e4.Oblab, e4.EmbId, e4.Lab, e4.Oblab, convert(varchar (30) , e4.Fchmod, 126) as 'Fchmod'
			from sEmb4 e4 inner join sEmb1 e1
				on e4.EmbId = e1.EmbId
			inner join sOrdenes od
				on e1.OrdenId = od.OrdenId
			inner join sLotes lo
				on lo.LoteId = od.LoteId
			where e4.Embid=@Embid;
			
			return
		end

GO
/****** Object:  StoredProcedure [dbo].[PA_sHost]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sHost](
		@Opcion smallint,
		@Hostid tinyint,
		@Nombre varchar (40),
		@Observaciones varchar (1000),
		@Usrcrea varchar (10),
		@Usrmod varchar (10),
		@Fchcrea datetime,
		@Fchmod datetime
		)

as

	if @Opcion=1
	begin
		select isnull ((select max (Hostid) + 1 Consecutivo from sHost hst), 1) Consecutivo
		

			
			
		return
	end




	if @opcion=2
	begin
		insert into sHost (HostId, Nombre, Observaciones, Usrcrea, Usrmod, Fchcrea, Fchmod)
		values (@Hostid, @Nombre, @Observaciones, @Usrcrea, @Usrmod, GETDATE(), GETDATE())
		return
	end




	if @Opcion=3
	begin
		
		update sHost 
		set HostId = @Hostid,
			Nombre = @Nombre,
			Observaciones = @Observaciones,
			Usrmod = @Usrmod,
			Fchmod = getdate()
			
		where HostId = @Hostid
		return
	end 



	if @Opcion=4
	begin
		select HostId, Nombre, Observaciones, Usrcrea, Usrmod, Fchcrea, Fchmod
		from sHost
		where HostId=@Hostid 
		return
	end


	--Consulta el Host anterior al actual
		if @Opcion = 5
	begin
		if (select max (HostId) 
			from sHost
			where HostId < @HostId) is not null
			select max (HostId) HostId
			from sHost
			where HostId < @HostId
		else
			select isnull ((select max (HostId)
							from sHost), 1) HostId
	
		return
	end

	--Consulta el OrdenId siguiente al actual
	if @opcion = 6
	begin
		if (select min (HostId) 
			from sHost
			where HostId > @HostId) is not null
			select min (HostId) HostId
			from sHost
			where HostId > @HostId
		else
			select isnull ((select min (HostId)
							from sHost), 1) HostId
	
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sLogeo]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sLogeo](
		@Opcion smallint,
		@Logid bigint,
		@Usrid varchar (10),
		@Fchconex datetime,
		@Hostid smallint,
		@conexion bit
		)

as

	if @Opcion=1
	begin
		select isnull ((select max(LogId) + 1 from sLogeo), 0) Consecutivo
	
		--select top 1 lgeo.Logid+1 Consecutivo  
		--from sLogeo lgeo 
		--order by 1 desc
		--if @@ROWCOUNT=0
		--	select 1 Consecutivo
		--return
	end




	if @opcion=2
	begin
		declare @NuevoHostId smallint,
		@Nombre varchar (40)
		
		if not exists(select HostId
						from sHost
						where Nombre = HOST_NAME())
		begin			
			select @NuevoHostId = isnull ((select max (Hostid) + 1 from sHost hst), 1),
			@Nombre = HOST_NAME()
			
			
			exec [PA_sHost] 2, @NuevoHostId, @Nombre, 'Nuevo host creado por el usuario', @Usrid, @Usrid, @Fchconex, @Fchconex
		end
		else
			select @NuevoHostId = HostId
			from sHost
			where Nombre = HOST_NAME()
		
		
		
		insert into sLogeo (LogId, UsrId, Fchconex, HostId, conexion)
		values (@Logid, @Usrid,  GETDATE(), @NuevoHostId, @conexion)
		
		
		return
	end


	if @Opcion=4
	begin
		select LogId, UsrId, Fchconex, HostId, conexion
		from sLogeo
		where UsrId=@Usrid 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sLotes]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sLotes](
	@Opcion smallint,
	@Loteid varchar (10),
	@Provid varchar (10),
	@Trigoid varchar (10),
	@Proteina decimal (19,1),
	@Grado int,
	@Humedad decimal (19,1),
	@Pesohtl decimal (19,1),
	@Impureza decimal (19,1),
	@Dockage varchar (30),
	@Vomitoxn varchar (20),
	@Ergot varchar (30),
	@Fllngnum varchar (50),
	@Obsrv varchar (1000),
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10),
	@Estadoid char,
	@Fchlote date,
	@Otros varchar (50)

	)
	
as


	declare 
        @Ordenid varchar (20),
		@NivelError int,
		@Mensaje varchar (100),
		@Docto varchar (20),
		@EstatusDoc varchar (10),
		@InstIdC smallint


	if @Opcion=1
		  begin
			  select isnull ((select 'L' + right ('0000000' + convert(varchar(10),max (convert(int,replace(lo.LoteId,'L',''))) + 1),7)
							 from sLotes lo),'L0000001') Consecutivo

		 return 
	end



	if @Opcion in (2, 3)
	begin
		if exists (select pr.ProvId 
				from sProveed pr
				where pr.ProvId=@Provid )
		begin
			if exists (select pr.ProvId 
					  from sProveed pr
					  where pr.ProvId=@Provid and Activo= 0)
			begin
				raiserror ('El proveedor %s no esta activo ', 11, 0, @Provid)
				
				return
			end
		end
		else 
		begin
			raiserror ('El proveedor %s no existe ', 11, 0, @Provid)
			
			return
	end
	
		if exists (select tr.TrigoId
				from sTrigos tr
				where tr.TrigoId=@TrigoId )
		begin
			if exists (select tr.TrigoId 
					  from sTrigos tr
					  where tr.TrigoId=@TrigoId and Activo= 0)
			begin
				raiserror ('El codigo de trigo %s no esta activo ', 11, 0, @TrigoId)
				
				return
			end
		end
		else 
		begin
			raiserror ('El codigo de trigo %s no existe ', 11, 0, @TrigoId)
			
			return
		end
	end
	
	
	---INSERTA UN NUEVO lote
	if @Opcion=2
		begin
			insert into sLotes(LoteId,ProvId,TrigoId,Proteina,Grado,Humedad,Pesohtl,
						Impureza,Dockage,Vomitoxn,Ergot,Fllngnum,Obsrv,Fchcrea,Usrcrea,
						Fchmod,Usrmod,EstadoId,Fchlote,Otros) 
			values (@Loteid,@Provid,@Trigoid,@Proteina,@Grado,@Humedad,@Pesohtl,@Impureza,
					@Dockage,@Vomitoxn,@Ergot,@Fllngnum,@Obsrv,getdate(),@Usrcrea,getdate(),
					@Usrmod,@Estadoid,@Fchlote,@Otros)

		   return
	end

	--actualiza lotes
	if @Opcion=3
	begin
		if @Estadoid = 'L'
		begin
			select @Docto = rd.OrdenId,@EstatusDoc = ed.Nombre
			from sOrdenes rd inner join cEstados ed
			on rd.EstadoId = ed.EstadoId
			where rd.LoteId = @Loteid
			and ed.EstadoId in ('A','C')

			if @Docto is not null
			begin
				raiserror('El lote %s no puede ser cancelado porque tiene al menos una Orden con Estado %s (%s)', 11, 0, @Loteid, @EstatusDoc, @Docto)
			
				return
			end
		end
		
		insert into sLotesh(InstId, Usrefect, LoteId,ProvId,TrigoId,Proteina,Grado,Humedad,Pesohtl,
				Impureza,Dockage,Vomitoxn,Ergot,Fllngnum,Obsrv,Fchcrea,Usrcrea,
				Fchmod,Usrmod,EstadoId,Fchlote,Otros)
		select isnull ((select max (InstId) + 1
		from sLotesh
		where LoteId = @LoteId), 0) InstId, @Usrmod, LoteId,ProvId,TrigoId,Proteina,Grado,Humedad,Pesohtl,
				Impureza,Dockage,Vomitoxn,Ergot,Fllngnum,Obsrv,Fchcrea,Usrcrea,
				Fchmod,Usrmod,EstadoId,Fchlote,Otros
		from sLotes lo
		where lo.LoteId = @LoteId


		update sLotes set 
		ProvId = @Provid,
		TrigoId = @Trigoid,
		Proteina = @Proteina,
		Grado = @Grado,
		Humedad = @Humedad,
		Pesohtl = @Pesohtl,
		Impureza = @Impureza,
		Dockage = @Dockage,
		Vomitoxn = @Vomitoxn,
		Ergot = @Ergot,
		Fllngnum = @Fllngnum,
		Obsrv = @Obsrv,
		Fchmod = getdate(),
		Usrmod = @Usrmod,
		EstadoId = @Estadoid,
		Fchlote = @Fchlote,
		Otros = @Otros
		where LoteId = @Loteid
		  
		return
	end

	---consulta LoteId
	if @Opcion=4
	begin
		select lo.Fchlote, lo.LoteId, lo.ProvId,
		pr.Nombre Proveedor, lo.TrigoId, tr.Nombre Trigo, lo.Proteina, lo.Grado, lo.Humedad,
		lo.Pesohtl, lo.Impureza,
		lo.Dockage, lo.Vomitoxn, lo.Ergot, lo.Fllngnum, lo.Obsrv, lo.Otros, lo.EstadoId
		from sLotes lo inner join sProveed pr
			on lo.ProvId = pr.ProvId
		inner join sTrigos tr
			on lo.TrigoId = tr.TrigoId
		where LoteId=@Loteid
		

		
		return
	end





	--Consulta el LoteId anterior al actual
	if @Opcion = 5
	begin
		select @LoteId = right (@LoteId, len (@LoteId) - 1)
		
		if (select max (convert (int, right(LoteId, len (LoteId) - 1)))
			from sLotes
			where convert (int, right(LoteId, len (LoteId) - 1)) < @LoteId) is not null
			select max (LoteId) LoteId
			from sLotes
			where convert (int, right(LoteId, len (LoteId) - 1)) < @LoteId
		else
			select isnull ((select 'L' +
							right ('0000000' + convert (varchar (10), max (convert (int, right(LoteId, len (LoteId) - 1)))), 7)
							from sLotes), 'L0000001') LoteId
	
		return
	end

	
	
	
	--Consulta el LoteId siguiente al actual
	if @opcion = 6
	begin
		select @LoteId = right (@LoteId, len (@LoteId) - 1)
		
		if (select min (convert (int, right(LoteId, len (LoteId) - 1)))
		from sLotes
		where convert (int, right(LoteId, len (LoteId) - 1)) > @LoteId) is not null
			select min (LoteId) LoteId
			from sLotes
			where convert (int, right(LoteId, len (LoteId) - 1)) > @LoteId
		else
			select isnull ((select 'L' +
							right ('0000000' + convert (varchar (10), min (convert (int, right(LoteId, len (LoteId) - 1)))), 7)
							from sLotes), 'L0000001') LoteId
	 
		return
	end



	--Consulta todo el histórico de cambios sobre el Lote
	if @Opcion = 7
	begin
		select @InstIdc = max(InstId) + 1
		from sLotesh loh
		where loh.LoteId = @Loteid
		
		
		--Primeras 5 columnas se presentan en el visor de cambios
		select loh.InstId Instancia, loh.Fchlote [Fecha de Lote],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		loh.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		loh.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		loh.Fchlote,
		loh.LoteId, loh.ProvId,
		pr.Nombre Proveedor, loh.TrigoId, tr.Nombre Trigo, loh.Proteina, loh.Grado, loh.Humedad,
		loh.Pesohtl, loh.Impureza,
		loh.Dockage, loh.Vomitoxn, loh.Ergot, loh.Fllngnum, loh.Obsrv, loh.Otros, loh.EstadoId
		from sLotesh loh inner join sUsuarios us1
			on loh.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on loh.Usrmod = us2.UsrId
		inner join sProveed pr
			on loh.ProvId = pr.ProvId
		inner join sTrigos tr
			on loh.TrigoId = tr.TrigoId
		where loh.LoteId = @Loteid
		--Valores de la instancia actual (tabla de documentos).
		union
		select isnull (@InstIdc, 0) Instancia, lo.Fchlote [Fecha de Lote],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		lo.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		lo.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		lo.Fchlote,
		lo.LoteId, lo.ProvId,
		pr.Nombre Proveedor, lo.TrigoId, tr.Nombre Trigo, lo.Proteina, lo.Grado, lo.Humedad,
		lo.Pesohtl, lo.Impureza,
		lo.Dockage, lo.Vomitoxn, lo.Ergot, lo.Fllngnum, lo.Obsrv, lo.Otros, lo.EstadoId
		from sLotes lo inner join sUsuarios us1
			on lo.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on lo.Usrmod = us2.UsrId
		inner join sProveed pr
			on lo.ProvId = pr.ProvId
		inner join sTrigos tr
			on lo.TrigoId = tr.TrigoId
		where lo.LoteId = @Loteid
		
		
				
		return
	end

if @Opcion=8
select rd.OrdenId,ed.Nombre
			from sOrdenes rd inner join cEstados ed
			on rd.EstadoId = ed.EstadoId
			where rd.LoteId =@Loteid and ed.EstadoId in('C','L');
    begin
			
			
     
	        if @Docto is not null
			    begin
				      select 0 Exito, 'El lote ' + @Loteid + ' no puede ser cancelado,tiene ordenes abiertas o cerradas (orden ' + @Docto + ').' Mensaje

				   return
				end
		end

GO
/****** Object:  StoredProcedure [dbo].[PA_sOprador]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sOprador](
	@Opcion smallint,
	@Oprdorid varchar (10),
	@Nkname varchar (40),
	@Nombre varchar (50),
	@Activo bit,
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10),
	@Usridan varchar (10)
	)
	
as

	declare @pref varchar (3),
			@cantDig tinyint
	
	
	select @pref = 'R',
	@cantDig = 3
	
	
	if @Opcion=1
	begin
		select isnull ((select 'R' + right ('000' + convert(varchar(10),max (convert(int,replace(op.OprdorId,'R',''))) + 1),3)
						from sOprador op),'R000') Consecutivo

		 return 
	end


	-----INSERTA UN NUEVO ORIGEN
	if @Opcion=2
	begin
		insert into sOprador(OprdorId,Nkname,Nombre,Activo,Fchcrea,Usrcrea,Fchmod,
							 Usrmod,Usridan) 
		values (@Oprdorid,@Nkname,@Nombre,@Activo,@Fchcrea,@Usrcrea,@Fchmod,@Usrmod,
				@Usridan)

	   return
	end


	-----actualiza operador
	if @Opcion=3
	begin
		update sOprador set 
				Nkname = @Nkname,
				Nombre = @Nombre,
				Activo = @Activo,
				Fchmod = @Fchmod,
				Usrmod = @Usrmod
		where OprdorId = @Oprdorid
			 
	   return
	end
	
	

	-----consulta Operadorid
	if @Opcion=4
	begin
		select OprdorId, Nkname, Nombre, Activo, Fchcrea, Usrcrea, Fchmod, Usrmod, Usridan
		from sOprador
		where OprdorId=@OprdorId
		
		return
	end
	
	
	
	--Consulta el OprdorId anterior al actual
	if @Opcion = 5
	begin
		select @OprdorId = right (@OprdorId, len (@OprdorId) - len (@pref))
		
		if (select max (convert (int, right(OprdorId, len (OprdorId) - len (@pref))))
			from sOprador
			where convert (int, right(OprdorId, len (OprdorId) - len (@pref))) < @OprdorId) is not null
			select max (OprdorId) OprdorId
			from sOprador
			where convert (int, right(OprdorId, len (OprdorId) - len (@pref))) < @OprdorId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), max (convert (int, right(OprdorId, len (OprdorId) - len (@pref))))), @cantDig)
							from sOprador), @pref + right ('0000000001', @cantDig)) OprdorId
	
		return
	end

	
	
	
	--Consulta el OprdorId siguiente al actual
	if @opcion = 6
	begin
		select @OprdorId = right (@OprdorId, len (@OprdorId) - len (@pref))
		
		if (select min (convert (int, right(OprdorId, len (OprdorId) - len (@pref))))
		from sOprador
		where convert (int, right(OprdorId, len (OprdorId) - len (@pref))) > @OprdorId) is not null
			select min (OprdorId) OprdorId
			from sOprador
			where convert (int, right(OprdorId, len (OprdorId) - len (@pref))) > @OprdorId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), min (convert (int, right(OprdorId, len (OprdorId) - len (@pref))))), @cantDig)
							from sOprador), @pref + right ('0000000001', @cantDig)) OprdorId
	 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sOrdenes]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sOrdenes](
	@Opcion smallint,
	@Ordenid varchar (10),
	@Ctrtoid varchar (30),
	@Loteid varchar (10),
	@Origenid varchar (10),
	@Tnladas decimal (19,3),
	@Tlrancia varchar (30),
	@Peremb varchar (30),
	@Incoterm varchar (50),
	@Ritmo varchar (50),
	@Moneda varchar (10),
	@Refftro varchar (30),
	@Base decimal (19,4),
	@Mesfutu decimal (19,4),
	@Prcionto decimal (19,4),
	@Obsrv varchar (2000),
	@Laycan varchar (30),
	@Ptocarga varchar (50),
	@Ptodscg varchar (50),
	@Norcg varchar (20),
	@Nordscg varchar (20),
	@Laytime varchar (30),
	@Condpgo varchar (200),
	@Tasadmra varchar (20),
	@Usrmod varchar (10),
	@Usrcrea varchar (10),
	@Fchcrea datetime,
	@Fchmod datetime,
	@Estadoid char,
	@Provid varchar (10),
	@Fchord date,
	@Rspnsble varchar (50),
	@Ritmod varchar(50)
)

as
declare @docto varchar(20),
		@EstatusDoc varchar (10),
		@InstIdc smallint


	if @Opcion=1
	begin
		select 'O'+ right('0000000'+ convert(varchar(10),max(convert(int,replace(od.OrdenId,'O','')))+1),7)Consecutivo  from sOrdenes od 
		if @@ROWCOUNT=0
			select 'O0000001' Consecutivo
		return
	end



	--Validaciones de inserciones y modificaciones
	if @Opcion in (2, 3)
	begin
		if  @OrigenId = ''
		begin
			raiserror('Asocie un origen valido',11,0)
			return
		end

		if  @OrdenId = ''
		begin
			raiserror('Ingrese una orden',11,0)
			return
		end
		
		if  @LoteId = ''
		begin
			raiserror('Ingrese un lote',11,0)
			return
		end

		
		if (select estadoid from sOrdenes where @Ordenid=OrdenId)='L'
			begin
				 raiserror('La orden %s no se puede modificar porque has sido cancelada',11,0,@ordenid)
			return
			end
		if @Provid = ''
			set @Provid = NULL
		else
		begin
			if not exists (select ProvId 
						from sProveed 
						where ProvId = @Provid )
			begin
				raiserror('El Proveedore de flete %s no existe', 11, 0, @OrigenId)
				return
			end
		end
		
		
		if not exists (select origenid 
					from sOrigen 
					where Origenid = @Origenid )
		begin
			raiserror('El Origen %s no existe', 11, 0, @OrigenId)
			return
		end
		
		if not exists (select LoteId from sLotes where LoteId = @LoteId )
		begin
			raiserror('El Lote %s no existe', 11, 0, @LoteId)
			return
		end
		
	
	end
	
	--Insercion
	if @opcion=2
	begin
		insert into sOrdenes(OrdenId,CtrtoId,LoteId,OrigenId,Tnladas,Tlrancia,
					Peremb,Incoterm,Ritmo,Moneda,Refftro,Base,Mesfutu,Prcionto,
					Obsrv,Laycan,Ptocarga,Ptodscg,Norcg,Nordscg,Laytime,Condpgo,
					Tasadmra,Usrmod,Usrcrea,Fchcrea,Fchmod,EstadoId,ProvId,Fchord,Rspnsble,Ritmod)
		 values(@OrdenId,@CtrtoId,@LoteId,@OrigenId,@Tnladas,@Tlrancia,@Peremb,@Incoterm,
				@Ritmo,@Moneda,@Refftro,@Base,@Mesfutu,@Prcionto,@Obsrv,@Laycan,
				@Ptocarga,@Ptodscg,@Norcg,@Nordscg,@Laytime,@Condpgo,@Tasadmra,@Usrmod,@Usrcrea,
				getdate(),getdate(),@EstadoId,@ProvId,@Fchord,@Rspnsble,@Ritmod)	
		
		return			
	end


	--Actualiza una orden
	if @Opcion=3
	begin
		if exists (select og.EstadoId
					from sOrdenes og
					where og.OrdenId=@Ordenid
					and (og.EstadoId = 'L'
					or (og.EstadoId = 'C' and @Estadoid = 'C')))
			begin
				raiserror ('El ajuste %s no se puede modificar porque ha sido cancelado/cerrado.', 11, 0, @Origenid)
				return
			end
		
		if @Estadoid='L'
		begin
			select @docto=e1.Embid,@EstatusDoc=ed.Nombre 
			from sEmb1 e1 inner join cEstados ed
			on e1.EstadoId = ed.EstadoId 
			inner join sOrdenes od
			on e1.OrdenId=od.OrdenId
			where e1.OrdenId = @Ordenid
			and e1.EstadoId in ('C')
			

			if @docto is not null
			begin
				raiserror('La orden %s no puede ser cancelada porque tiene al menos un embarque asociado con Estado %s (%s)', 11, 0, @OrdenId, @EstatusDoc, @Docto)
			
				return
			end
			
			select @docto=aj.ajustid,@EstatusDoc=ed.Nombre 
			from sAjustes aj inner join cEstados ed
				on aj.EstadoId = ed.EstadoId 
			inner join sOrdenes od
				on aj.OrdenId=od.OrdenId
			where aj.OrdenId = @Ordenid
			and aj.EstadoId in ('C')

			if @docto is not null
			begin
				raiserror('La orden %s no puede ser cancelada porque tiene al menos un ajuste asociado con Estado %s (%s)', 11, 0, @OrdenId, @EstatusDoc, @Docto)
			
				return
			end

			select @docto=ve.ventaid,@EstatusDoc=ed.Nombre
			from sOrdenes od inner join sVentas ve
			on ve.ordenid=od.ordenid
			inner join cEstados ed
				on ve.EstadoId = ed.EstadoId
			and ve.EstadoId in ('C')
			if @docto is not null
			begin
				raiserror('La orden %s no puede ser cancelada porque tiene al menos un venta asociada con Estado %s (%s)', 11, 0, @Ordenid, @EstatusDoc, @Docto)
			
				return
			end
		end
			
		insert into sOrdenesh (InstId,Usrefect,Ordenid,Ctrtoid,Loteid,Origenid,Tnladas,Tlrancia,Peremb,
								Incoterm,Ritmo,Moneda,Refftro,Base,Mesfutu,Prcionto,Obsrv,Laycan,Ptocarga,Ptodscg,Norcg,
								Nordscg,Laytime,Condpgo,Tasadmra,Usrmod,Usrcrea,Fchcrea,Fchmod,Estadoid,Provid,Fchord,Rspnsble,Ritmod)
		select isnull((select max(InstId)+1
				from sOrdenesh 
				where Ordenid=@Ordenid),0) InstId, @Usrmod,OrdenId,CtrtoId,LoteId,OrigenId,Tnladas,Tlrancia,
			Peremb,Incoterm,Ritmo,Moneda,Refftro,Base,Mesfutu,Prcionto,
			Obsrv,Laycan,Ptocarga,Ptodscg,Norcg,Nordscg,Laytime,Condpgo,
			Tasadmra,Usrmod,Usrcrea,Fchcrea,Fchmod,EstadoId,ProvId,Fchord,Rspnsble,Ritmod
		from sOrdenes
		where Ordenid=@Ordenid

		update	sOrdenes 
		set CtrtoId = @Ctrtoid,
			LoteId = @Loteid,
			OrigenId = @Origenid,
			Tnladas = @Tnladas,
			Tlrancia = @Tlrancia,
			Peremb = @Peremb,
			Incoterm = @Incoterm,
			Ritmo = @Ritmo,
			Moneda = @Moneda,
			Refftro = @Refftro,
			Base = @Base,
			Mesfutu = @Mesfutu,
			Prcionto = @Prcionto,
			Obsrv = @Obsrv,
			Laycan = @Laycan,
			Ptocarga = @Ptocarga,
			Ptodscg = @Ptodscg,
			Norcg = @Norcg,
			Nordscg = @Nordscg,
			Laytime = @Laytime,
			Condpgo = @Condpgo,
			Tasadmra = @Tasadmra,
			Usrmod = @Usrmod,
			Fchmod = @Fchmod,
			EstadoId = @Estadoid, 
			ProvId = @Provid,
			Fchord = @Fchord,
			Rspnsble = @Rspnsble,
			Ritmod = @Ritmod
		where OrdenId=@Ordenid
			and Estadoid<>'L' 
		
		return
	end




	if @Opcion=4
	begin
		select rd.OrdenId, rd.CtrtoId, rd.LoteId, rd.OrigenId, og.Nombre Nmborigen, rd.Tnladas, rd.Tlrancia,
		rd.Peremb, rd.Incoterm, rd.Ritmo, rd.Moneda, rd.Refftro, rd.Base, rd.Mesfutu, rd.Prcionto,
		rd.Obsrv, rd.Laycan, rd.Ptocarga, rd.Ptodscg, rd.Norcg, rd.Nordscg, rd.Laytime, rd.Condpgo,
		rd.Tasadmra, rd.Usrmod, rd.Usrcrea, rd.Fchcrea, rd.Fchmod, rd.EstadoId, rd.ProvId, pr.Nombre Nmbprvfl,
		rd.Fchord, rd.Rspnsble, rd.Ritmod
		from sOrdenes rd inner join sOrigen og
			on rd.OrigenId = og.OrigenId
		left outer join sProveed pr
			on rd.ProvId = pr.ProvId
		where OrdenId=@Ordenid
	end



	--Consulta el OrdenId anterior al actual
	if @Opcion = 5
	begin
		select @OrdenId = right (@OrdenId, len (@OrdenId) - 1)
		
		if (select max (convert (int, right(OrdenId, len (OrdenId) - 1)))
			from sOrdenes
			where convert (int, right(OrdenId, len (OrdenId) - 1)) < @OrdenId) is not null
			select max (OrdenId) OrdenId
			from sOrdenes
			where convert (int, right(OrdenId, len (OrdenId) - 1)) < @OrdenId
		else
			select isnull ((select 'O' +
							right ('0000000' + convert (varchar (10), max (convert (int, right(OrdenId, len (OrdenId) - 1)))), 7)
							from sOrdenes), 'O0000001') OrdenId
	
		return
	end

	
	
	
	--Consulta el OrdenId siguiente al actual
	if @opcion = 6
	begin
		select @OrdenId = right (@OrdenId, len (@OrdenId) - 1)
		
		if (select min (convert (int, right(OrdenId, len (OrdenId) - 1)))
		from sOrdenes
		where convert (int, right(OrdenId, len (OrdenId) - 1)) > @OrdenId) is not null
			select min (OrdenId) OrdenId
			from sOrdenes
			where convert (int, right(OrdenId, len (OrdenId) - 1)) > @OrdenId
		else
			select isnull ((select 'O' +
							right ('0000000' + convert (varchar (10), min (convert (int, right(OrdenId, len (OrdenId) - 1)))), 7)
							from sOrdenes), 'O0000001') OrdenId
	 
		return
	end


	--Consulta todo el histórico de cambios sobre la Orden
	if @Opcion = 7
	begin
		select @InstIdc = max(InstId) + 1
		from sOrdenesh odh
		where odh.Ordenid = @OrdenId


		--Primeras 5 columnas se presentan en el visor de cambios
		select odh.InstId Instancia, odh.Fchord [Fecha de la Orden],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		odh.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		odh.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		odh.OrdenId, odh.CtrtoId, odh.LoteId, odh.OrigenId, og.Nombre Nmborigen, odh.Tnladas, odh.Tlrancia,
		odh.Peremb, odh.Incoterm, odh.Ritmo, odh.Moneda, odh.Refftro, odh.Base, odh.Mesfutu, odh.Prcionto,
		odh.Obsrv, odh.Laycan, odh.Ptocarga, odh.Ptodscg, odh.Norcg, odh.Nordscg, odh.Laytime, odh.Condpgo,
		odh.Tasadmra, odh.EstadoId, odh.ProvId, pr.Nombre Nmbprvfl,
		odh.Fchord, odh.Rspnsble,odh.Ritmod
		from sOrdenesh odh inner join sUsuarios us1
			on odh.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on odh.Usrmod = us2.UsrId
		inner join sOrigen og
			on odh.OrigenId = og.OrigenId
		left outer join sProveed pr
			on odh.ProvId = pr.ProvId
		where odh.OrdenId=@OrdenId
		--Valores de la instancia actual (tabla de documentos).
		union
		select isnull (@InstIdc, 0) Instancia, od.Fchord [Fecha de la Orden],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		od.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		od.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		od.OrdenId, od.CtrtoId, od.LoteId, od.OrigenId, og.Nombre Nmborigen, od.Tnladas, od.Tlrancia,
		od.Peremb, od.Incoterm, od.Ritmo, od.Moneda, od.Refftro, od.Base, od.Mesfutu, od.Prcionto,
		od.Obsrv, od.Laycan, od.Ptocarga, od.Ptodscg, od.Norcg, od.Nordscg, od.Laytime, od.Condpgo,
		od.Tasadmra, od.EstadoId, od.ProvId, pr.Nombre Nmbprvfl,
		od.Fchord, od.Rspnsble,od.Ritmod
		from sOrdenes od inner join sUsuarios us1
			on od.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on od.Usrmod = us2.UsrId
		inner join sOrigen og
			on od.OrigenId = og.OrigenId
		left outer join sProveed pr
			on od.ProvId = pr.ProvId
		where od.OrdenId=@OrdenId



		return

	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sOrdnes2]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from sOrdenes2

CREATE procedure [dbo].[PA_sOrdnes2](
	@Opcion smallint,
	@Ordenid varchar (10),
	@instid smallint,
	@Ruta text,
	@Coments text,
	@Extnsion varchar(10)


)
as

declare @maxinst smallint, @docto varchar(10)



--Insercion
if @Opcion= 2
	begin
		if @Ordenid = ''
			begin
				raiserror ('No se ha ingresado la orden', 11, 0)
				return
			end
		
		if not exists(select ordenid from sOrdenes where @ordenid=ordenid)
			begin
				raiserror ('La orden %s no existe, ingrese orden válida', 11, 0,@ordenid)
				return
			end
		select @maxinst=isnull((select max(InstId)+1
		from sOrdenes2
		where @Ordenid=OrdenId),0)
	
			insert into sOrdenes2(OrdenId,Ruta,Coments, extnsion,instId)
			values(@Ordenid,@Ruta,@Coments,@Extnsion,@maxinst)
	end

--Actualizacion
if @Opcion=3
	begin
		delete from sOrdenes2
		where OrdenId = @OrdenId
	end

--Consulta 
if @opcion=4
	begin 
		select ordenid, instid,ruta, coments, extnsion
		from sOrdenes2
		where @ordenid=ordenid
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sOrigen]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sOrigen](
	@Opcion smallint,
	@Origenid varchar (10),
	@Nombre varchar (500),
	@Activo bit,
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10),
	@Orgnidan varchar (10)
	
	)

as
	declare @pref varchar (3),
			@cantDig tinyint
	
	
	select @pref = 'RG',
	@cantDig = 4
	
	if @Opcion=1
		  begin
			  select isnull ((select 'RG' + right ('0000' + convert(varchar(20),max (convert(int,replace(og.OrigenId,'RG',''))) + 1),4)
							 from sOrigen og),'RG0001') Consecutivo

		 return 
	end
	
	---INSERTA UN NUEVO ORIGEN
	if @Opcion=2
		begin
			insert into sOrigen(OrigenId,Nombre,Activo,Fchcrea,Usrcrea,Fchmod,
								Usrmod,Orgnidan) 
			values (@Origenid,@Nombre,@Activo,@Fchcrea,@Usrcrea,@Fchmod,@Usrmod,
				   @Orgnidan)

		   return
	end
	
	---actualiza proveedor
	if @Opcion=3
		begin
			update sOrigen set 
			 Nombre = @Nombre,
			 Activo = @Activo,
			 Fchmod = getdate(),
			 Usrmod = @Usrmod

			 where OrigenId=@Origenid
		   return
	end

	---consulta origen
	if @Opcion=4
		begin
			select  OrigenId,Nombre,Activo,Orgnidan
			from sOrigen
			where OrigenId=@Origenid
		   return
	end
	
	
	
	--Consulta el OrigenId anterior al actual
	if @Opcion = 5
	begin
		select @OrigenId = right (@OrigenId, len (@OrigenId) - len (@pref))
		
		if (select max (convert (int, right(OrigenId, len (OrigenId) - len (@pref))))
			from sOrigen
			where convert (int, right(OrigenId, len (OrigenId) - len (@pref))) < @OrigenId) is not null
			select max (OrigenId) OrigenId
			from sOrigen
			where convert (int, right(OrigenId, len (OrigenId) - len (@pref))) < @OrigenId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), max (convert (int, right(OrigenId, len (OrigenId) - len (@pref))))), @cantDig)
							from sOrigen), @pref + right ('0000000001', @cantDig)) OrigenId
	
		return
	end

	
	
	
	--Consulta el OrigenId siguiente al actual
	if @opcion = 6
	begin
		select @OrigenId = right (@OrigenId, len (@OrigenId) - len (@pref))
		
		if (select min (convert (int, right(OrigenId, len (OrigenId) - len (@pref))))
		from sOrigen
		where convert (int, right(OrigenId, len (OrigenId) - len (@pref))) > @OrigenId) is not null
			select min (OrigenId) OrigenId
			from sOrigen
			where convert (int, right(OrigenId, len (OrigenId) - len (@pref))) > @OrigenId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), min (convert (int, right(OrigenId, len (OrigenId) - len (@pref))))), @cantDig)
							from sOrigen), @pref + right ('0000000001', @cantDig)) OrigenId
	 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sPrfls1]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sPrfls1](
			@Opcion smallint,
			@Perfilid varchar (10),
			@Nombre varchar (100),
			@Activo bit,
			@Fchcrea datetime,
			@Usrcrea varchar (10),
			@Fchmod datetime,
			@Usrmod varchar (10))

as

	
	
	if @Opcion=1
	begin
		  select isnull ((select convert(int,(max (p1.PerfilId)) + 1)
							 from sPrfls1 p1),0)Consecutivo

		 return 
	end
	
	
	
	if @opcion in (2,3)
	begin
		if not exists(select perfilid from sPrfls1 where PerfilId=@Perfilid)
		begin 
			insert into sPrfls1(PerfilId,Nombre,Activo,Fchcrea,Usrcrea,Fchmod,Usrmod)
			values (@Perfilid,@Nombre,@Activo,getdate(),@Usrcrea,getdate(),@Usrmod) 
		end
		else
			update sPrfls1
			set Nombre = @Nombre,
			Activo = @Activo,
			Fchmod = getdate(),
			Usrmod = @Usrmod
			where PerfilId = @PerfilId
	end

	


	if @Opcion=4
	begin
		select PerfilId,Nombre,Activo,Fchcrea,Usrcrea,Fchmod,Usrmod
		from sPrfls1
		where PerfilId=@PerfilId
	end
	
	
	
	--Consulta el PerfilId anterior al actual
	if @Opcion = 5
	begin
		if (select max (convert (int, PerfilId))
			from sPrfls1
			where convert (int, PerfilId) < @PerfilId) is not null
			select max (PerfilId) PerfilId
			from sPrfls1
			where convert (int, PerfilId) < @PerfilId
		else
			select isnull ((select convert (varchar (10), max (convert (int, PerfilId)))
							from sPrfls1), 0) PerfilId
	
		return
	end

	
	
	
	--Consulta el PerfilId siguiente al actual
	if @opcion = 6
	begin
		if (select min (convert (int, PerfilId))
		from sPrfls1
		where convert (int, PerfilId) > @PerfilId) is not null
			select min (PerfilId) PerfilId
			from sPrfls1
			where convert (int, PerfilId) > @PerfilId
		else
			select isnull ((select convert (varchar (10), min (convert (int, PerfilId)))
							from sPrfls1), 0) PerfilId
	 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sPrfls2]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sPrfls2](
			@Opcion smallint,
			@Perfilid varchar (10),
			@Opcionid smallint,
			@Activo bit,
			@Consulta bit,
			@Mdfccion bit,
			@Creacion bit,
			@Cnlacion bit,
			@Cierre bit)

as



	if @opcion in (2,3)
	begin
		if not exists(select perfilid
						from sPrfls2
						where PerfilId=@Perfilid
						and OpcionId = @Opcionid)
		begin
			insert into sPrfls2(PerfilId,OpcionId,Activo,Consulta,Mdfccion,Creacion,Cnlacion,Cierre)
			values (@Perfilid,@Opcionid,@Activo,@Consulta,@Mdfccion,@Creacion,@Cnlacion,@Cierre )
		
			return
		end
		else
		update sPrfls2
		set OpcionId = @Opcionid,
			Activo = @Activo,
			Consulta = @Consulta,
			Mdfccion = @Mdfccion,
			Creacion = @Creacion,
			Cnlacion = @Cnlacion,
			Cierre = @Cierre
			where PerfilId = @Perfilid
			and OpcionId = @Opcionid
		return
	end


	if @Opcion=4
	begin
		if exists (select p2.PerfilId
						from sPrfls2 p2
						where PerfilId = @PerfilId)
			select pc.NmbMost, pc.OpcionId, pc.Opcnidp, pc.Prmsosap,
			p2.Activo, p2.Consulta, p2.Mdfccion, p2.Creacion,
			p2.Cnlacion, p2.Cierre
			from cOpcsist pc left outer join sPrfls2 p2
				  on pc.OpcionId = p2.OpcionId
			where p2.PerfilId = @PerfilId
			order by pc.VisId
		else
			select pc.NmbMost, pc.OpcionId, pc.Opcnidp, pc.Prmsosap,
			p2.Activo, p2.Consulta, p2.Mdfccion, p2.Creacion,
			p2.Cnlacion, p2.Cierre
			from cOpcsist pc left outer join sPrfls2 p2
				  on pc.OpcionId = p2.OpcionId
			where p2.PerfilId = 1
			order by pc.VisId
			
			
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sProveed]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sProveed](
	@Opcion smallint,
	@Provid varchar (10),
	@Nombre varchar (500),
	@Calle varchar (250),
	@Noext varchar (40),
	@Noint varchar (40),
	@Colonia varchar (100),
	@Rferenc varchar (100),
	@Lcalidad varchar (80),
	@Mnicipio varchar (100),
	@Estado varchar (100),
	@Pais varchar (100),
	@Cdgpstl varchar (30),
	@Cntcto varchar (500),
	@Tpoprvid varchar (10),
	@Providan varchar (20),
	@Activo bit,
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10),
	@Cardcode nvarchar
	)


as

declare @docto varchar(20), @emb varchar(20), @trigo varchar(20)

	
	--Consecutivo siguiente
	if @Opcion = 1
	begin
		select isnull ((select 'P' + right ('00000' + convert (varchar (20), max (convert (int, replace(pr.ProvId, 'P', ''))) + 1), 5)
						from sProveed pr), 'P00001') Consecutivo	

				
		return
	end



	--Inserta un nuevo proveedor
	if @Opcion = 2
	begin
		insert into sProveed (ProvId, Nombre, Calle, Noext, Noint, Colonia, Rferenc, Lcalidad, Mnicipio,
							Estado, Pais, Cdgpstl, Cntcto, TpoprvId, Providan, Activo, Fchcrea, Usrcrea,
							Fchmod, Usrmod)
		values (@Provid, @Nombre, @Calle, @Noext, @Noint, @Colonia, @Rferenc, @Lcalidad, @Mnicipio,
				@Estado, @Pais, @Cdgpstl, @Cntcto, @Tpoprvid, @Providan, @Activo, getdate(), @Usrcrea,
				getdate(), @Usrmod)

		return
	end



	--Actualiza un proveedor
	if @Opcion = 3
	begin
		if exists (select ProvId
					from SProveed pr
					where pr.ProvId = @Provid
					and pr.TpoprvId <> @Tpoprvid)
		begin
			
			if @Tpoprvid <> 'T002'
			begin
				select @docto=Provflet, @emb=EmbId 
				from semb1 
				where ProvFlet=@provid and estadoid<>'L'
				
				if  @docto is not null
				begin
					raiserror ('El Proveedor %s ya tiene asociado un flete <<Embarque (%s)>> y no puede actualizar su tipo', 11, 0, @provid,@emb)
					return
				end
			end
			
			
			select @docto=provid, @trigo=tr.TrigoId from sLotes lo inner join sTrigos tr on 
						tr.trigoid=lo.trigoid
						where  lo.provid=@provid and tr.activo=1
			if  @docto is not null 
			begin
					raiserror ('El Proveedor %s ya tiene asociado Trigo Activo (%s) y no puede actualizar su tipo ', 11, 0, @provid, @trigo)
				return
			end

			select @docto=od.provid, @emb=od.OrdenId from sOrdenes od
			where  od.provid=@provid and od.EstadoId <>'L'

			if  @docto is not null 
			begin
					raiserror ('El Proveedor %s ya tiene asociado un flete maritimo (%s) y no puede actualizar su tipo ', 11, 0, @provid, @emb)
				return
			end
		end
		
		update sProveed
		set Nombre = @Nombre,
		Calle = @Calle,
		Noext = @Noext,
		Noint = @Noint,
		Colonia = @Colonia,
		Rferenc = @Rferenc,
		Lcalidad = @Lcalidad,
		Mnicipio = @Mnicipio,
		Estado = @Estado,
		Pais = @Pais,
		Cdgpstl = @Cdgpstl,
		Cntcto = @Cntcto,
		TpoprvId = @Tpoprvid,
		Activo = @Activo,
		Fchmod = getdate(),
		Usrmod = @Usrmod
		where ProvId = @Provid
		
		 return
	end




	--Consulta un proveedor
	if @Opcion = 4
	begin
		select ProvId, Nombre, Calle, Noext, Noint, Colonia, Rferenc, Lcalidad, Mnicipio, Estado, Pais,
		Cdgpstl, Cntcto, TpoprvId, Activo
		from sProveed
		where ProvId = @Provid


		return
	end
	
	
	

	--Consulta el ProvId anterior al actual
	if @Opcion = 5
	begin
		select @ProvId = right (@ProvId, len (@ProvId) - 1)
		
		if (select max (convert (int, right(ProvId, len (ProvId) - 1)))
			from sProveed
			where convert (int, right(ProvId, len (ProvId) - 1)) < @ProvId) is not null
			select max (ProvId) ProvId
			from sProveed
			where convert (int, right(ProvId, len (ProvId) - 1)) < @ProvId
		else
			select isnull ((select 'P' +
							right ('00000' + convert (varchar (10), max (convert (int, right(ProvId, len (ProvId) - 1)))), 5)
							from sProveed), 'P00001') ProvId
	
		return
	end

	
	
	
	--Consulta el ProvId siguiente al actual
	if @opcion = 6
	begin
		select @ProvId = right (@ProvId, len (@ProvId) - 1)
		
		if (select min (convert (int, right(ProvId, len (ProvId) - 1)))
		from sProveed
		where convert (int, right(ProvId, len (ProvId) - 1)) > @ProvId) is not null
			select min (ProvId) ProvId
			from sProveed
			where convert (int, right(ProvId, len (ProvId) - 1)) > @ProvId
		else
			select isnull ((select 'P' +
							right ('00000' + convert (varchar (10), min (convert (int, right(ProvId, len (ProvId) - 1)))), 5)
							from sProveed), 'P00001') ProvId
	 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sRprte]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sRprte](
	@Opcion smallint,
	@Rprteid smallint
	)
	
as


	if @Opcion = 1
	begin
		select r1.RprteId, r1.Titulo [Título], r1.Activo, r1.Nmbrpt, r1.Fchint [Fecha Integración], Fchmod, OpcionId
		from sRprte1 r1
		where r1.Activo = 1
		
		return
	end

	
	
	
	if @opcion = 2
	begin
		select r2.ParamId, r2.Nmbparam, r2.Dscrpcion, r2.TpodatId, r2.TpodocId, r2.RprteId, r2.Leyenda, r2.Activo,
		dbo.[FE_Valordefp](r2.TpodatId, r2.TpodocId, r2.Valordef) Defecto, r2.Rqrido
		from sRprte2 r2
		where r2.rprteId = @RprteId
		and r2.Activo = 1
		
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sSmtp]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sSmtp](
	@Opcion smallint,
	@Smtpid varchar (10),
	@Nombre varchar (100),
	@Smtsrv varchar (50),
	@Smtpprto varchar (10),
	@Ssltls bit,
	@Vldcert bit,
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10)
	)
	
as
select *from sSmtp
if @Opcion=1
      begin
		  select isnull ((select convert(int,(max (sm.SmtpId)) + 1)
		                 from sSmtp sm),0)Consecutivo

	 return 
end


---------inserta nuevo sSmtp
if @Opcion=2
    begin
	    insert into sSmtp(SmtpId,Nombre,Smtsrv,Smtpprto,Ssltls,Vldcert,Fchcrea,Usrcrea,Fchmod,Usrmod) 
	    values (@Smtpid,@Nombre,@Smtsrv,@Smtpprto,@Ssltls,@Vldcert, getdate(),@Usrcrea, getdate(),@Usrmod)

       return
end

---------actualiza sSmtp
if @Opcion=3
    begin
	    update sSmtp set 
				Nombre = @Nombre,
				Smtsrv = @Smtsrv,
				Smtpprto = @Smtpprto,
				Ssltls = @Ssltls,
				Vldcert = @Vldcert,
				Fchmod = getdate(),
				Usrmod = @Usrmod
			 where SmtpId = @Smtpid
       return
end
---validar que cuando se valla cancelar unn lote que no halla lotes abiertos

-------consulta sSmtp
if @Opcion=4
    begin
	    select   SmtpId,Nombre,Smtsrv,Smtpprto,Ssltls,Vldcert,Fchcrea,Usrcrea,Fchmod,Usrmod
		from sSmtp
        where SmtpId=@SmtpId
       return
end

GO
/****** Object:  StoredProcedure [dbo].[PA_sTrigos]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sTrigos](
		@Opcion smallint,
		@Trigoid varchar (10),
		@Nombre varchar (100),
		@Activo bit,
		@Fchcrea datetime,
		@Usrcrea varchar (10),
		@Fchmod datetime,
		@Usrmod varchar (10),
		@Itemcode nvarchar,
		@Trgoidan varchar (10))

as
	--Obtiene consecutivo siguiente
	if (@Opcion=1)
	begin
		select 'T'+ right('000'+ convert(varchar(10),max(convert(int,replace(tr.TrigoId,'T','')))+1),3)Consecutivo  from sTrigos tr 
		if @@ROWCOUNT=0
			select 'T0001' Consecutivo
		return
	end

	--Insercion
	if @opcion=2
	begin
		--select @TrigoId='T'+ right('000'+ convert(varchar(10),max(convert(int,replace(tr.TrigoId,'T','')))+1),3)  from sTrigos tr 
		insert into sTrigos(TrigoId,Nombre, Activo,Fchcrea,Usrcrea,Fchmod,Usrmod,ItemCode)
		 values(@Trigoid,@Nombre,@Activo,getdate(),@Usrcrea,getdate(),@Usrmod,@Itemcode)	
		
		return
	end

	--Actualiza un Trigo
	if @Opcion=3
	begin
		update	sTrigos
		set Nombre = @Nombre,
		Activo = @Activo,
		Fchmod = getdate(),
		Usrmod = @Usrmod,
		ItemCode = @Itemcode
		where TrigoId=@Trigoid
		
		return			
	end


	if @Opcion=4
	begin
		select TrigoId,Nombre, Activo,ItemCode,Trgoidan 
		from sTrigos
		where TrigoId=@Trigoid
		
		return
	end



	--Consulta el TrigoId anterior al actual
	if @Opcion = 5
	begin
		select @TrigoId = right (@TrigoId, len (@TrigoId) - 1)
		
		if (select max (convert (int, right(TrigoId, len (TrigoId) - 1)))
			from sTrigos
			where convert (int, right(TrigoId, len (TrigoId) - 1)) < @TrigoId) is not null
			select max (TrigoId) TrigoId
			from sTrigos
			where convert (int, right(TrigoId, len (TrigoId) - 1)) < @TrigoId
		else
			select isnull ((select 'T' +
							right ('000' + convert (varchar (10), max (convert (int, right(TrigoId, len (TrigoId) - 1)))), 3)
							from sTrigos), 'T001') TrigoId
	
		return
	end

	
	
	
	--Consulta el TrigoId siguiente al actual
	if @opcion = 6
	begin
		select @TrigoId = right (@TrigoId, len (@TrigoId) - 1)
		
		if (select min (convert (int, right(TrigoId, len (TrigoId) - 1)))
		from sTrigos
		where convert (int, right(TrigoId, len (TrigoId) - 1)) > @TrigoId) is not null
			select min (TrigoId) TrigoId
			from sTrigos
			where convert (int, right(TrigoId, len (TrigoId) - 1)) > @TrigoId
		else
			select isnull ((select 'T' +
							right ('000' + convert (varchar (10), min (convert (int, right(TrigoId, len (TrigoId) - 1)))), 3)
							from sTrigos), 'T001') TrigoId
	 
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_sUsuarios]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[PA_sUsuarios](
	@Opcion smallint,
	@Usrid varchar (10),
	@Nkname varchar (40),
	@Nombre varchar (50),
	@Apllidop varchar (50),
	@Apllidom varchar (50),
	@Cntrsnia varchar (30),
	@Perfilid varchar (10),
	@Puestoid varchar (10),
	@Ltimoacc datetime,
	@Correoe varchar (60),
	@Cntrscoe varchar (50),
	@Smtpid varchar (10),
	@Activo bit,
	@Fchcrea datetime,
	@Usrcrea varchar (10),
	@Fchmod datetime,
	@Usrmod varchar (10),
	@Usridan varchar (10),
	@OprdorId varchar (10)
)
as

--validacion de que el estado del doc. pueda estar de abierto a cerrado o de cerrado a abierto 
--pero no puede pasar de cancelado abierto ni a cerrado
--Consecutivo siguiente
	if @Opcion=1
	begin
---		select isnull((select 'U' + right('000'+convert(varchar(20), max(convert(int,replace(usr.UsrId, 'U', '')))+1),3)
---		from sUsuarios usr), '001')  CONSECUTIVO
        select isnull((select max(convert(int,usr.UsrId))+1  from sUsuarios usr ),'0') CONSECUTIVO
	return
	end
	
	
	if @Opcion in (2,3)
	begin
		if isnull(ltrim(rtrim(@Smtpid)), '') = ''
			set @Smtpid = NULL
		
		if isnull(ltrim(rtrim(@OprdorId)), '') = '' 
			set @OprdorId = NULL
	end
		
			
--Insa un nuevo registro
	if @Opcion =2
	begin
		insert into sUsuarios (UsrId, Nkname, Nombre, Apllidop, Apllidom, Cntrsnia, PerfilId, PuestoId, Ltimoacc, Correoe,
							Cntrscoe, SmtpId, Activo, Fchcrea, Usrcrea, Fchmod, Usrmod, Usridan,OprdorId) 
		values (@Usrid, @Nkname, @Nombre, @Apllidop, @Apllidom, @Cntrsnia, @Perfilid, @Puestoid, getdate(), @Correoe, @Cntrscoe,
				@Smtpid, @Activo, getdate(), @Usrcrea, getdate(), @Usrmod, @Usridan,@OprdorId)
	return
	end
	
	
	
--Actualiza un destino
	if @opcion =3
	begin
		update sUsuarios
		set Nkname = @Nkname,
			Nombre = @Nombre,
			Apllidop = @Apllidop,
			Apllidom = @Apllidom,
			Cntrsnia = @Cntrsnia,
			PerfilId = @Perfilid,
			PuestoId = @Puestoid,
			Ltimoacc = getdate(),
			Correoe = @Correoe,
			Cntrscoe = @Cntrscoe,
			SmtpId = @Smtpid,
			Activo = @Activo,
			OprdorId = @OprdorId,
			Fchmod = getdate(),
			Usrmod = @Usrmod
		where UsrId = @Usrid

		RETURN

	end

--Consulta un destino
	if @Opcion=4
	begin
		select UsrId, Nkname, Nombre, Apllidop, Apllidom, Cntrsnia, PerfilId, PuestoId, Ltimoacc, Correoe, Cntrscoe,
				SmtpId, Activo, Fchcrea, Usrcrea, Fchmod, Usrmod, Usridan,OprdorId
		from sUsuarios
		where UsrId = @UsrId;
		return
	end



	--Consulta el UsrId anterior al actual
	if @Opcion = 5
	begin
		if (select max (convert (int, UsrId))
			from sUsuarios
			where UsrId < convert (int, @UsrId)) is not null
			select max (convert (int, UsrId)) UsrId
			from sUsuarios
			where UsrId < convert (int, @UsrId)
		else
			select isnull ((select max (convert (int, UsrId))
							from sUsuarios), 0) UsrId
	
		return
	end

	
	
	
	--Consulta el UsrId siguiente al actual
	if @opcion = 6
	begin
		if (select min (convert (int, UsrId))
		from sUsuarios
		where convert (int, UsrId) > convert (int, @UsrId)) is not null
			select min (convert (int, UsrId)) UsrId
			from sUsuarios
			where UsrId > convert (int, @UsrId)
		else
			select isnull ((select min (convert (int, UsrId))
							from sUsuarios), 0) UsrId
	 
		return
	end
	
	
	
	if @Opcion = 7
	begin
		if not exists(select us.Nkname
						from sUsuarios us
						where us.Nkname = @Nkname)
		begin
			raiserror('El usuario %s no existe.',11,0,@Nkname)
			return
		end
		
		
		select us.UsrId, us.Cntrsnia
		from sUsuarios us
		where us.Nkname = @Nkname
		
		return
	end
	
	
	
		if @opcion =8
		begin
			update sUsuarios
			set Ltimoacc = getdate()
			where UsrId = @Usrid

			RETURN

		end
GO
/****** Object:  StoredProcedure [dbo].[PA_sVentas]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_sVentas](
		@Opcion smallint,
		@Ventaid varchar (10),
		@Tonventa decimal (19,3),
		@Ordenid varchar (10),
		@Fchventa date,
		@Estadoid char,
		@Obsrv varchar (1000),
		@Fchcrea datetime,
		@Fchmod datetime,
		@Usrcrea varchar (10),
		@Usrmod varchar (10))

as


	declare @pref varchar (3),
			@cantDig tinyint,
			@InstIdC smallint
	
	
	select @pref = 'V',
	@cantDig = 7


	if @Opcion=1
	begin
		select 'V'+ right('0000000'+ convert(varchar(10),max(convert(int,replace(ve.VentaId,'V','')))+1),7)Consecutivo 
		from sVentas ve 
		
		if @@ROWCOUNT=0
			select 'V0000001' Consecutivo
			
		return
	end




	if @opcion=2
	begin
		insert into sVentas (VentaId,Tonventa,OrdenId,Fchventa,EstadoId,Obsrv,Fchcrea,Fchmod,Usrcrea,Usrmod)
		values (@Ventaid,@Tonventa,@Ordenid,@Fchventa,@Estadoid,@Obsrv,getdate(),getdate(),@Usrcrea,@Usrmod)
	end




	if @Opcion=3
	begin

	if (select estadoid from sVentas where @ventaid=ventaId)='L'
		begin
				 raiserror('La venta %s no se puede modificar porque ha sido cancelada',11,0,@ventaid)
			return
		end
		
		insert into sVentash(InstId,Usrefect,VentaId,Tonventa,OrdenId,Fchventa,EstadoId,Obsrv,Fchcrea,Fchmod,Usrcrea,Usrmod)
		select isnull((select max(InstId)+1
				from sVentash
				where VentaId=@Ventaid),0) InstId,@Usrmod,VentaId,Tonventa,OrdenId,Fchventa,EstadoId,Obsrv,Fchcrea,Fchmod,Usrcrea,@Usrmod
			from sVentas
			where VentaId=@Ventaid
		
		update sVentas 
		set Tonventa = @Tonventa,
			Fchventa = @Fchventa,
			EstadoId = @Estadoid,
			Obsrv = @Obsrv,
			Fchmod = getdate(),
			Usrmod = @Usrmod
		where VentaId = @Ventaid
			and EstadoId<>'L'
	end 



	if @Opcion=4
	begin
		select VentaId,Tonventa,OrdenId,Fchventa,EstadoId,Obsrv,Fchcrea,Fchmod,Usrcrea,Usrmod
		from sVentas
		where VentaId=@VentaId 
	end
	
	
	
	--Consulta el VentaId anterior al actual
	if @Opcion = 5
	begin
		select @VentaId = right (@VentaId, len (@VentaId) - len (@pref))
		
		if (select max (convert (int, right(VentaId, len (VentaId) - len (@pref))))
			from sVentas
			where convert (int, right(VentaId, len (VentaId) - len (@pref))) < @VentaId) is not null
			select max (VentaId) VentaId
			from sVentas
			where convert (int, right(VentaId, len (VentaId) - len (@pref))) < @VentaId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), max (convert (int, right(VentaId, len (VentaId) - len (@pref))))), @cantDig)
							from sVentas), @pref + right ('0000000001', @cantDig)) VentaId
	
		return
	end

	
	
	
	--Consulta el VentaId siguiente al actual
	if @opcion = 6
	begin
		select @VentaId = right (@VentaId, len (@VentaId) - len (@pref))
		
		if (select min (convert (int, right(VentaId, len (VentaId) - len (@pref))))
		from sVentas
		where convert (int, right(VentaId, len (VentaId) - len (@pref))) > @VentaId) is not null
			select min (VentaId) VentaId
			from sVentas
			where convert (int, right(VentaId, len (VentaId) - len (@pref))) > @VentaId
		else
			select isnull ((select @pref +
							right ('0000000000' + convert (varchar (10), min (convert (int, right(VentaId, len (VentaId) - len (@pref))))), @cantDig)
							from sVentas), @pref + right ('0000000001', @cantDig)) VentaId
	 
		return
	end

	--Consulta todo el histórico de cambios sobre el Lote
	if @Opcion = 7
	begin
		select @InstIdc = max(InstId) + 1
		from sVentash veh
		where veh.VentaId = @Ventaid
		--Primeras 5 columnas se presentan en el visor de cambios
		select veh.InstId Instancia, veh.Fchventa [Fecha de Venta],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		veh.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		veh.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		veh.VentaId,veh.Tonventa,veh.OrdenId,veh.Fchventa,veh.EstadoId,veh.Obsrv
		from sVentash veh inner join sUsuarios us1
			on veh.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on veh.Usrmod = us2.UsrId
		where  veh.VentaId=@Ventaid
		--Valores de la instancia actual (tabla de documentos).
		union
		select isnull(@InstIdC,0) Instancia, ve.Fchventa [Fecha de Venta],
		isnull (us1.Nombre, '') + ' ' + isnull (us1.Apllidop, '') + ' ' + isnull (us1.Apllidom, '') [Creó],
		ve.Fchcrea [Fecha Creación],
		isnull (us2.Nombre, '') + ' ' + isnull (us2.Apllidop, '') + ' ' + isnull (us2.Apllidom, '') [Modificó],
		ve.Fchmod [Fecha Modificación],
		--Columnas siguientes son para comparar y presentar cambios. Deben corresponder con las columnas de la opción 4.
		ve.VentaId,ve.Tonventa,ve.OrdenId,ve.Fchventa,ve.EstadoId,ve.Obsrv
		from sVentas ve inner join sUsuarios us1
			on ve.Usrcrea = us1.UsrId
		inner join sUsuarios us2
			on ve.Usrmod = us2.UsrId
		where  ve.VentaId=@Ventaid
		
		
		return
	end

GO
/****** Object:  StoredProcedure [dbo].[PA_Vtasactestado]    Script Date: 05/10/2017 12:27:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[PA_Vtasactestado](
	@Ordenid varchar (10),
	@Estadoid char
	)

as


	--Declaración de variables de entrada
	declare @Ventaid varchar (10),
	@Tonventa decimal (19,3),
	@Fchventa date,
	@Obsrv varchar (1000),
	@Fchcrea datetime,
	@Fchmod datetime,
	@Usrcrea varchar (10),
	@Usrmod varchar (10),
	@Nuevoest char
	
	
	set @Nuevoest = @Estadoid
		
	
	
	--Declaración del cursor
	DECLARE CursorTipos CURSOR
	FOR
		--Consulta de entrada
		select VentaId,Tonventa,OrdenId,Fchventa, EstadoId,Obsrv,Fchcrea,Fchmod,Usrcrea,Usrmod
		from sVentas ve
		where OrdenId = @Ordenid
		
	OPEN CursorTipos
	FETCH CursorTipos INTO @Ventaid,@Tonventa,@Ordenid,@Fchventa,@Estadoid,@Obsrv,@Fchcrea,@Fchmod,@Usrcrea,@Usrmod

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		--Actualización masiva
		 
		 if @Nuevoest <> @Estadoid and @Estadoid <> 'L'

		exec[PA_sVentas] 3, @Ventaid,@Tonventa,@Ordenid,@Fchventa,@Nuevoest,@Obsrv,@Fchcrea,@Fchmod,@Usrcrea,@Usrmod
		
		FETCH CursorTipos INTO @Ventaid,@Tonventa,@Ordenid,@Fchventa,@Estadoid,@Obsrv,@Fchcrea,@Fchmod,@Usrcrea,@Usrmod
	END 

	--Cerrar cursor
	CLOSE CursorTipos
	DEALLOCATE CursorTipos

GO
