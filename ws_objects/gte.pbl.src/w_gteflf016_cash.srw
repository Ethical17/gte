$PBExportHeader$w_gteflf016_cash.srw
forward
global type w_gteflf016_cash from window
end type
type em_3 from editmask within w_gteflf016_cash
end type
type st_3 from statictext within w_gteflf016_cash
end type
type em_2 from editmask within w_gteflf016_cash
end type
type st_2 from statictext within w_gteflf016_cash
end type
type cb_6 from commandbutton within w_gteflf016_cash
end type
type cbx_1 from checkbox within w_gteflf016_cash
end type
type em_1 from editmask within w_gteflf016_cash
end type
type st_1 from statictext within w_gteflf016_cash
end type
type cb_4 from commandbutton within w_gteflf016_cash
end type
type cb_3 from commandbutton within w_gteflf016_cash
end type
type cb_2 from commandbutton within w_gteflf016_cash
end type
type cb_1 from commandbutton within w_gteflf016_cash
end type
type dw_1 from datawindow within w_gteflf016_cash
end type
end forward

global type w_gteflf016_cash from window
integer width = 4174
integer height = 2276
boolean titlebar = true
string title = "(w_gteflf016) Plucking Area"
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
em_2 em_2
st_2 st_2
cb_6 cb_6
cbx_1 cbx_1
em_1 em_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteflf016_cash w_gteflf016_cash

type variables
long ll_ctr,net, ll_cnt,ll_st_year,ll_end_year,ll_last,ll_user_level, ll_season
string ls_temp,ls_last,ls_count,ls_section_id,ls_tmp_id,ls_ac_dt,ls_appr_ind,ls_type
datetime ld_date,ld_spdate
boolean lb_neworder, lb_query
double ld_parea,ld_sec_area,ld_totgl, ld_plkrt, ld_totarea, ld_mdays,ld_kam_rate

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_sec_id, datetime fd_date, string fs_type)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'section_id')) or  len(dw_1.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'spr_date')) or &
		 isnull(dw_1.getitemnumber(fl_row,'spr_areacovered'))  or &
		 isnull(dw_1.getitemnumber(fl_row,'spr_season'))  or dw_1.getitemnumber(fl_row,'spr_season') = 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'spr_mandays'))  or &
		 isnull(dw_1.getitemnumber(fl_row,'spr_gl'))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Plucked Area Today, Own GL, Mandays, Season, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_sec_id, datetime fd_date, string fs_type);long fl_row
string ls_sec_id1,ls_type1
datetime ld_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_sec_id1  = dw_1.getitemstring(fl_row,'section_id')
		ld_dt1  = dw_1.getitemdatetime(fl_row,'spr_date')
	     ls_type1= dw_1.getitemstring(fl_row,'spr_pluccktype')
		  
		if ls_sec_id1 = fs_sec_id and ld_dt1 = fd_date and ls_type1 = fs_type then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteflf016_cash.create
this.em_3=create em_3
this.st_3=create st_3
this.em_2=create em_2
this.st_2=create st_2
this.cb_6=create cb_6
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_3,&
this.st_3,&
this.em_2,&
this.st_2,&
this.cb_6,&
this.cbx_1,&
this.em_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteflf016_cash.destroy
destroy(this.em_3)
destroy(this.st_3)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.cb_6)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

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

type em_3 from editmask within w_gteflf016_cash
integer x = 1001
integer y = 16
integer width = 197
integer height = 84
integer taborder = 20
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

type st_3 from statictext within w_gteflf016_cash
integer x = 768
integer y = 24
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

type em_2 from editmask within w_gteflf016_cash
integer x = 370
integer y = 12
integer width = 389
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_gteflf016_cash
integer x = 9
integer y = 24
integer width = 379
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plucking Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_gteflf016_cash
integer x = 3721
integer width = 343
integer height = 104
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked;
 n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

string ls_sectionid,ls_sp_id
double ld_qty,ld_rate,ld_amt

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

for ll_ctr = 1 to dw_1.rowcount() 
	if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'spr_vou_no'))=true then
		ls_sectionid = dw_1.getitemstring(ll_ctr,'section_id')
		
		///create CPV 
		if luo_fames.wf_cash_plucking(dw_1.getitemstring(ll_ctr,'section_id'),ls_ac_dt) = -1 then 
			rollback using sqlca;
			return 1;
		end if;
	end if
next	
	
dw_1.update( )

commit using sqlca;
DESTROY n_fames
dw_1.reset()

messagebox('Information;',' CPV Created Successfully')
cb_6.enabled = false
end event

type cbx_1 from checkbox within w_gteflf016_cash
integer x = 3365
integer y = 12
integer width = 384
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "For Account"
end type

type em_1 from editmask within w_gteflf016_cash
integer x = 2921
integer y = 16
integer width = 411
integer height = 84
integer taborder = 90
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

event modified;if isdate(em_1.text) = false then 
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return 1
else
	ls_temp=em_1.text
	cb_6.enabled = true
end if;	
end event

type st_1 from statictext within w_gteflf016_cash
integer x = 2455
integer y = 28
integer width = 453
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gteflf016_cash
integer x = 2011
integer y = 4
integer width = 265
integer height = 100
integer taborder = 70
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

type cb_3 from commandbutton within w_gteflf016_cash
integer x = 1746
integer y = 4
integer width = 265
integer height = 100
integer taborder = 60
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'section_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'section_id')) = 0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if
	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		
		if gs_garden_snm <> 'KG' then
			ld_spdate = dw_1.getitemdatetime(1,'spr_date')
			ll_season = dw_1.getitemnumber(1,'spr_season')
		
			select sum(nvl(SPR_GL,0)) owngl into :ld_totgl from fb_sectionpluckinground where trunc(SPR_DATE) = trunc(:ld_spdate);
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Own GL Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then			
				select distinct 'x' into :ls_temp from fb_gltransaction where trunc(GT_DATE) = trunc(:ld_spdate) and upper(GT_TYPE) = 'OWNATTE';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Own GL Detail',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 100 then
					ll_last = 0
					if ll_last=0 then
						select nvl(MAX(substr(GT_ID,3,10)),0) into :ll_last from fb_gltransaction;
					end if
					ll_last = ll_last + 1
					ls_tmp_id = 'GT'+string(ll_last,'0000000000')
					
		
					insert into fb_gltransaction (GT_ID,SUP_ID,GT_DATE,PLUCKINGDATE,GT_TYPE,GT_UNITPRICE,GT_QUANTITY,GT_ENTRY_BY, GT_ENTRY_DT,GT_CONFIRMFLAG, GT_SEASON) values (:ls_tmp_id,:gs_supid,trunc(:ld_spdate),trunc(:ld_spdate),'OWNATTE',0,:ld_totgl,:gs_user,sysdate,'1',:ll_season);
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Inserting Own GL Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				elseif sqlca.sqlcode = 0 then
					update fb_gltransaction set GT_QUANTITY = nvl(:ld_totgl,0), GT_SEASON = :ll_season where GT_DATE = trunc(:ld_spdate) and GT_TYPE ='OWNATTE';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Own GL Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				end if
			end if
			commit using sqlca;
		end if
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

type cb_2 from commandbutton within w_gteflf016_cash
integer x = 1481
integer y = 4
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if


//select max(SPR_DATE) into :ld_date from fb_sectionpluckinground;  		
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Maximum Plucking Date',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//end if

if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	dw_1.settaborder('spr_date',5)
//	dw_1.Object.spr_date.Protect=0
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('section_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	//dw_1.Retrieve(gs_user,ls_appr_ind,ld_date)
	dw_1.Retrieve(gs_user,ls_appr_ind)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
//	dw_1.settaborder('spr_date',0)
	
	cb_1.enabled = true
end if
//if (isnull(spr_rosend_dt) and spr_date =datetime(today()),0,1)
end event

type cb_1 from commandbutton within w_gteflf016_cash
integer x = 1221
integer y = 4
integer width = 265
integer height = 100
integer taborder = 30
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
	dw_1.reset()
end if

ls_ac_dt = em_2.text

if isnull(ls_ac_dt) or ls_ac_dt = '00/00/0000' or len(ls_ac_dt) = 0  then
	messagebox('Warning !','Please Enter The Plucking Date !!!')
	return 1
end if

ll_season = long(em_3.text)

if isnull(ll_season) or ll_season = 0 or len(em_3.text) = 0  then
	messagebox('Warning !','Please Enter The Season !!!')
	return 1
end if

if date(ls_ac_dt) > today()  then
	messagebox('Warning !','Plucking Date Should Not Be > Current Date, Please Check !!!')
	return 1
end if

select distinct 'x' into :ls_temp from fb_weatherreport where WR_DATE = to_date(:ls_ac_dt,'dd/mm/yyyy');

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Rainfall & Temperature Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 100 then
	if messagebox('Warning!','Please Enter Todays Rainfall & Temperature First !!!',information!,yesno!,1) = 1 then
		opensheetwithparm(w_gteflf015,9,w_mdi,0,layered!)
	else
		return 1
	end if
end if

//select max(SPR_DATE) into :ld_date from fb_sectionpluckinground;  		
//if sqlca.sqlcode = -1 then
//	messagebox('Error : While Getting Maximum Plucking Date',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//end if
//
//if ld_date >= datetime(em_2.text) then
//	messagebox('Warning!','Plucking Date Should Be > '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
//	return 1
//end if


dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'spr_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'spr_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'spr_date',datetime(em_2.text))
	dw_1.setitem(dw_1.getrow(),'spr_season',long(em_3.text))
	dw_1.setcolumn('section_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'spr_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'spr_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'spr_date',datetime(em_2.text))
	dw_1.setitem(dw_1.getrow(),'spr_season',long(em_3.text))
	dw_1.setcolumn('section_id')
end if


end event

type dw_1 from datawindow within w_gteflf016_cash
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 108
integer width = 4128
integer height = 2052
integer taborder = 50
string dataobject = "dw_gteflf016_cash"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'spr_entry_by',gs_user)
		dw_1.setitem(newrow,'spr_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'spr_date',dw_1.getitemdatetime(currentrow,'spr_date'))
		dw_1.setitem(newrow,'spr_pluccktype',dw_1.getitemstring(currentrow,'spr_pluccktype'))
		dw_1.setitem(newrow,'spr_plkrate',dw_1.getitemnumber(currentrow,'spr_plkrate'))
		dw_1.setitem(newrow,'spr_season',dw_1.getitemnumber(currentrow,'spr_season'))
		dw_1.setcolumn('section_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'section_id'  then	
		ls_section_id = data
		ld_spdate = dw_1.getitemdatetime(row,'spr_date')
		
		select sum(SPR_AREACOVERED) into :ld_totarea from fb_sectionpluckinground where section_id = :ls_section_id and SPR_DATE = :ld_spdate;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Total Section Area',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		select max(SPR_DATE) into :ld_date from fb_sectionpluckinground where section_id = :ls_section_id;  		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Maximum Plucking Date',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		select nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where section_id = :ls_section_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Area',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if gs_garden_state <> '03' and (gs_garden_snm <> 'LG' or (gs_garden_snm = 'LG' and date(ld_date) > date('17/04/2017'))) then
			if ld_date > ld_spdate or (ld_date = ld_spdate and ld_sec_area = ld_totarea) then
				messagebox('Warning!','Plucking Date Should Be > '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
				return 1
			end if		
		end if
		
			
			select nvl(RATE,0) into :ld_plkrt from fb_cashpluckingrate 
			 where KAMSUB_ID = 'ESUB0163' and  trunc(:ld_spdate) between CP_DT_FROM and nvl(CP_DT_TO,trunc(sysdate));
			 
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Cash Plucking Rate',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				dw_1.setitem(row,'spr_plkrate',ld_plkrt)
			end if
			
		
		
//		select distinct 'x' into :ls_temp
//		from fb_sectionpluckinground where SECTION_ID = :ls_section_id and trunc(spr_date) = trunc(sysdate);
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Warning!','Plucking Details Already Exists For The Selected Date, Please Check !!!')
//			return 1
//		end if
		
	end if
	
	if dwo.name = 'spr_date'  then
		ld_spdate = datetime(data)
		ls_section_id = dw_1.getitemstring(row,'section_id')
		ls_type = dw_1.getitemstring(row,'spr_pluccktype')
		
		if date(ld_spdate) > today() then
			messagebox('Warning !','Plucking Date Should Not Be > Current Date, Please Check !!!')
			return 1
		end if
		
		if f_check_initial_space(string(ld_spdate)) = -1 then return 1
		
		select sum(SPR_AREACOVERED) into :ld_totarea from fb_sectionpluckinground where section_id = :ls_section_id and SPR_DATE = :ld_spdate;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Total Section Area',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		select max(SPR_DATE) into :ld_date from fb_sectionpluckinground where section_id = :ls_section_id;  		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Maximum Plucking Date',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		select nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where section_id = :ls_section_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Area',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if gs_garden_state <> '03' then	
			if ld_date > ld_spdate or (ld_date = ld_spdate and ld_sec_area = ld_totarea) then
				messagebox('Warning!','Plucking Date Should Be > '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
				return 1
			end if
		end if
		if  wf_check_duplicate_rec(ls_section_id,ld_spdate,ls_type) = -1 then return 1
		
		select distinct 'x' into :ls_temp
		from fb_sectionpluckinground where SECTION_ID = :ls_section_id and trunc(spr_date) = trunc(:ld_spdate) and spr_pluccktype = :ls_type;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning!','Plucking Details Already Exists For The Selected Date, Please Check !!!')
			return 1
		end if
		
	end if
	if dwo.name = 'spr_pluccktype' then
		dw_1.setitem(row,'spr_plkrate',0)
		
		select distinct 'x' into :ls_temp
		from fb_sectionpluckinground where SECTION_ID = :ls_section_id and trunc(spr_date) = trunc(:ld_spdate) and spr_pluccktype = :ls_type;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning!','Plucking Details Already Exists For The Selected Date, Please Check !!!')
			return 1
		end if
		
		
		if  wf_check_duplicate_rec(ls_section_id,ld_spdate,data) = -1 then return 1
		
		if data = 'C' then
			
			select nvl(RATE,0) into :ld_plkrt from fb_cashpluckingrate 
			 where KAMSUB_ID = 'ESUB0163' and  trunc(:ld_spdate) between CP_DT_FROM and nvl(CP_DT_TO,trunc(sysdate));
			 
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Cash Plucking Rate',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				dw_1.setitem(row,'spr_plkrate',ld_plkrt)
			end if
			
		end if
		
	end if
	if dwo.name = 'spr_areacovered'  then
		ld_parea = double(data)
		ls_section_id = dw_1.getitemstring(dw_1.getrow(),'section_id')
		
		select  nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where SECTION_ID = :ls_section_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error!','While Getting Section Area '+sqlca.sqlerrtext)
			return 1
		end if
		
		if ld_parea > ld_sec_area then
			messagebox('Warning!','Plucked Area Cannot Be Greater Than Section Area, Please Check !!!')
			return 1
		end if;
	end if
	
	if dwo.name = 'spr_gl' then
		ld_plkrt =  dw_1.getitemnumber(row,'spr_plkrate')
		ld_spdate = dw_1.getitemdatetime(row,'spr_date')
		if isnull(ld_plkrt) then ld_plkrt = 0;

		if dw_1.getitemstring(row,'spr_pluccktype') = 'C' then
			select nvl(KAMSUB_AFRATE,0) into :ld_kam_rate from fb_kamsubhead where KAMSUB_ID = 'ESUB0163' and  KAMSUB_TYPE='PLUCK'  and trunc(:ld_spdate) between KAMSUB_FRDT and nvl(KAMSUB_TODT,trunc(sysdate));
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Plucking Kamjari Rate',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			if isnull(ld_kam_rate) then ld_kam_rate = 0;	
			ld_mdays = (double(data) * ld_plkrt) / ld_kam_rate
			dw_1.setitem(row,'spr_mandays',ld_mdays)
		end if
	end if
	
	dw_1.setitem(row,'spr_entry_by',gs_user)
	dw_1.setitem(row,'spr_entry_dt',datetime(today()))

	cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if
end event

