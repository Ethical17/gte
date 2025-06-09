$PBExportHeader$w_gteprof010.srw
forward
global type w_gteprof010 from window
end type
type em_3 from editmask within w_gteprof010
end type
type st_3 from statictext within w_gteprof010
end type
type cb_6 from commandbutton within w_gteprof010
end type
type dp_1 from datepicker within w_gteprof010
end type
type st_2 from statictext within w_gteprof010
end type
type ddlb_2 from dropdownlistbox within w_gteprof010
end type
type cb_1 from commandbutton within w_gteprof010
end type
type st_1 from statictext within w_gteprof010
end type
type dw_3 from datawindow within w_gteprof010
end type
type cb_5 from commandbutton within w_gteprof010
end type
type cb_7 from commandbutton within w_gteprof010
end type
type cb_8 from commandbutton within w_gteprof010
end type
type cb_9 from commandbutton within w_gteprof010
end type
type dw_2 from datawindow within w_gteprof010
end type
type cb_4 from commandbutton within w_gteprof010
end type
type cb_3 from commandbutton within w_gteprof010
end type
type cb_2 from commandbutton within w_gteprof010
end type
type dw_1 from datawindow within w_gteprof010
end type
end forward

global type w_gteprof010 from window
integer width = 3703
integer height = 2364
boolean titlebar = true
string title = "(w_gteprof010) Production"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_3 em_3
st_3 st_3
cb_6 cb_6
dp_1 dp_1
st_2 st_2
ddlb_2 ddlb_2
cb_1 cb_1
st_1 st_1
dw_3 dw_3
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_gteprof010 w_gteprof010

type variables
long ll_ctr, ll_cnt,l_ctr,ix,ll_user_level,ll_last,ll_season
string ls_temp,ls_mac_id,ls_tmp_id,ls_entry_user,ls_cons,ls_last,ls_count,ls_pk,ls_sup,ls_glpk,ls_ddp_pk,ls_ownind
boolean lb_neworder, lb_query
double ld_tmqnty,ld_st_tmqty, ld_glfp,ld_rec,ld_qty,ld_gdw_qnty,ld_st_old_tmqty,ld_netqnty, ld_totqty, ld_ratio, ld_purchase, ld_transfer, ld_receive, ld_purtot, ld_sale, ld_opn, ld_gl
datetime ld_rundt,ld_appr_dt,ld_startdt,ld_enddt, ld_pluckdt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_resetdates ()
end prototypes

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

public function integer wf_check_fillcol (integer fl_row);if dw_3.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_3.getitemnumber(fl_row,'glfp_glforproduction')) or dw_3.getitemnumber(fl_row,'glfp_glforproduction') = 0 or &
		 isnull(dw_3.getitemnumber(fl_row,'gwtm_teamade')) or dw_3.getitemnumber(fl_row,'gwtm_teamade') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Green Leaf Used For Production, Tea Made, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_resetdates ();		ddlb_2.reset()
		
		DECLARE c2 CURSOR FOR  
		select distinct trunc(GLFP_PLUCKINGDATE) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
		where glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N' order by trunc(GLFP_PLUCKINGDATE) desc;
		
		open c2;
			
		IF sqlca.sqlcode = 0 THEN
			fetch c2 into :ld_pluckdt;
			
			do while sqlca.sqlcode <> 100
				ddlb_2.additem(string(ld_pluckdt,'dd/mm/yyyy'))
				fetch c2 into :ld_pluckdt;
			loop
		
		END IF
		close c2;
	return 1
end function

on w_gteprof010.create
this.em_3=create em_3
this.st_3=create st_3
this.cb_6=create cb_6
this.dp_1=create dp_1
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.em_3,&
this.st_3,&
this.cb_6,&
this.dp_1,&
this.st_2,&
this.ddlb_2,&
this.cb_1,&
this.st_1,&
this.dw_3,&
this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_gteprof010.destroy
destroy(this.em_3)
destroy(this.st_3)
destroy(this.cb_6)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
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
dw_3.settransobject(sqlca)
lb_query = false	
lb_neworder = false

//DECLARE c1 CURSOR FOR  
//select distinct trunc(PLUCKINGDATE) from fb_gltransaction 
//where not exists (select distinct trunc(GLFP_PLUCKINGDATE) from fb_glforproduction where trunc(GLFP_PLUCKINGDATE) = trunc(PLUCKINGDATE)) and gt_type not in ('TRANSFER','SALE') and
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

wf_resetdates()

this.tag = Message.StringParm
ll_user_level = long(this.tag)
em_3.text = string(today(),'YYYY')
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type em_3 from editmask within w_gteprof010
integer x = 1042
integer y = 28
integer width = 197
integer height = 84
integer taborder = 110
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

type st_3 from statictext within w_gteprof010
integer x = 809
integer y = 36
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

type cb_6 from commandbutton within w_gteprof010
integer x = 2866
integer y = 1264
integer width = 311
integer height = 112
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Adj Rec%"
end type

event clicked;double ld_tot_tm,ld_tot_up,ld_own_up,ld_own_tm ,ld_diff_gl,ld_diff_tm,ld_rc_per,ld_tm,ld_up,ld_recp
long ll_rec

ld_tot_up = dw_3.getitemnumber(0,'tot_up')
ld_own_up = dw_3.getitemnumber(0,'own_up')
ld_tot_tm   = dw_2.getitemnumber(0,'dr_tmade')
ld_own_tm = dw_3.getitemnumber(0,'own_tm')

if isnull(ld_tot_tm) then ld_tot_tm =0 
if isnull(ld_tot_up) then ld_tot_up = 0
if isnull(ld_own_up) then ld_own_up=0
if isnull(ld_own_tm) then ld_own_tm=0

ld_diff_gl = ld_tot_up - ld_own_up
ld_diff_tm = ld_tot_tm - ld_own_tm

ld_rc_per = ld_diff_tm / ld_diff_gl

for ll_rec = 1 to dw_3.rowcount()
	if dw_3.getitemstring(ll_rec,'ownind')= 'N' then
		ld_up = dw_3.getitemnumber(ll_rec,'glfp_glforproduction')
		if isnull(ld_up) then ld_up=0
		ld_tm = round(ld_up * ld_rc_per,0) 
		dw_3.setitem(ll_rec,'gwtm_teamade',ld_tm )
		ld_recp = round(((ld_tm * 100) / ld_up),2)
		dw_3.setitem(ll_rec,'recov_per',ld_recp)
	end if
next

end event

type dp_1 from datepicker within w_gteprof010
integer x = 393
integer y = 16
integer width = 379
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-08-17"), Time("09:49:28.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteprof010
integer x = 1600
integer y = 36
integer width = 261
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

type ddlb_2 from dropdownlistbox within w_gteprof010
integer x = 1883
integer y = 24
integer width = 480
integer height = 1000
integer taborder = 100
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

type cb_1 from commandbutton within w_gteprof010
integer x = 1326
integer y = 20
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
	if dw_2.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
end if
dw_2.reset()
dw_3.reset()
setnull(ld_rundt)
dw_2.settransobject(sqlca)

if isnull(dp_1.text) then
	messagebox('Warning!','Please Select A Plucking Date First !!!')
	return 1
end if

ll_season = long(em_3.text)

if isnull(ll_season) or ll_season = 0 or len(em_3.text) = 0  then
	messagebox('Warning !','Please Enter The Season !!!')
	return 1
end if

ld_rundt = datetime(dp_1.text)

if date(ld_rundt) > date(today()) then
	messagebox('Warning !','Production Date Should Not Be Greater Than Current Date !!!')
	return 1
end if

select distinct 'x' into :ls_temp from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
where glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N' and trunc(GLFP_PLUCKINGDATE) = trunc(:ld_rundt);

if sqlca.sqlcode = -1 then
	messagebox('Error : While Checking Production Entry',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	messagebox('Warning!','Production Entry Already Done For This Date, Please Check !!!')
	return 1
end if		
		

dw_1.settransobject(sqlca)
dw_1.RETRIEVE(STRING(ld_rundt,'DD/MM/YYYY'))

//select distinct 'x' into :ls_temp from dual where trunc(:ld_rundt) in (select distinct trunc(PLUCKINGDATE) from fb_gltransaction 
//where not exists (select distinct trunc(DDP_PLUCKINGDATE) from fb_dailydryerproduct where trunc(DDP_PLUCKINGDATE) = trunc(PLUCKINGDATE)));
//
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Machine Reading For Selected Date',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//elseif sqlca.sqlcode  = 0 then
//	messagebox('Warning!','No Machine Reading Found For Selected Date, Please Check !!!')
//	return 1
//end if		

select distinct 'x' into :ls_temp from fb_dailydryerproduct
where trunc(DDP_PLUCKINGDATE) = trunc(:ld_rundt) and DRYER_ID in (select MACHINE_ID from fb_machine where MACHINE_TYPE = 'DRY');

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Machine Reading For Selected Date',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning!','No Machine Reading Found For Selected Date For Machine Type (Dryer), Please Check !!!')
	return 1
end if		

//Check Removed on 09/04/2012
//select distinct 'x' into :ls_temp from dual where trunc(:ld_rundt) in (select distinct trunc(PLUCKINGDATE) from fb_gltransaction 
//where exists (select distinct trunc(DDP_PLUCKINGDATE) from fb_dailydryerproduct where trunc(DDP_PLUCKINGDATE) = trunc(PLUCKINGDATE) and DRYER_ID in (select MACHINE_ID from fb_machine where MACHINE_TYPE = 'CTC')));
//
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Machine Reading For Selected Date',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//elseif sqlca.sqlcode  = 100 then
//	messagebox('Warning!','No Machine Reading Found For Selected Date For Machine Type (CTC), Please Check !!!')
//	return 1
//end if

//Check Removed on 09/04/2012

if not isnull(ld_rundt)  then
	DECLARE c2 CURSOR FOR  
	select DDP_PK, DRYER_ID, DDP_STARTRUNTIME, DDP_ENDRUNTIME,DDP_PLUCKINGDATE  from fb_dailydryerproduct a ,fb_machine b
		where trunc(DDP_PLUCKINGDATE) = trunc(:ld_rundt) and DRYER_ID = b.MACHINE_ID and MACHINE_TYPE in ('DRY') and
			  not exists (select distinct DDP_PK from fb_dailydryerunsorted b where a.DDP_PK = b.DDP_PK)
	order by DDP_PK;
	
	open c2;
		
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_pk,:ls_mac_id,:ld_startdt,:ld_enddt,:ld_pluckdt;
		
		do while sqlca.sqlcode <> 100
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'dryer_id',ls_mac_id)
			dw_2.setitem(dw_2.getrow(),'ddp_pk',ls_pk)
			dw_2.setitem(dw_2.getrow(),'ddp_startruntime',ld_startdt)
			dw_2.setitem(dw_2.getrow(),'ddp_endruntime',ld_enddt)
			dw_2.setitem(dw_2.getrow(),'ddp_dt',ld_pluckdt)
			dw_2.setitem(dw_2.getrow(),'ddp_season',ll_season)
			fetch c2 into :ls_pk,:ls_mac_id,:ld_startdt,:ld_enddt,:ld_pluckdt;
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

type st_1 from statictext within w_gteprof010
integer x = 14
integer y = 36
integer width = 370
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Production Date"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_gteprof010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 1248
integer width = 2821
integer height = 1008
string dataobject = "dw_gteprof010b"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;//if lb_query = false then
// if lb_neworder = true then	
//	if currentrow <> dw_2.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
//	END If
// end if
//end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'glfp_glforproduction' then
	ld_glfp = double(data) 
	ld_gl = dw_3.getitemnumber(row,'glfp_gl_qty')
	if ld_glfp > ld_gl then
		messagebox('Warning !','Green Leef Quantity Should Not Be > '+string(ld_glfp)+', Please Check !!!')
		return 1
	end if
	ld_st_tmqty = dw_3.getitemnumber(row,'gwtm_teamade')
	if ld_glfp > 0 then
		ld_rec = round(((ld_st_tmqty * 100) / ld_glfp),2)
	else
		ld_rec = 0
	end if
	dw_3.setitem(row,'recov_per',ld_rec)
end if

if dwo.name = 'gwtm_teamade' then
	ld_st_tmqty = double(data)
	ld_glfp = dw_3.getitemnumber(row,'glfp_glforproduction')
	if ld_glfp > 0 then
		ld_rec = round(((ld_st_tmqty * 100) / ld_glfp),2)
	else
		ld_rec = 0
	end if		
	dw_3.setitem(row,'recov_per',ld_rec)
end if

cb_3.enabled = true
end event

type cb_5 from commandbutton within w_gteprof010
boolean visible = false
integer x = 3173
integer y = 20
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_7 from commandbutton within w_gteprof010
boolean visible = false
integer x = 3291
integer y = 20
integer width = 123
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_8 from commandbutton within w_gteprof010
boolean visible = false
integer x = 3410
integer y = 20
integer width = 123
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gteprof010
boolean visible = false
integer x = 3529
integer y = 20
integer width = 123
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type dw_2 from datawindow within w_gteprof010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 684
integer width = 3643
integer height = 556
string dataobject = "dw_gteprof010a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;// if gs_garden_snm = 'MT' or gs_garden_snm = 'FB'  then //As discussion with sanjay sir on 08/06/2013 as per issue of pariday (C0000614) logic removed.
	if dwo.name = 'ddu_quantity' then
		dw_3.reset()
		ld_tmqnty = double(data)
		ld_rundt = datetime(dp_1.text)
		
		if ld_tmqnty <= 0 then
			messagebox('Warning!','Tea Pack Quantity Must Be > 0, Please Check !!!')
			return 1
		end if
		
	//		DECLARE c1 CURSOR FOR  
	//		select distinct gtsupid ,gltq 
	//		   from (select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
	//				    where GLT.pluckingdate <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
	//						    GLT.pluckingdate > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) 	
	//				   group by glt.sup_id) ;
	//09/04/2012
	//		select distinct gtsupid ,gltq 
	//		   from (	select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
	//				    where GLT.pluckingdate <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
	//						    GLT.pluckingdate > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and (exists 
	//							(select SUP_ID from fb_leafanalysis where LA_DATE = (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and sup_id = glt.sup_id) or glt.gt_type = 'OWNATTE')
	//				   group by glt.sup_id) ;
	//09/04/2012
//31/05/2014
//			select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
//				from (select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//						 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
//								 trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//															where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N') 
//						group by glt.sup_id) 
//			order by 3 desc,1;
//31/05/2014

		ld_sale = dw_1.getitemnumber(dw_1.getrow(),'sale')
		ld_transfer = dw_1.getitemnumber(dw_1.getrow(),'trans')
		ld_opn = dw_1.getitemnumber(dw_1.getrow(),'opn')
		
		if isnull(ld_sale) then ld_sale = 0;
		if isnull(ld_transfer) then ld_transfer = 0;
		if isnull(ld_opn) then ld_opn = 0;
		
		if (not isnull(ld_tmqnty) or ld_tmqnty > 0) and dw_3.rowcount() = 0 then
//*******commented on 04/08/14 PKT	
//					select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
//						from (select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//								 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
//										 trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//																	where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N') 
//								group by glt.sup_id) 
//					order by 3 desc,1;
			if gs_garden_snm <> 'SH' and gs_garden_snm <> 'MV' and gs_garden_snm <> 'MT'  and gs_garden_snm <> 'LP' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'SP'  and gs_garden_snm <> 'AB' and gs_garden_snm <> 'AD' and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR' and gs_garden_snm <> 'GP' then  
				DECLARE c1 CURSOR FOR  
					select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
									 from (select decode(glt.gt_type,'TRANSFER',nvl(gt_sup_from,unitsupid),'SALE',unitsupid,glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),'SALE',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt,
      										(select UNIT_SUPID unitsupid from fb_gardenmaster where  UNIT_ACTIVE_IND = 'Y') 
										 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER','SALE') and
												 trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
																			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
											  group by decode(glt.gt_type,'TRANSFER',nvl(gt_sup_from,unitsupid),'SALE',unitsupid,glt.sup_id)) where gltq <> 0
					order by 3 desc,1;			

				open c1;
				
				if sqlca.sqlcode = -1 then 
						messagebox('Error At Cursor',sqlca.sqlerrtext);
						return 1;
				elseIF sqlca.sqlcode = 0 THEN
					fetch c1 into :ls_sup,:ld_qty,:ls_ownind;
					
					do while sqlca.sqlcode <> 100
						dw_3.scrolltorow(dw_3.insertrow(0))
						dw_3.setitem(dw_3.getrow(),'sup_id',ls_sup)
						dw_3.setitem(dw_3.getrow(),'own_supp',gs_supid)
						dw_3.setitem(dw_3.getrow(),'gsn',gs_garden_snm)
						
						if ls_ownind = 'Y' then
							//dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
							//dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
							if  gs_garden_snm = 'FB' or  gs_garden_snm = 'LG' then
//								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',(ld_qty - (ld_sale +ld_transfer))) //commented on 170620 as transfer was already getting subtracted
//								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',(ld_qty - (ld_sale +ld_transfer))) //commented on 170620 as transfer was already getting subtracted
								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',(ld_qty - (ld_sale)))
								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',(ld_qty - (ld_sale)))
							else
//								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer))) //commented on 170620 as transfer was already getting subtracted
//								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer))) //commented on 170620 as transfer was already getting subtracted
								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale)))
								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale)))
							end if
						else
							dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',ld_qty)
							dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',ld_qty)
						end if
						dw_3.setitem(dw_3.getrow(),'glfp_pluckingdate',ld_rundt)
						dw_3.setitem(dw_3.getrow(),'ownind',ls_ownind)
		
						fetch c1 into :ls_sup,:ld_qty,:ls_ownind;
					loop
				END IF
				close c1;
			elseif gs_garden_snm = 'SH' or gs_garden_snm = 'LP' or gs_garden_snm = 'MR' or gs_garden_snm = 'SP'  or gs_garden_snm = 'AB' or gs_garden_snm = 'AD' or gs_garden_snm = 'MH'  or gs_garden_snm = 'DR'  then
//*******commented on 04/08/14 PKT	
//					select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
//									 from (select decode(glt.gt_type,'TRANSFER','SUP00091',glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt 
//										 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER') and
//												 trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//																			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
//											  group by decode(glt.gt_type,'TRANSFER','SUP00091',glt.sup_id))
//					order by 3 desc,1;

				DECLARE c2 CURSOR FOR  
					select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
									 from (select decode(glt.gt_type,'TRANSFER',nvl(gt_sup_from,unitsupid),'SALE',unitsupid,glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),'SALE',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt,
      										(select UNIT_SUPID unitsupid from fb_gardenmaster where  UNIT_ACTIVE_IND = 'Y') 
										 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER','SALE') and
												 trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
																			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N') 
											  group by decode(glt.gt_type,'TRANSFER',nvl(gt_sup_from,unitsupid),'SALE',unitsupid,glt.sup_id)) where gltq <> 0
					order by 3 desc,1;
					
				open c2;
				
				if sqlca.sqlcode = -1 then 
						messagebox('Error At Cursor',sqlca.sqlerrtext);
						return 1;
				elseIF sqlca.sqlcode = 0 THEN
					fetch c2 into :ls_sup,:ld_qty,:ls_ownind;
					
					do while sqlca.sqlcode <> 100
						dw_3.scrolltorow(dw_3.insertrow(0))
						dw_3.setitem(dw_3.getrow(),'sup_id',ls_sup)
						dw_3.setitem(dw_3.getrow(),'own_supp',gs_supid)
						dw_3.setitem(dw_3.getrow(),'gsn',gs_garden_snm)
						
						if ls_ownind = 'Y' then
							//dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
							//dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
//							if gs_garden_snm = 'MT' or gs_garden_snm = 'FB' then
								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',(ld_qty))
								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',(ld_qty))
//							else
//								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
//								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))							
//							end if
						else
							dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',ld_qty)
							dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',ld_qty)
						end if
						dw_3.setitem(dw_3.getrow(),'glfp_pluckingdate',ld_rundt)
						dw_3.setitem(dw_3.getrow(),'ownind',ls_ownind)
		
						fetch c2 into :ls_sup,:ld_qty,:ls_ownind;
					loop
				END IF
				close c2;	
			elseif gs_garden_snm = 'MV'  or gs_garden_snm = 'MT'  or gs_garden_snm = 'GP' then//commented on 14-08-2023 --->>or gs_garden_snm = 'GP'
//*******commented on 04/08/14 PKT	
//					select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
//									 from (select decode(glt.gt_type,'TRANSFER','SUP00091',glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt 
//										 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER') and
//												 trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//																			where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
//											  group by decode(glt.gt_type,'TRANSFER','SUP00091',glt.sup_id))
//					order by 3 desc,1;

//					 select SUP_ID ,sum(nvl(GLFP_GL_QTY,0) - nvl(GLFP_GLFORPRODUCTION,0)) gltq ,decode(SUP_ID,:gs_supid,'Y','N') ownind
//					 from fb_glforproduction where trunc(GLFP_PLUCKINGDATE) <= (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//																						  where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N') and trunc(GLFP_PLUCKINGDATE) > to_date('01/08/2014','dd/mm/yyyy')
//					 group by SUP_ID having sum(nvl(GLFP_GL_QTY,0) - nvl(GLFP_GLFORPRODUCTION,0)) > 0

				DECLARE c3 CURSOR FOR  
				select gtsupid, sum(gltq) gltq, ownind
				from
				(   select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
									  from (select decode(glt.gt_type,'TRANSFER',unitsupid,'SALE',unitsupid,glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),'SALE',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt,
												  (select UNIT_SUPID unitsupid from fb_gardenmaster where  UNIT_ACTIVE_IND = 'Y') 
											where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER','SALE') and
													  trunc(GLT.pluckingdate) > (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
																						  where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
												  group by decode(glt.gt_type,'TRANSFER',unitsupid,'SALE',unitsupid,glt.sup_id))                          
					 union all
					 select SUP_ID ,sum(nvl(GLFP_GL_QTY,0) - nvl(GLFP_GLFORPRODUCTION,0)) gltq ,decode(SUP_ID,:gs_supid,'Y','N') ownind
					 from fb_glforproduction where trunc(GLFP_PLUCKINGDATE) < trunc(:ld_rundt) and trunc(GLFP_PLUCKINGDATE) >= (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
																						  where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
					 group by SUP_ID having sum(nvl(GLFP_GL_QTY,0) - nvl(GLFP_GLFORPRODUCTION,0)) > 0)
				group by gtsupid, ownind                    
				order by 3 desc,1;
					
				open c3;
				
				if sqlca.sqlcode = -1 then 
						messagebox('Error At Cursor',sqlca.sqlerrtext);
						return 1;
				elseIF sqlca.sqlcode = 0 THEN
					fetch c3 into :ls_sup,:ld_qty,:ls_ownind;
					
					do while sqlca.sqlcode <> 100
						dw_3.scrolltorow(dw_3.insertrow(0))
						dw_3.setitem(dw_3.getrow(),'sup_id',ls_sup)
						dw_3.setitem(dw_3.getrow(),'own_supp',gs_supid)
						dw_3.setitem(dw_3.getrow(),'gsn',gs_garden_snm)
						
						if ls_ownind = 'Y' then
							//dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
							//dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
//							if gs_garden_snm = 'MT' or gs_garden_snm = 'FB' then
								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',(ld_qty))
								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',(ld_qty))
//							else
//								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
//								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))							
//							end if
						else
							dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',ld_qty)
							dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',ld_qty)
						end if
						dw_3.setitem(dw_3.getrow(),'glfp_pluckingdate',ld_rundt)
						dw_3.setitem(dw_3.getrow(),'ownind',ls_ownind)
		
						fetch c3 into :ls_sup,:ld_qty,:ls_ownind;
					loop
				END IF
				close c3;
//			elseif gs_garden_snm = 'GP' then
//					
//					DECLARE c4 CURSOR FOR  
//					select gtsupid, sum(gltq) gltq, ownind
//				from
//				(   select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
//									  from (select decode(glt.gt_type,'TRANSFER',unitsupid,'SALE',unitsupid,glt.sup_id) gtsupid, nvl(sum(decode(glt.gt_type,'TRANSFER',(-1),'SALE',(-1),1) * glt.gt_quantity),0) gltq from fb_gltransaction glt,
//												  (select UNIT_SUPID unitsupid from fb_gardenmaster where  UNIT_ACTIVE_IND = 'Y') 
//											where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE','TRANSFER','SALE') and
//													  trunc(GLT.pluckingdate) >= (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//																						  where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
//												  group by decode(glt.gt_type,'TRANSFER',unitsupid,'SALE',unitsupid,glt.sup_id))                          
//					 union all
//					 select SUP_ID ,sum(nvl(GLFP_GL_QTY,0) - nvl(GLFP_GLFORPRODUCTION,0)) gltq ,decode(SUP_ID,:gs_supid,'Y','N') ownind
//					 from fb_glforproduction where trunc(GLFP_PLUCKINGDATE) < trunc(:ld_rundt) and trunc(GLFP_PLUCKINGDATE) >= (select nvl(max(trunc(GLFP_PLUCKINGDATE)),'01-Jan-2000') from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//																						  where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N')
//					 group by SUP_ID having sum(nvl(GLFP_GL_QTY,0) - nvl(GLFP_GLFORPRODUCTION,0)) > 0)
//				group by gtsupid, ownind                    
//				order by 3 desc,1;
//					
//				open c4;
//				
//				if sqlca.sqlcode = -1 then 
//						messagebox('Error At Cursor',sqlca.sqlerrtext);
//						return 1;
//				elseIF sqlca.sqlcode = 0 THEN
//					fetch c4 into :ls_sup,:ld_qty,:ls_ownind;
//					
//					do while sqlca.sqlcode <> 100
//						dw_3.scrolltorow(dw_3.insertrow(0))
//						dw_3.setitem(dw_3.getrow(),'sup_id',ls_sup)
//						dw_3.setitem(dw_3.getrow(),'own_supp',gs_supid)
//						dw_3.setitem(dw_3.getrow(),'gsn',gs_garden_snm)
//						
//						if ls_ownind = 'Y' then
//							//dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
//							//dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
////							if gs_garden_snm = 'MT' or gs_garden_snm = 'FB' then
//								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',(ld_qty))
//								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',(ld_qty))
////							else
////								dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))
////								dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',((ld_opn + ld_qty) - (ld_sale +ld_transfer)))							
////							end if
//						else
//							dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',ld_qty)
//							dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',ld_qty)
//						end if
//						dw_3.setitem(dw_3.getrow(),'glfp_pluckingdate',ld_rundt)
//						dw_3.setitem(dw_3.getrow(),'ownind',ls_ownind)
//		
//						fetch c4 into :ls_sup,:ld_qty,:ls_ownind;
//					loop
//				END IF
//				close c4;
			end if
			dw_3.setfocus()
			dw_3.scrolltorow(1)
			dw_3.setcolumn('glfp_glforproduction')
		end if
	end if //*******commented on 04/08/14 PKT	
	cb_3.enabled = true
//As discussion with sanjay sir on 08/06/2013 as per issue of pariday (C0000614) logic removed.
//else
//	if dwo.name = 'ddu_quantity' then
//		dw_3.reset()
//		ld_tmqnty = double(data)
//		ld_rundt = datetime(dp_1.text)
//		ld_netqnty = dw_1.getitemnumber(dw_1.getrow(),'net')
//		ld_purchase = dw_1.getitemnumber(dw_1.getrow(),'purc')
//		ld_receive = dw_1.getitemnumber(dw_1.getrow(),'recv')
//		
//		if ld_tmqnty <= 0 then
//			messagebox('Warning!','Tea Pack Quantity Must Be > 0, Please Check !!!')
//			return 1
//		end if
//	
//		select nvl(sum(glt.gt_quantity),0) into :ld_totqty from fb_gltransaction glt 
//		where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
//				 trunc(GLT.pluckingdate) > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//														where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N');
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Total Green Leaf !!!',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if		
//		if isnull(ld_purchase) then ld_purchase = 0;
//		if isnull(ld_receive) then ld_receive = 0;
//		if isnull(ld_totqty) then ld_totqty = 0;
//		ld_purtot = ld_purchase + ld_receive;
//		
//		ld_ratio = ld_netqnty / ld_totqty;
//		if isnull(ld_ratio) then ld_ratio = 0;
//		
//	//		DECLARE c1 CURSOR FOR  
//	//		select distinct gtsupid ,gltq 
//	//		   from (select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//	//				    where GLT.pluckingdate <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
//	//						    GLT.pluckingdate > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) 	
//	//				   group by glt.sup_id) ;
//	//09/04/2012
//	//		select distinct gtsupid ,gltq 
//	//		   from (	select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//	//				    where GLT.pluckingdate <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
//	//						    GLT.pluckingdate > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and (exists 
//	//							(select SUP_ID from fb_leafanalysis where LA_DATE = (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction) and sup_id = glt.sup_id) or glt.gt_type = 'OWNATTE')
//	//				   group by glt.sup_id) ;
//	//09/04/2012
//	
//		if (not isnull(ld_tmqnty) or ld_tmqnty > 0) and dw_3.rowcount() = 0 then
//			DECLARE c2 CURSOR FOR  
//			select distinct gtsupid ,gltq ,decode(gtsupid,:gs_supid,'Y','N') ownind
//				from (	select glt.sup_id gtsupid,nvl(sum(glt.gt_quantity),0) gltq from fb_gltransaction glt 
//						 where trunc(GLT.pluckingdate) <= trunc(:ld_rundt) and glt.gt_type in ('PURCHASE','BROUGHT','OWNATTE') and
//								 trunc(GLT.pluckingdate) > (select max(trunc(GLFP_PLUCKINGDATE)) from fb_glforproduction glfp,fb_gardenwiseteamade gwtm
//															where  glfp.glfp_pk=gwtm.glfp_pk and gwtm.gwtm_type='N') 
//						group by glt.sup_id) 
//			order by 3 desc,1;
//			
//			open c2;
//				
//			IF sqlca.sqlcode = 0 THEN
//				fetch c2 into :ls_sup,:ld_qty,:ls_ownind;
//				
//				do while sqlca.sqlcode <> 100
//					dw_3.scrolltorow(dw_3.insertrow(0))
//					dw_3.setitem(dw_3.getrow(),'sup_id',ls_sup)
//					dw_3.setitem(dw_3.getrow(),'own_supp',gs_supid)
////					if ls_sup <> gs_supid and ld_purtot < round(ld_qty * ld_ratio,0) then
////						dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',ld_purtot)
////						dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',ld_purtot)
////					else
//						dw_3.setitem(dw_3.getrow(),'glfp_glforproduction',round(ld_qty * ld_ratio,0))
//						dw_3.setitem(dw_3.getrow(),'glfp_gl_qty',round(ld_qty * ld_ratio,0))					
////					end if
//					//ld_purtot = ld_purtot - round(ld_qty * ld_ratio,0)
//					dw_3.setitem(dw_3.getrow(),'glfp_pluckingdate',ld_rundt)
//					dw_3.setitem(dw_3.getrow(),'ownind',ls_ownind)
//					
//					if gs_garden_snm = 'MF' then
//						dw_3.Modify("glfp_glforproduction.Protect=0")
//					end if;
//					
//					fetch c2 into :ls_sup,:ld_qty,:ls_ownind;
//				loop
//			END IF
//			close c2;
//			dw_3.setfocus()
//			dw_3.scrolltorow(1)
//			dw_3.setcolumn('glfp_glforproduction')
//		end if
//	end if
//	cb_3.enabled = true
//end if //As discussion with sanjay sir on 08/06/2013 as per issue of pariday (C0000614) logic removed.
end event

type cb_4 from commandbutton within w_gteprof010
integer x = 2898
integer y = 20
integer width = 265
integer height = 100
integer taborder = 50
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

type cb_3 from commandbutton within w_gteprof010
integer x = 2633
integer y = 20
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;ll_last = 0
if dw_2.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if dw_3.rowcount() > 0 then
		for ll_ctr = dw_3.rowcount() to 1 step -1
			if dw_3.rowcount() > 1 then
				if (isnull(dw_3.getitemnumber(ll_ctr,'glfp_glforproduction')) or dw_3.getitemnumber(ll_ctr,'glfp_glforproduction') = 0 and & 
					isnull(dw_3.getitemnumber(ll_ctr,'gwtm_teamade')) or dw_3.getitemnumber(ll_ctr,'gwtm_teamade') = 0) then 
					if gs_garden_snm <> 'MV' then
						dw_3.deleterow(ll_ctr)
					end if
				end if;
			end if
		next
	end if
	
	if dw_3.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_2.getitemnumber(dw_2.getrow(),'ddu_quantity')) or dw_2.getitemnumber(dw_2.getrow(),'ddu_quantity') = 0) then
		messagebox('Warning:','One Of The Fields Are Blank : Tea Made Quantity, Please Check !!!')
		dw_2.setfocus()
		dw_2.setcolumn('ddu_quantity')
		return
	end if
	
	if dw_2.getitemnumber(1,'dr_tmade') <> dw_3.getitemnumber(1,'sp_tmade') then
		messagebox('Warning!','Source Wise Tea Made Quantity Should be Equal To Dryer Wise Tea Made Quantity, Please Check !!!')
		return 1
	end if
	if gs_garden_snm <> 'MV' then
		if dw_3.rowcount() > 0 then
			for ll_ctr = 1 to dw_3.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
	end if
	if lb_neworder = true then
		if ll_last=0 then
			select nvl(MAX(substr(GLFP_PK,4,10)),0) into :ll_last from fb_glforproduction;
		end if
		for ix = 1 to dw_3.rowcount()
			ll_last = ll_last + 1
			ls_tmp_id = 'GFP'+string(ll_last,'0000000000')
			dw_3.setitem(ix,'glfp_pk',ls_tmp_id)
		next
	end if		
	
	ld_rundt = datetime(dp_1.text)
	
	if dw_3.rowcount() >= 1 then
		for l_ctr = 1 to dw_3.rowcount()
			ls_glpk = dw_3.getitemstring(l_ctr,'glfp_pk')
			ld_st_tmqty = dw_3.getitemnumber(l_ctr,'gwtm_teamade')
			ld_st_old_tmqty = dw_3.getitemnumber(l_ctr,'oldteamade')
			ll_season = dw_2.getitemnumber(1,'ddp_season')
			
			select distinct 'x' into :ls_temp from fb_gardenwiseteamade where glfp_pk = :ls_glpk;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then
				insert into fb_gardenwiseteamade(GWTM_TEAMADE, GWTM_TYPE, GLFP_PK, GWTM_SEASON) values(:ld_st_tmqty,'N',:ls_glpk,:ll_season);
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Record In gardenwiseteamade Table !!!',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif sqlca.sqlcode  = 0 then
				update fb_gardenwiseteamade set GWTM_TEAMADE = (nvl(GWTM_TEAMADE,0) - nvl(:ld_st_old_tmqty,0) + nvl(:ld_st_tmqty,0))
				where  glfp_pk = :ls_glpk;
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Record In gardenwiseteamade Table !!!',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if		
			
		next		
	end if
	
	
	if dw_2.update(true,false) = 1 and dw_3.update(true,false) = 1 then
		update fb_gltransaction set gt_prod_ind = 'Y' where trunc(GT_DATE) = trunc(:ld_rundt);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Updating Prod Ind in Gltransaction Table !!!',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		dw_3.resetupdate();
		dw_2.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
		dw_2.reset()
		dw_3.reset()
		wf_resetdates()
		
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteprof010
integer x = 2368
integer y = 20
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

//if cb_2.text = "&Query" then
//	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
//		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
//			return 1
//		end if
//	end if
//	lb_query = true
//	lb_neworder = true
//	dw_1.reset()
//	dw_2.reset()
//   	cb_3.enabled = false
////  	cb_5.enabled = false
////	cb_7.enabled = false
////	cb_8.enabled = false
////	cb_9.enabled = false
////	dw_1.settaborder('dryer_id',10)
//	dw_1.modify("datawindow.queryclear= yes")
//	dw_1.Object.datawindow.querymode= 'yes'
//	dw_1.SetFocus ()
////	dw_1.setcolumn('dryer_id')
//	cb_2.text = "&Run"
//	cb_3.enabled = false
//else
	lb_query = false
	 dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(string(ld_rundt,'dd/mm/yyyy'))
	dw_2.Retrieve(string(ld_rundt,'dd/mm/yyyy'))
	dw_3.Retrieve(string(ld_rundt,'dd/mm/yyyy'),gs_supid,gs_garden_snm)
	 dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
//	cb_2.text = "&Query"
//	   cb_5.enabled = true
//	   cb_7.enabled = true
//	   cb_8.enabled = true
//	   cb_9.enabled = true

//end if
lb_neworder = false

end event

type dw_1 from datawindow within w_gteprof010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 124
integer width = 2821
integer height = 552
string dataobject = "dw_gteprof010"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'ddp_entry_by',gs_user)
		dw_1.setitem(newrow,'ddp_entry_dt',datetime(today()))
		dw_1.setcolumn('dryer_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

