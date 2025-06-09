$PBExportHeader$w_gtelaf067.srw
forward
global type w_gtelaf067 from window
end type
type cb_4 from commandbutton within w_gtelaf067
end type
type cb_1 from commandbutton within w_gtelaf067
end type
type cb_3 from commandbutton within w_gtelaf067
end type
type cb_2 from commandbutton within w_gtelaf067
end type
type dw_1 from datawindow within w_gtelaf067
end type
end forward

global type w_gtelaf067 from window
integer width = 3776
integer height = 2300
boolean titlebar = true
string title = "(w_gtelaf064) POP Deduction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_1 cb_1
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelaf067 w_gtelaf067

type variables
long ll_ctr, ll_cnt,l_ctr,ll_st_year, ll_end_year,ll_user_level
string ls_temp,ls_tmp_id,ls_last,ls_count,ls_labour_id
boolean lb_neworder, lb_query
double ld_price
datetime ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_field_id, datetime fl_frdt, datetime fl_todt, long rownum)
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
	if (isnull(dw_1.getitemstring(fl_row,'field_id')) or  len(dw_1.getitemstring(fl_row,'field_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'fr_dt')) or  isnull(dw_1.getitemdatetime(fl_row,'to_dt')) or &
		 (isnull(dw_1.getitemnumber(fl_row,'no_of_entitled')))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Field ID, From Date, To Date, No. of Entitlement, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_field_id, datetime fl_frdt, datetime fl_todt, long rownum);long fl_row
string ls_field_id
datetime ld_frdt, ld_todt

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount())
		IF fl_row <> rownum then
			ls_field_id = dw_1.getitemstring(fl_row,'field_id')
			ld_frdt = dw_1.getitemdatetime(fl_row,'fr_dt')
			ld_todt = dw_1.getitemdatetime(fl_row,'to_dt')
			if ls_field_id = fs_field_id and ld_frdt = fl_frdt and ld_todt = fl_todt then
				dw_1.SelectRow(fl_row, TRUE)
				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
				return -1
			end if
		end if
	next
end if
return 1

end function

on w_gtelaf067.create
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_1,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_gtelaf067.destroy
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
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

type cb_4 from commandbutton within w_gtelaf067
integer x = 823
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

type cb_1 from commandbutton within w_gtelaf067
integer x = 27
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
boolean enabled = false
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

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_dt',datetime(today()))
	dw_1.settaborder('field_id',10)
	dw_1.settaborder('field_id_1',20)	
	dw_1.settaborder('fr_dt',30)	
	dw_1.settaborder('to_dt',40)
	dw_1.settaborder('no_of_entitled',50)	
	dw_1.setcolumn('field_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
end if

end event

type cb_3 from commandbutton within w_gtelaf067
integer x = 558
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
string text = "&Save"
end type

event clicked;string ls_temp_field_id
datetime ld_temp_frdt, ld_temp_todt

if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
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

type cb_2 from commandbutton within w_gtelaf067
integer x = 293
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
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve()	
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if
end event

type dw_1 from datawindow within w_gtelaf067
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 3698
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf067"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event key_down;string ls_temp_field_id
datetime ld_temp_frdt, ld_temp_todt

if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() and dw_1.rowcount() > 1 then	
		 ls_temp_field_id = dw_1.getitemstring(currentrow,'field_id')
		 ld_temp_frdt = dw_1.getitemdatetime(currentrow,'fr_dt')
		 ld_temp_todt = dw_1.getitemdatetime(currentrow,'to_dt')
		IF wf_check_fillcol(currentrow) = -1 or wf_check_duplicate_rec(ls_temp_field_id,ld_temp_frdt,ld_temp_todt,currentrow) = -1 THEN
			return 1
		END IF
		
		select distinct 'x' into :ls_temp from  fb_lpg_entitlement_mast where field_id = :ls_temp_field_id and ((:ld_temp_frdt between fr_dt and to_dt or :ld_temp_todt between fr_dt and to_dt )
		or (fr_dt between :ld_temp_frdt and :ld_temp_todt or to_dt between :ld_temp_frdt and :ld_temp_todt ));
		
		if sqlca.sqlcode = -1 then
			messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning','From Date and To Date can not be between existing periods')
			return 1
		end if
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'entry_by',gs_user)
		dw_1.setitem(newrow,'entry_dt',datetime(today()))
		
		dw_1.setcolumn('field_id')
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

event itemchanged;double ld_temp

if lb_query = false then
	if dwo.name = 'to_dt' then
		if not isnull(dw_1.getitemdatetime(row, 'fr_dt')) and datetime(dw_1.getitemdatetime(row, 'fr_dt')) >= datetime(data) then
			messagebox('Warning', 'To date cannot be less than or equal to From dt')
			return 1
		end if
	end if
	
	if dwo.name = 'fr_dt' then
		if not isnull(dw_1.getitemdatetime(row, 'to_dt')) and datetime(dw_1.getitemdatetime(row, 'to_dt')) <= datetime(data) then
			messagebox('Warning', 'To date cannot be less than or equal to From dt')
			return 1
		end if
	end if
	
	dw_1.setitem(row,'entry_by',gs_user)
	dw_1.setitem(row,'entry_by',datetime(today()))
	cb_3.enabled = true
end if	


if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

