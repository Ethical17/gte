$PBExportHeader$w_gteprof011.srw
forward
global type w_gteprof011 from window
end type
type em_1 from editmask within w_gteprof011
end type
type em_3 from editmask within w_gteprof011
end type
type st_3 from statictext within w_gteprof011
end type
type st_2 from statictext within w_gteprof011
end type
type ddlb_2 from dropdownlistbox within w_gteprof011
end type
type st_1 from statictext within w_gteprof011
end type
type cb_4 from commandbutton within w_gteprof011
end type
type cb_3 from commandbutton within w_gteprof011
end type
type cb_2 from commandbutton within w_gteprof011
end type
type cb_1 from commandbutton within w_gteprof011
end type
type dw_2 from datawindow within w_gteprof011
end type
type dw_1 from datawindow within w_gteprof011
end type
end forward

global type w_gteprof011 from window
integer width = 3616
integer height = 2432
boolean titlebar = true
string title = "(w_gteprof011) Production At Other Estate"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
em_3 em_3
st_3 st_3
st_2 st_2
ddlb_2 ddlb_2
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_gteprof011 w_gteprof011

type variables
long ll_ctr,net, ll_cnt,l_ctr,ll_last,ll_user_level,ll_last1, ll_season
string ls_temp,ls_del_ind,ls_sup_id,ls_tmp_id,ls_entry_user,ls_ddp_pk, ls_id,ls_sup, ls_tpc_id,ls_id1
boolean lb_neworder, lb_query
double ld_gdw_qnty,ld_qty,ld_tqty,ld_sqty,ld_st_tmqty,ld_glfp,ld_rec,ld_tmqnty,ld_st_old_tmqty
datetime ld_rundt,ld_stkdt,ld_pluckdt

end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
	case "SAVEAS"
			this.dw_1.saveas()
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose


end event

on w_gteprof011.create
this.em_1=create em_1
this.em_3=create em_3
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.em_3,&
this.st_3,&
this.st_2,&
this.ddlb_2,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_gteprof011.destroy
destroy(this.em_1)
destroy(this.em_3)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false

//DECLARE c1 CURSOR FOR  
//select distinct trunc(PLUCKINGDATE) from fb_gltransaction 
//where not exists (select distinct trunc(GLFP_PLUCKINGDATE) from fb_glforproduction where trunc(GLFP_PLUCKINGDATE) = trunc(PLUCKINGDATE)) and gt_type in ('TRANSFER','SALE') and
//		trunc(PLUCKINGDATE) >= to_date('01/01/2011','dd/mm/yyyy') 
//order by trunc(PLUCKINGDATE) desc;
//
//open c1;
//	
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ld_pluckdt;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_1.additem(string(ld_pluckdt,'dd/mm/yyyy'))
//		fetch c1 into :ld_pluckdt;
//	loop
//
//END IF
//close c1;

DECLARE c2 CURSOR FOR  
select distinct trunc(GLFP_PLUCKINGDATE) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
where glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='O' order by trunc(GLFP_PLUCKINGDATE) desc;

open c2;
	
IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ld_pluckdt;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ld_pluckdt,'dd/mm/yyyy'))
		fetch c2 into :ld_pluckdt;
	loop

END IF
close c2;

this.tag = Message.StringParm
ll_user_level = long(this.tag)
em_3.text = string(today(),'YYYY')
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type em_1 from editmask within w_gteprof011
integer x = 411
integer y = 12
integer width = 471
integer height = 104
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_3 from editmask within w_gteprof011
integer x = 1088
integer y = 20
integer width = 197
integer height = 84
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type st_3 from statictext within w_gteprof011
integer x = 855
integer y = 28
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Season :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteprof011
integer x = 1623
integer y = 32
integer width = 293
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Query Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gteprof011
integer x = 1938
integer y = 16
integer width = 480
integer height = 1000
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gteprof011
integer x = 18
integer y = 32
integer width = 384
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Production  Date"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gteprof011
integer x = 2967
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gteprof011
integer x = 2702
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 
ll_last = 0;

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'gwtm_teamade')) or dw_1.getitemnumber(ll_ctr,'gwtm_teamade') = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next
	
	for ll_ctr = dw_2.rowcount() to 1 step -1
		IF (isnull(dw_2.getitemnumber(ll_ctr,'ddu_quantity')) or dw_2.getitemnumber(ll_ctr,'ddu_quantity') = 0) THEN
			 dw_2.deleterow(ll_ctr)
		END IF
	next
	
	if dw_2.getitemnumber(1,'dr_tmade') <> dw_1.getitemnumber(1,'sp_tmade') then
		messagebox('Warning!','Source Wise Tea Made Quantity Should be Equal To Dryer Wise Tea Made Quantity, Please Check !!!')
		return 1
	end if
	
	if dw_2.rowcount() > 0 then
		if lb_neworder = true then
				ll_last1 = 0
				if ll_last1=0 then
					select nvl(MAX(substr(DDP_PK,4,10)),0) into :ll_last1 from FB_DAILYDRYERPRODUCT;
				end if
				ll_last1 = ll_last1 + 1
				ls_id1 = 'DDP'+string(ll_last1,'0000000000')
				for ll_ctr = 1 to dw_2.rowcount( ) 
					dw_2.setitem(ll_ctr,'ddp_pk',ls_id1)
				next
				ld_rundt = datetime(em_1.text)
				
				Insert into FB_DAILYDRYERPRODUCT
					(DRYER_ID, DDP_RUNHOURS, DDP_STARTRUNTIME, DDP_ENDRUNTIME, DDP_PLUCKINGDATE, 
					 DDP_CONFIRMFLAG, DDP_PK, DDP_TYPE, DDP_ENTRY_BY, DDP_ENTRY_DT)
				 Values('MAC0035', 0, TO_DATE('01/01/1900', 'DD/MM/YYYY'), TO_DATE('01/01/1900', 'DD/MM/YYYY'), :ld_rundt, 
					 		'1', :ls_id1, 'O',:gs_user, sysdate);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Into FB_DAILYDRYERPRODUCT ',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
		end if
	end if
	ll_last = 0;
	if dw_1.rowcount() > 0 then		 
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! or  dw_1.getitemstatus(ll_ctr,0,primary!) = DataModified! then
				if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then
					if ll_last=0 then
						select nvl(MAX(substr(GLFP_PK,4,10)),0) into :ll_last from fb_glforproduction;
					end if
					ll_last = ll_last + 1
					ls_id = 'GFP'+string(ll_last,'0000000000')
					dw_1.setitem(ll_ctr,'glfp_pk',ls_id)
				end if		
				ld_gdw_qnty = dw_1.getitemnumber(ll_ctr,'gwtm_teamade')
				ld_st_old_tmqty = dw_1.getitemnumber(ll_ctr,'oldqnty')
				ls_id = dw_1.getitemstring(ll_ctr,'glfp_pk')
				ld_rundt = datetime(em_1.text)
				ll_season = long(em_3.text)
				
				setnull(ls_temp)
				
				select distinct 'x' into :ls_temp from fb_gardenwiseteamade where glfp_pk = :ls_id;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting gardenwiseteamade Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 100 then
					insert into fb_gardenwiseteamade(GWTM_TEAMADE, GWTM_TYPE, GLFP_PK, GWTM_SEASON) values(:ld_gdw_qnty,'O',:ls_id,:ll_season);
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Inserting Record In gardenwiseteamade Table !!!',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				elseif sqlca.sqlcode  = 0 then
					update fb_gardenwiseteamade 
						 set GWTM_TEAMADE = (nvl(GWTM_TEAMADE,0) - nvl(:ld_st_old_tmqty,0) + nvl(:ld_gdw_qnty,0))
					where  glfp_pk = :ls_id;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Record In gardenwiseteamade Table !!!',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				end if		
			end if
		next		
	end if
	
	if dw_1.update(true,false) = 1 and dw_2.update(true,false) = 1 then
		dw_1.resetupdate();
		dw_2.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
		dw_2.reset()
//		ddlb_1.reset()
//		DECLARE c1 CURSOR FOR  
//		select distinct trunc(PLUCKINGDATE) from fb_gltransaction 
//		where not exists (select distinct trunc(GLFP_PLUCKINGDATE) from fb_glforproduction where trunc(GLFP_PLUCKINGDATE) = trunc(PLUCKINGDATE) and gt_type in ('TRANSFER','SALE')) and
//				trunc(PLUCKINGDATE) >= to_date('01/01/2011','dd/mm/yyyy') 
//		order by trunc(PLUCKINGDATE) desc;
//		
//		open c1;
//			
//		IF sqlca.sqlcode = 0 THEN
//			fetch c1 into :ld_pluckdt;
//			
//			do while sqlca.sqlcode <> 100
//				ddlb_1.additem(string(ld_pluckdt,'dd/mm/yyyy'))
//				fetch c1 into :ld_pluckdt;
//			loop
//		
//		END IF
//		close c1;
		
		ddlb_2.reset()
		DECLARE c2 CURSOR FOR  
		select distinct trunc(GLFP_PLUCKINGDATE) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
		where glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='O' order by trunc(GLFP_PLUCKINGDATE) desc;
		
		open c2;
			
		IF sqlca.sqlcode = 0 THEN
			fetch c2 into :ld_pluckdt;
			
			do while sqlca.sqlcode <> 100
				ddlb_2.additem(string(ld_pluckdt,'dd/mm/yyyy'))
				fetch c2 into :ld_pluckdt;
			loop
		
		END IF
		close c2;
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteprof011
integer x = 2437
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if isnull(ddlb_2.text) then
	messagebox('Warning!','Please Select A Query Date First !!!')
	return 1
end if

ld_rundt = datetime(ddlb_2.text)


lb_query = false
dw_1.settransobject(sqlca)
dw_1.SetRedraw (FALSE)
dw_1.Object.datawindow.querymode = 'no'
dw_1.Retrieve(string(ld_rundt,'dd/mm/yyyy'))
dw_2.Retrieve(string(ld_rundt,'dd/mm/yyyy'))
dw_1.TriggerEvent(rowfocuschanged!)
dw_1.SetRedraw (TRUE)

lb_neworder = false
end event

type cb_1 from commandbutton within w_gteprof011
integer x = 1349
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
end if
dw_2.reset()

dw_1.settransobject(sqlca)
setnull(ld_rundt)
dw_2.settransobject(sqlca)

if isnull(em_1.text) then
	messagebox('Warning!','Please Select A Plucking Date First !!!')
	return 1
end if

ll_season = long(em_3.text)

if isnull(ll_season) or ll_season = 0 or len(em_3.text) = 0  then
	messagebox('Warning !','Please Enter The Season !!!')
	return 1
end if

ld_rundt = datetime(em_1.text)

if date(ld_rundt) > date(today()) then
	messagebox('Warning !','Production Date Should Not Be Greater Than Current Date !!!')
	return 1
end if

select distinct 'x' into :ls_temp from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
where glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='O' and trunc(GLFP_PLUCKINGDATE) = trunc(:ld_rundt);

if sqlca.sqlcode = -1 then
	messagebox('Error : While Checking Production Entry',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	messagebox('Warning!','Production Entry Already Done For This Date, Please Check !!!')
	return 1
end if	

//09/04/2012
//	select distinct gtsupid ,sum(decode(gt_type,'TRANSFER',nvl(gltq,0),0)) transfer, sum(decode(gt_type,'SALE',nvl(gltq,0),0)) Sale, sum(nvl(gltq,0)) netgl
//		from (	select glt.sup_id gtsupid,glt.gt_type,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//				 where GLT.pluckingdate <= trunc(:ld_rundt) and glt.gt_type in ('TRANSFER','SALE') and
//						 GLT.pluckingdate > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and (exists 
//						(select SUP_ID from fb_leafanalysis where LA_DATE = (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and sup_id = glt.sup_id))
//				group by glt.sup_id,glt.gt_type)
//	group by gtsupid;
////09/04/2012
//(not isnull(ld_tmqnty) or ld_tmqnty > 0) and
if gs_garden_snm <> 'GP' and gs_garden_snm <> 'MV' and gs_garden_snm <> 'LP' and  gs_garden_snm <> 'MR' and  gs_garden_snm <> 'SP' and  gs_garden_snm <> 'AB' and gs_garden_snm <> 'AD' and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR'  then
	if  dw_1.rowcount() = 0 then
		setnull(ls_sup); ld_tqty = 0; ld_sqty = 0;ld_qty = 0;
		
		DECLARE c1 CURSOR FOR  
		select distinct gtsupid ,sum(decode(gt_type,'TRANSFER',nvl(gltq,0),0)) transfer, sum(decode(gt_type,'SALE',nvl(gltq,0),0)) Sale, sum(nvl(gltq,0)) netgl
			from (select glt.sup_id gtsupid,glt.gt_type,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
					 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and trunc(GLT.pluckingdate) > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
																																		where  glfp.glfp_pk=gwtm.glfp_pk and gwtm_type='O')   and
							  glt.gt_type in ('TRANSFER','SALE')
					group by glt.sup_id,glt.gt_type)
		group by gtsupid;
		
		open c1;
		IF sqlca.sqlcode = 0 THEN
			fetch c1 into :ls_sup,:ld_tqty,:ld_sqty,:ld_qty;
			if sqlca.sqlcode <> 0 then
				messagebox('SQL EROR',sqlca.sqlerrtext)
			end if
			do while sqlca.sqlcode <> 100
			
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'sup_id',ls_sup)
				dw_1.setitem(dw_1.getrow(),'glfp_gl_tqty',ld_tqty)
				dw_1.setitem(dw_1.getrow(),'glfp_gl_sqty',ld_sqty)
				dw_1.setitem(dw_1.getrow(),'glfp_glforproduction',ld_qty)
				dw_1.setitem(dw_1.getrow(),'glfp_gl_qty',ld_qty)
				dw_1.setitem(dw_1.getrow(),'glfp_pluckingdate',ld_rundt)
				
				setnull(ls_sup);ld_tqty = 0;ld_sqty = 0;ld_qty = 0;
				fetch c1 into :ls_sup,:ld_tqty,:ld_sqty,:ld_qty;
			loop
		END IF
		close c1;
	//	dw_1.setfocus()
	//	dw_1.scrolltorow(1)
	//	dw_1.setcolumn('gwtm_teamade')
	end if
elseif  gs_garden_snm = 'GP' or  gs_garden_snm = 'MV' or gs_garden_snm = 'LP' or  gs_garden_snm = 'MR' or  gs_garden_snm = 'SP' or  gs_garden_snm = 'AB' or gs_garden_snm = 'AD' or gs_garden_snm = 'MH'  or gs_garden_snm = 'DR'  then
	if  dw_1.rowcount() = 0 then
		setnull(ls_sup); ld_tqty = 0; ld_sqty = 0;ld_qty = 0;
		
		DECLARE c3 CURSOR FOR  
		select distinct gtsupid ,sum(decode(gt_type,'TRANSFER',nvl(gltq,0),0)) transfer, sum(decode(gt_type,'SALE',nvl(gltq,0),0)) Sale, sum(nvl(gltq,0)) netgl
			from (select glt.sup_id gtsupid,glt.gt_type,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
					 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and trunc(GLT.pluckingdate) > nvl((select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
																																		where  glfp.glfp_pk=gwtm.glfp_pk and gwtm_type='O'),'01-Mar-2014')   and
							  glt.gt_type in ('TRANSFER','SALE')
					group by glt.sup_id,glt.gt_type)
		group by gtsupid;
		
		open c3;
		IF sqlca.sqlcode = 0 THEN
			fetch c3 into :ls_sup,:ld_tqty,:ld_sqty,:ld_qty;
//			if sqlca.sqlcode <> 0 then
//				messagebox('SQL EROR',sqlca.sqlerrtext)
//			end if
			do while sqlca.sqlcode <> 100
			
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'sup_id',ls_sup)
				dw_1.setitem(dw_1.getrow(),'glfp_gl_tqty',ld_tqty)
				dw_1.setitem(dw_1.getrow(),'glfp_gl_sqty',ld_sqty)
				dw_1.setitem(dw_1.getrow(),'glfp_glforproduction',ld_qty)
				dw_1.setitem(dw_1.getrow(),'glfp_gl_qty',ld_qty)
				dw_1.setitem(dw_1.getrow(),'glfp_pluckingdate',ld_rundt)
				
				setnull(ls_sup);ld_tqty = 0;ld_sqty = 0;ld_qty = 0;
				fetch c3 into :ls_sup,:ld_tqty,:ld_sqty,:ld_qty;
			loop
		END IF
		close c3;
	//	dw_1.setfocus()
	//	dw_1.scrolltorow(1)
	//	dw_1.setcolumn('gwtm_teamade')
	end if
end if


if not isnull(ld_rundt)  then
	DECLARE c2 CURSOR FOR  
	select distinct TPC_ID from fb_teamadeproductcategory where TPC_ACTIVE_IND = 'Y' order by TPC_ID;
	
	open c2;
		
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_tpc_id;
		
		do while sqlca.sqlcode <> 100
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'tpc_id',ls_tpc_id)
			dw_2.setitem(dw_2.getrow(),'ddp_dt',ld_rundt)
			fetch c2 into :ls_tpc_id;
		loop
	END IF
	close c2;
end if
dw_2.setfocus()
dw_2.scrolltorow(1)
dw_2.setcolumn('tpc_id')

lb_neworder = true
lb_query = false



end event

type dw_2 from datawindow within w_gteprof011
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 3561
integer height = 696
integer taborder = 80
string dataobject = "dw_gteprof011a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'ddu_quantity' then
	//dw_1.reset()
	ld_tmqnty = double(data)
	ld_rundt = datetime(em_1.text)
	
	if ld_tmqnty <= 0 then
		messagebox('Warning!','Tea Pack Quantity Must Be > 0, Please Check !!!')
		return 1
	end if
end if

cb_3.enabled = true
end event

event clicked;//if dwo.name = 'b_1' then	
//	if (not isnull(ld_tmqnty) or ld_tmqnty > 0) and dw_1.rowcount() = 0 then
//		DECLARE c1 CURSOR FOR  
//		select distinct gtsupid ,decode(gt_type,'TRANSFER',nvl(gltq,0),0) transfer, decode(gt_type,'SALE',nvl(gltq,0),0) Sale, nvl(gltq,0) netgl
//			from (	select glt.sup_id gtsupid,glt.gt_type,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//					 where GLT.pluckingdate <= trunc(:ld_rundt) and glt.gt_type in ('TRANSFER','SALE') and
//							 GLT.pluckingdate > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and (exists 
//							(select SUP_ID from fb_leafanalysis where LA_DATE = (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and sup_id = glt.sup_id))
//					group by glt.sup_id,glt.gt_type) ;
//		
//		open c1;
//			
//		IF sqlca.sqlcode = 0 THEN
//			fetch c1 into :ls_sup,:ld_tqty,:ld_sqty,:ld_qty;
//			
//			do while sqlca.sqlcode <> 100
//				dw_1.scrolltorow(dw_1.insertrow(0))
//				dw_1.setitem(dw_1.getrow(),'sup_id',ls_sup)
//				dw_1.setitem(dw_1.getrow(),'glfp_gl_tqty',ld_tqty)
//				dw_1.setitem(dw_1.getrow(),'glfp_gl_sqty',ld_sqty)
//				dw_1.setitem(dw_1.getrow(),'glfp_glforproduction',ld_qty)
//				dw_1.setitem(dw_1.getrow(),'glfp_gl_qty',ld_qty)
//				dw_1.setitem(dw_1.getrow(),'glfp_pluckingdate',ld_rundt)
//				
//				setnull(ls_sup);ld_tqty = 0;ld_sqty = 0;ld_qty = 0;
//				fetch c1 into :ls_sup,:ld_tqty,:ld_sqty,:ld_qty;
//			loop
//		END IF
//		close c1;
//		dw_1.setfocus()
//		dw_1.scrolltorow(1)
//		dw_1.setcolumn('gwtm_teamade')
//	end if
//end if
end event

type dw_1 from datawindow within w_gteprof011
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 820
integer width = 3566
integer height = 1504
integer taborder = 40
string dataobject = "dw_gteprof011"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;//if lb_query = false then
// if lb_neworder = true then	
//	
//	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
//		dw_1.setitem(newrow,'et_entry_by',gs_user)
//		dw_1.setitem(newrow,'et_entry_dt',datetime(today()))
//		dw_1.setcolumn('et_excess_tea')
//	end if
// end if
//end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if

end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if

end event

event itemchanged;if dwo.name = 'gwtm_teamade' then
	ld_st_tmqty = double(data)
	ld_glfp = dw_1.getitemnumber(row,'glfp_glforproduction')
	ld_rec = round(((ld_st_tmqty * 100) / ld_glfp),2)
	dw_1.setitem(row,'recov_per',ld_rec)
end if

cb_3.enabled = true
end event

