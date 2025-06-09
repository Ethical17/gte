$PBExportHeader$w_gtelaf063.srw
forward
global type w_gtelaf063 from window
end type
type cb_4 from commandbutton within w_gtelaf063
end type
type cb_1 from commandbutton within w_gtelaf063
end type
type cb_3 from commandbutton within w_gtelaf063
end type
type cb_2 from commandbutton within w_gtelaf063
end type
type dw_1 from datawindow within w_gtelaf063
end type
end forward

global type w_gtelaf063 from window
integer width = 3346
integer height = 2300
boolean titlebar = true
string title = "(w_gtelaf063) LPG Issue Entry"
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
global w_gtelaf063 w_gtelaf063

type variables
long ll_ctr, ll_cnt,l_ctr,ll_st_year, ll_end_year,ll_user_level
string ls_temp,ls_tmp_id,ls_last,ls_count,ls_labour_id
boolean lb_neworder, lb_query
double ld_price
datetime ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_lab_id, datetime fl_dt, long rownum)
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
	if (isnull(dw_1.getitemstring(fl_row,'emp_id')) or  len(dw_1.getitemstring(fl_row,'emp_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'lsm_issue_Date')) or &
		 (isnull(dw_1.getitemnumber(fl_row,'lsm_subs_amount')))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Labour ID, Issue Date, Subsidy Amount, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_lab_id, datetime fl_dt, long rownum);long fl_row
string ls_lab_id1
datetime ld_issue_dt

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount())
		IF fl_row <> rownum then
			ls_lab_id1 = dw_1.getitemstring(fl_row,'emp_id')
			ld_issue_dt = dw_1.getitemdatetime(fl_row,'lsm_issue_Date')
			if ls_lab_id1 = fs_lab_id and ld_issue_dt = fl_dt then
				dw_1.SelectRow(fl_row, TRUE)
				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
				return -1
			end if
		end if
	next
end if
return 1

//EB_EMPID, EB_YRMON, EB_AMOUNT, EB_PFFLAG, EB_ENTRY_BY, EB_ENTRY_DT, rowid
end function

on w_gtelaf063.create
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

on w_gtelaf063.destroy
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

type cb_4 from commandbutton within w_gtelaf063
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

type cb_1 from commandbutton within w_gtelaf063
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
	dw_1.setitem(dw_1.getrow(),'lsm_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lsm_entry_dt',datetime(today()))
	dw_1.settaborder('emp_id',10)
	dw_1.settaborder('emp_id_1',20)	
	dw_1.settaborder('lsm_issue_Date',30)
	dw_1.settaborder('lsm_subs_amount',40)	
	dw_1.setcolumn('emp_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'lsm_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'lsm_entry_dt',datetime(today()))
	dw_1.setcolumn('emp_id')
end if

end event

type cb_3 from commandbutton within w_gtelaf063
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

event clicked;string ls_temp_empid
datetime ld_temp_isdt, ld_Startdt, ld_Enddt
long ll_no_entitled, ll_no_alloted

if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'emp_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'emp_id')) = 0 ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		 ls_temp_empid = dw_1.getitemstring(dw_1.getrow(),'emp_id')
		 ld_temp_isdt = dw_1.getitemdatetime(dw_1.getrow(),'lsm_issue_Date')
		IF wf_check_fillcol(dw_1.getrow()) = -1 or wf_check_duplicate_rec(ls_temp_empid,ld_temp_isdt,dw_1.getrow()) = -1 THEN
			return 1
		END IF
		select distinct 'x' into :ls_temp from  fb_lpg_subsidy_mast where emp_id = :ls_temp_empid and lsm_issue_Date = :ld_temp_isdt;
		if sqlca.sqlcode = -1 then
			messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning','A record for this Labour and Issue Date already exists in system')
			return 1
		end if
		
		select fr_dt, to_dt, no_of_entitled into :ld_startdt, :ld_enddt, :ll_no_Entitled from fb_lpg_entitlement_mast a, fb_field b, fb_employee c where a.field_id = b.field_id and b.field_id = c.field_id and 
		c.emp_id = :ls_temp_empid and :ld_temp_isdt between fr_dt and to_dt;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking existing records : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Warning', 'Period start date, end date and number of entitlement not found in LPG Entitlement Master, Please check')
			return 1
		end if
		
		select count(*) into :ll_no_alloted from fb_lpg_Subsidy_mast where emp_id = :ls_temp_empid and lsm_issue_Date between :ld_startdt and :ld_enddt;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking existing records : '+sqlca.sqlerrtext)
			return 1
		end if
		
		if isnull(ll_no_alloted) then ll_no_alloted = 0;
		
		if ll_no_alloted >= ll_no_entitled then
			messagebox('Warning', 'Labour '+ls_temp_empid+' has already been issued LPG ' +string(ll_no_alloted)+ ' times between '+string(ld_startdt)+' and '+string(ld_enddt))
			return 1
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

type cb_2 from commandbutton within w_gtelaf063
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
	dw_1.settaborder('emp_id',0)
	dw_1.settaborder('emp_id_1',0)	
	dw_1.settaborder('lsm_issue_Date',0)
	dw_1.settaborder('lsm_subs_amount',0)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if
end event

type dw_1 from datawindow within w_gtelaf063
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 3273
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf063"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event key_down;string ls_temp_empid
datetime ld_temp_isdt, ld_startdt, ld_enddt
long ll_no_entitled, ll_no_alloted

if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() and dw_1.rowcount() > 1 then	
		 ls_temp_empid = dw_1.getitemstring(currentrow,'emp_id')
		 ld_temp_isdt = dw_1.getitemdatetime(currentrow,'lsm_issue_Date')
		IF wf_check_fillcol(currentrow) = -1 or wf_check_duplicate_rec(ls_temp_empid,ld_temp_isdt,currentrow) = -1 THEN
			return 1
		END IF
		select distinct 'x' into :ls_temp from fb_lpg_Subsidy_mast where emp_id = :ls_temp_empid and lsm_issue_Date = :ld_temp_isdt;
		if sqlca.sqlcode = -1 then
			messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning','A record for this Labour and Issue date already exists in system')
			return 1
		end if
		
		select fr_dt, to_dt, no_of_entitled into :ld_startdt, :ld_enddt, :ll_no_Entitled from fb_lpg_entitlement_mast a, fb_field b, fb_employee c where a.field_id = b.field_id and b.field_id = c.field_id and 
		c.emp_id = :ls_temp_empid and :ld_temp_isdt between fr_dt and to_dt;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking existing records : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Warning', 'Period start date, end date and number of entitlement not found in LPG Entitlement Master, Please check')
			return 1
		end if
		
		select count(*) into :ll_no_alloted from fb_lpg_Subsidy_mast where emp_id = :ls_temp_empid and lsm_issue_Date between :ld_startdt and :ld_enddt;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking existing records : '+sqlca.sqlerrtext)
			return 1
		end if
		
		if isnull(ll_no_alloted) then ll_no_alloted = 0;
		
		if ll_no_alloted >= ll_no_entitled then
			messagebox('Warning', 'Labour '+ls_temp_empid+' has already been issued LPG ' +string(ll_no_alloted)+ ' times between '+string(ld_startdt)+' and '+string(ld_enddt))
			return 1
		end if
		
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'lsm_entry_by',gs_user)
		dw_1.setitem(newrow,'lsm_entry_dt',datetime(today()))
		
		dw_1.setcolumn('emp_id')
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
	if dwo.name = 'lsm_issue_date' then
		if date(data) > today() then 
			messagebox('Warning', 'Issue date should be less than or equal to current date')
			return 1
		end if
	end if
	dw_1.setitem(row,'lsm_entry_by',gs_user)
	dw_1.setitem(row,'lsm_entry_dt',datetime(today()))
	cb_3.enabled = true
end if	


if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

