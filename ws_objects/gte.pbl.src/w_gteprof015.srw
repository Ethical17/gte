$PBExportHeader$w_gteprof015.srw
forward
global type w_gteprof015 from window
end type
type em_3 from editmask within w_gteprof015
end type
type em_2 from editmask within w_gteprof015
end type
type st_5 from statictext within w_gteprof015
end type
type st_4 from statictext within w_gteprof015
end type
type ddlb_2 from dropdownlistbox within w_gteprof015
end type
type st_3 from statictext within w_gteprof015
end type
type ddlb_1 from dropdownlistbox within w_gteprof015
end type
type st_2 from statictext within w_gteprof015
end type
type em_1 from editmask within w_gteprof015
end type
type st_1 from statictext within w_gteprof015
end type
type dp_1 from datepicker within w_gteprof015
end type
type cb_4 from commandbutton within w_gteprof015
end type
type cb_3 from commandbutton within w_gteprof015
end type
type cb_2 from commandbutton within w_gteprof015
end type
type cb_1 from commandbutton within w_gteprof015
end type
type dw_1 from datawindow within w_gteprof015
end type
end forward

global type w_gteprof015 from window
integer width = 3621
integer height = 2280
boolean titlebar = true
string title = "(w_gteprof015) Excess Tea"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_3 em_3
em_2 em_2
st_5 st_5
st_4 st_4
ddlb_2 ddlb_2
st_3 st_3
ddlb_1 ddlb_1
st_2 st_2
em_1 em_1
st_1 st_1
dp_1 dp_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteprof015 w_gteprof015

type variables
long ll_ctr,net, ll_cnt,l_ctr,ll_last,ll_last1,ll_user_level, ll_rank,ll_season
string ls_temp,ls_del_ind,ls_sup_id,ls_tmp_id,ls_entry_user,ls_ddp_pk, ls_id,ls_supid, ls_season
boolean lb_neworder, lb_query
double ld_gdw_qnty,ld_gdw_oldqnty,ld_totqnty, ld_stkqnty,ld_glqty, ld_glper, ld_extea, ld_decbal, ld_intbal,ld_ndecbal, ld_ownsupbal,ld_tot,ld_old
datetime ld_rundt,ld_stkdt,ld_last_stocktake_dt

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

on w_gteprof015.create
this.em_3=create em_3
this.em_2=create em_2
this.st_5=create st_5
this.st_4=create st_4
this.ddlb_2=create ddlb_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.em_1=create em_1
this.st_1=create st_1
this.dp_1=create dp_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_3,&
this.em_2,&
this.st_5,&
this.st_4,&
this.ddlb_2,&
this.st_3,&
this.ddlb_1,&
this.st_2,&
this.em_1,&
this.st_1,&
this.dp_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteprof015.destroy
destroy(this.em_3)
destroy(this.em_2)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.ddlb_2)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
//dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

em_2.text = right(string(today()),4)

setpointer(hourglass!)
declare c1 cursor for
select distinct TPC_NAME||'                             ('||TPC_ID||')',TPC_RANK from fb_teamadeproductcategory 
where nvl(TPC_ACTIVE_IND,'Y') = 'Y' order by TPC_RANK;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_tmp_id, :ll_rank;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_tmp_id)
		fetch c1 into:ls_tmp_id, :ll_rank;
	loop
	close c1;
end if

em_2.text = string(today(),'YYYY')

ddlb_2.reset()

DECLARE c2 CURSOR FOR  
select distinct ET_STOCK_DATE from fb_excess_tea order by 1 desc;

open c2;
	
IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ld_rundt;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ld_rundt,'dd/mm/yyyy'))
		fetch c2 into :ld_rundt;
	loop

END IF
close c2;

setpointer(Arrow!)
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

type em_3 from editmask within w_gteprof015
integer x = 439
integer y = 16
integer width = 411
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_2 from editmask within w_gteprof015
integer x = 2683
integer y = 16
integer width = 247
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
boolean spin = true
string displaydata = "~t/"
double increment = 1
string minmax = "2000~~2999"
end type

type st_5 from statictext within w_gteprof015
integer x = 2510
integer y = 32
integer width = 169
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Season"
boolean focusrectangle = false
end type

type st_4 from statictext within w_gteprof015
integer x = 37
integer y = 128
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

type ddlb_2 from dropdownlistbox within w_gteprof015
integer x = 352
integer y = 116
integer width = 480
integer height = 1000
integer taborder = 50
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

type st_3 from statictext within w_gteprof015
integer x = 846
integer y = 32
integer width = 306
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tea Category"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteprof015
integer x = 1170
integer y = 12
integer width = 603
integer height = 376
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type st_2 from statictext within w_gteprof015
integer x = 1801
integer y = 32
integer width = 366
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Excess Tea(Kgs)"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gteprof015
integer x = 2185
integer y = 16
integer width = 261
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####.00"
end type

type st_1 from statictext within w_gteprof015
integer x = 14
integer y = 32
integer width = 430
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stock Taking  Date"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteprof015
boolean visible = false
integer x = 443
integer y = 20
integer width = 384
integer height = 84
integer taborder = 10
boolean border = true
boolean enabled = false
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-10-01"), Time("14:23:16.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_4 from commandbutton within w_gteprof015
integer x = 1381
integer y = 112
integer width = 265
integer height = 100
integer taborder = 80
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

type cb_3 from commandbutton within w_gteprof015
integer x = 1115
integer y = 112
integer width = 265
integer height = 100
integer taborder = 70
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
ll_last = 0; ll_last1 = 0;
IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'et_excess_tea')) or dw_1.getitemnumber(ll_ctr,'et_excess_tea') = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next	
	for ll_ctr = 1 to dw_1.rowcount() 
		if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then 
			
			if ll_last=0 then
				select nvl(MAX(substr(GLFP_PK,4,10)),0) into :ll_last from fb_glforproduction;
			end if
			
			if ll_last1=0 then
				select nvl(MAX(substr(DDP_PK,4,10)),0) into :ll_last1 from fb_dailydryerproduct;
			end if
	
			for ll_ctr = 1 to dw_1.rowcount( ) 
				ll_last = ll_last + 1
				ls_id = 'GFP'+string(ll_last,'0000000000')
				dw_1.setitem(ll_ctr,'glfp_pk',ls_id)
				
				ll_last1 = ll_last1 + 1
				ls_ddp_pk = 'DDP'+string(ll_last1,'0000000000')
				ls_tmp_id = dw_1.getitemstring(ll_ctr,'tpc_id')
				ld_stkdt = dw_1.getitemdatetime(ll_ctr,'et_stock_date')
				ld_gdw_qnty = dw_1.getitemnumber(ll_ctr,'et_excess_tea')
				ld_gdw_oldqnty = dw_1.getitemnumber(ll_ctr,'oldexcesstea')
			 	ll_season = long(em_2.text)
				
//				select distinct 'x' into :ls_temp from fb_dailydryerproduct where DDP_PK = :ls_ddp_pk;
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Dryer Id Detail',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode  = 100 then
					insert into fb_dailydryerproduct(DRYER_ID, DDP_RUNHOURS, DDP_STARTRUNTIME, DDP_ENDRUNTIME, 
															 DDP_PLUCKINGDATE, DDP_CONFIRMFLAG, DDP_PK, DDP_TYPE) 
					values('EXCESS',0,:ld_stkdt,:ld_stkdt,trunc(:ld_stkdt),'0',:ls_ddp_pk,'E');
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Inserting Record In Dailydryerproduct Table !!!',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if					
	
//				end if
	
				select distinct 'x' into :ls_temp from FB_DAILYDRYERUNSORTED where DDP_PK = :ls_ddp_pk and TPC_ID = :ls_tmp_id;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Machine Running Details !!!',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 100 then
					insert into FB_DAILYDRYERUNSORTED(DDP_PK, TPC_ID, DDU_QUANTITY,DDP_DT, DDP_SEASON) values(:ls_ddp_pk,:ls_tmp_id,:ld_gdw_qnty,:ld_stkdt,:ll_season);
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Inserting Record In DAILYDRYERUNSORTED Table !!!',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if					
				elseif sqlca.sqlcode  = 0 then
					update FB_DAILYDRYERUNSORTED set DDU_QUANTITY = nvl(DDU_QUANTITY,0)  - nvl(:ld_gdw_oldqnty,0) + nvl(:ld_gdw_qnty,0),DDP_DT = :ld_stkdt
					  where DDP_PK = :ls_ddp_pk and TPC_ID = :ls_tmp_id;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Record In DAILYDRYERUNSORTED Table !!!',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				end if		
			next	
		end if		
	next
	
	if dw_1.rowcount() >= 1 then
		for ll_ctr = 1 to dw_1.rowcount()
			ls_tmp_id = dw_1.getitemstring(ll_ctr,'tpc_id')
			ld_stkdt = dw_1.getitemdatetime(ll_ctr,'et_stock_date')
			ld_gdw_qnty = dw_1.getitemnumber(ll_ctr,'et_excess_tea')
			ls_id = dw_1.getitemstring(ll_ctr,'glfp_pk')
			ls_sup_id = dw_1.getitemstring(ll_ctr,'et_estate')
			
			select distinct 'x' into :ls_temp from fb_glforproduction where glfp_pk = :ls_id;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting glforproduction Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then
				insert into fb_glforproduction(GLFP_PLUCKINGDATE, GLFP_GLFORPRODUCTION, SUP_ID, GLFP_PK, GLFP_GL_QTY) 
				values(:ld_stkdt,0,:ls_sup_id,:ls_id,0);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Record In glforproduction Table !!!',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if	
			
			select distinct 'x' into :ls_temp from fb_gardenwiseteamade where glfp_pk = :ls_id;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting gardenwiseteamade Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then
				insert into fb_gardenwiseteamade(GWTM_TEAMADE, GWTM_TYPE, GLFP_PK, GWTM_SEASON) values(:ld_gdw_qnty,'E',:ls_id,:ll_season);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Record In gardenwiseteamade Table !!!',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif sqlca.sqlcode  = 0 then
				update fb_gardenwiseteamade set GWTM_TEAMADE = (nvl(GWTM_TEAMADE,0) - nvl(:ld_gdw_oldqnty,0)  + nvl(:ld_gdw_qnty,0)) , GWTM_TYPE = 'E', GLFP_PK = :ls_id
				where  glfp_pk = :ls_id;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Record In gardenwiseteamade Table !!!',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if		
		next		
	end if
	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteprof015
integer x = 850
integer y = 112
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;//if date(dp_1.text) > date(today()) then
//	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
//	return 1
//end if

ld_rundt = datetime(ddlb_2.text)

//select distinct 'x' into :ls_temp from fb_excess_tea where trunc(ET_STOCK_DATE) = trunc(:ld_rundt);
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Exces Tea Detail',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//elseif sqlca.sqlcode  = 100 then
//	messagebox('Warning!','Excess Tea Data For Selected Date Not Exists, Please Check !!!')
//	return 1
//end if

//if cb_2.text = "&Query" then
//	lb_neworder = true
//	if dw_1.modifiedcount() > 0 then
//		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
//			return 1
//		end if
//	end if
//	dw_1.reset()
//	dw_1.settaborder('et_estate',5)
//	dw_1.settaborder('et_stock_date',7)
//	lb_query = true
//	dw_1.modify("datawindow.queryclear= yes")
//	dw_1.Object.datawindow.querymode= 'yes'
//	dw_1.SetFocus ()
//	dw_1.setcolumn('et_estate')
//	cb_2.text = "&Run"
//	cb_1.enabled = false
//	cb_3.enabled = false
//else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,date(ld_rundt))
	dw_1.settaborder('et_estate',0)
	dw_1.settaborder('et_stock_date',0)
	dw_1.SetRedraw (TRUE)
//	cb_2.text = "&Query"
	cb_1.enabled = true
//end if

end event

type cb_1 from commandbutton within w_gteprof015
integer x = 2967
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
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
dw_1.reset()
//dw_1.reset()

dw_1.settransobject(sqlca)

if date(em_3.text) > date(today()) then
	messagebox('Warning!','Stock Taking Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Category, Please Check !!!')
	return 1
end if

if isnull(em_1.text) or em_1.text = '0.00' or long(em_1.text) <= 0 then
	messagebox('Warning!','Please Enter the Stock Quantity (> 0), Please Check !!!')
	return 1
end if

ld_rundt = datetime(em_3.text)
ls_tmp_id = left(right(ddlb_1.text,8),7)

select max(ET_STOCK_DATE) into :ld_last_stocktake_dt 
from fb_excess_tea where ET_STOCK_DATE < :ld_rundt;

if sqlca.sqlcode = -1 then
	messagebox('SQL Error: during Last Stock Taking Date',sqlca.sqlerrtext)
	return 1
end if

ls_season = em_2.text
		
//and not exists (select distinct et_estate from fb_excess_tea b where trunc(ET_STOCK_DATE) = trunc(:ld_rundt) and b.et_estate = a.SUP_ID)
		
DECLARE c1 CURSOR FOR  
select  SUP_ID,SUM(nvl(GT_QUANTITY,0)) glqty from fb_gltransaction a 
 where to_char(GT_DATE,'YYYY') = :ls_season and GT_TYPE in ('OWNATTE','PURCHASE','BROUGHT') and
		gt_date between nvl(:ld_last_stocktake_dt,to_date('01/01/'||:ls_season,'dd/mm/yyyy')) and trunc(:ld_rundt)  
group by SUP_ID
order by SUP_ID;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_sup_id,:ld_glqty;
	
	do while sqlca.sqlcode <> 100
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'et_estate',ls_sup_id)
		dw_1.setitem(dw_1.getrow(),'et_gl_qty',ld_glqty)
		dw_1.setitem(dw_1.getrow(),'et_stock_date',date(em_3.text))
		dw_1.setitem(dw_1.getrow(),'tpc_id',ls_tmp_id)
		dw_1.setitem(dw_1.getrow(),'et_season',long(ls_season))
		dw_1.setitem(dw_1.getrow(),'et_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'et_entry_dt',datetime(today()))
		fetch c1 into :ls_sup_id,:ld_glqty;
	loop
END IF
close c1;
dw_1.setfocus()
dw_1.scrolltorow(1)

select UNIT_SUPID into :ls_supid from fb_gardenmaster where UNIT_ACTIVE_IND = 'Y';
if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During Selecting Own Supplier',sqlca.sqlerrtext)
	return 1
end if

for ll_ctr = 1 to dw_1.rowcount()
	ld_glqty = dw_1.getitemnumber(dw_1.getrow(),'totalgl')
	ld_glper = dw_1.getitemnumber(ll_ctr,'et_gl_qty')
	ls_sup_id = dw_1.getitemstring(ll_ctr,'et_estate')
////	
//	ld_extea = ((ld_glper/ld_glqty) * 100) * double(em_1.text) * 0.01
//	dw_1.setitem(ll_ctr,'et_excess_tea',ld_extea)
////	
	if isnull(ld_glper) then ld_glper = 0;
	ld_ndecbal = 0
	ld_extea = ((ld_glper/ld_glqty) * 100) * double(em_1.text) * 0.01
	if ls_supid <> ls_sup_id then
		ld_intbal = truncate(ld_extea,0)
		ld_decbal = ld_extea - truncate(ld_extea,0)
		dw_1.setitem(ll_ctr,'et_excess_tea',ld_intbal)
		ld_ndecbal = ld_ndecbal + ld_decbal
	else
		ld_ownsupbal = ld_extea
	end if
next
ld_ownsupbal = round((ld_ownsupbal + ld_ndecbal),0)
for ll_ctr = 1 to dw_1.rowcount()
	ls_sup_id = dw_1.getitemstring(ll_ctr,'et_estate')
	if ls_supid = ls_sup_id then 
		dw_1.setitem(ll_ctr,'et_excess_tea',ld_ownsupbal)
	end if
next
dw_1.setcolumn('tpc_id')
lb_neworder = true
lb_query = false



end event

type dw_1 from datawindow within w_gteprof015
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 220
integer width = 3506
integer height = 1940
string dataobject = "dw_gteprof015"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'et_entry_by',gs_user)
		dw_1.setitem(newrow,'et_entry_dt',datetime(today()))
		dw_1.setcolumn('et_excess_tea')
	end if
 end if
end if

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
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event itemchanged;if lb_query = false then
	ld_tot = dw_1.getitemnumber(row,'tot_qnty')
	ld_old = dw_1.getitemnumber(row,'et_excess_tea')
	if dwo.name = 'et_excess_tea' then
		ld_totqnty = double(data) + ld_tot - ld_old
		ld_stkqnty = double(em_1.text)
		if ld_totqnty > ld_stkqnty then
			messagebox('Warning!','Total Quantity Should Not Be > Stock Quantity, Please Check !!!')
			return 1
		end if
	end if
	cb_3.enabled = true
end if
end event

