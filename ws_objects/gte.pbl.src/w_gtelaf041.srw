$PBExportHeader$w_gtelaf041.srw
forward
global type w_gtelaf041 from window
end type
type st_1 from statictext within w_gtelaf041
end type
type dp_1 from datepicker within w_gtelaf041
end type
type cb_4 from commandbutton within w_gtelaf041
end type
type cb_3 from commandbutton within w_gtelaf041
end type
type cb_2 from commandbutton within w_gtelaf041
end type
type cb_1 from commandbutton within w_gtelaf041
end type
type dw_1 from datawindow within w_gtelaf041
end type
end forward

global type w_gtelaf041 from window
integer width = 2921
integer height = 2384
boolean titlebar = true
string title = "(w_gtelaf041) PF Opening"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
dp_1 dp_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf041 w_gtelaf041

type variables
long ll_ctr, ll_cnt, ll_year, ll_last, ll_st_year, ll_end_year,ll_user_level,ll_temp
string ls_temp,ls_name,ls_id,ls_pfno,ls_dt
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt, ld_ldt, ld_pdt, ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt)
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
	if (isnull(dw_1.getitemdatetime(fl_row,'lww_startdate')) or isnull(dw_1.getitemdatetime(fl_row,'lww_enddate'))) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Season Start Date, Season End Date,  Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (datetime fd_frdt, datetime fd_todt);long fl_row
datetime ld_fdt1, ld_todt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ld_fdt1 = dw_1.getitemdatetime(fl_row,'lww_startdate')
		ld_todt1 = dw_1.getitemdatetime(fl_row,'lww_enddate')
		
		if ld_fdt1 = fd_frdt and ld_todt1 = fd_todt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf041.create
this.st_1=create st_1
this.dp_1=create dp_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dp_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf041.destroy
destroy(this.st_1)
destroy(this.dp_1)
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
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

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

type st_1 from statictext within w_gtelaf041
integer x = 14
integer y = 28
integer width = 315
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Opening Date"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelaf041
integer x = 334
integer y = 16
integer width = 402
integer height = 88
integer taborder = 10
boolean border = true
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-07-10"), Time("11:09:45.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_4 from commandbutton within w_gtelaf041
integer x = 1536
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

type cb_3 from commandbutton within w_gtelaf041
integer x = 1271
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

IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'la_pfopening')) or dw_1.getitemnumber(dw_1.rowcount(),'la_pfopening') = 0 ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if dw_1.rowcount() > 0 then
//		IF wf_check_fillcol(ll_ctr) = -1 THEN 
//			return 1
//		end if
	end if
	for ll_cnt = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_cnt,'la_pfopening')) or dw_1.getitemnumber(ll_cnt,'la_pfopening') = 0 ) THEN
			 dw_1.deleterow(ll_cnt)
		END IF
	next

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

type cb_2 from commandbutton within w_gtelaf041
integer x = 1006
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
string text = "&Query"
end type

event clicked;if isnull(dp_1.text)  then
	messagebox('Warning!','Please Select An Opening Date, Please Check !!!')
	return 1
end if

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

ls_dt = dp_1.text

if cb_2.text = "&Query" then
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
	dw_1.Retrieve(ls_dt)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf041
integer x = 741
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
	dw_1.reset()
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if isnull(dp_1.text)  then
	messagebox('Warning!','Please Select An Opening Date, Please Check !!!')
	return 1
end if

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

ld_dt = dp_1.value

DECLARE c1 CURSOR FOR  
select emp_ID, EMP_PFNO, emp_name from fb_employee 
where nvl(EMP_ACTIVE,'0') = '1' and EMP_PFNO is not null and 
		not exists (select labour_id from fb_labouradvance where la_date = trunc(:ld_dt) and labour_id = emp_id) order by EMP_PFNO;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_id, :ls_pfno, :ls_name;
	
	do while sqlca.sqlcode <> 100
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'labour_id',ls_id)
		dw_1.setitem(dw_1.getrow(),'emp_pfno',ls_pfno)
		dw_1.setitem(dw_1.getrow(),'emp_name',ls_name)
		dw_1.setitem(dw_1.getrow(),'la_date',date(ld_dt))
		dw_1.setitem(dw_1.getrow(),'la_pfopening',0)
		dw_1.setitem(dw_1.getrow(),'la_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'la_entry_dt',datetime(today()))
		setnull(ls_id);setnull(ls_pfno);setnull(ls_name);
		fetch c1 into :ls_id, :ls_pfno, :ls_name;
	loop
END IF
close c1;
dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('la_pfopening')
lb_neworder = true
lb_query = false


//if dw_1.rowcount() = 0 then
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'lww_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'lww_entry_dt',datetime(today()))
//	dw_1.setcolumn('lww_startdate')
//else
//	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
//		return 1
//	END IF
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'lww_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'lww_entry_dt',datetime(today()))
//	dw_1.setcolumn('lww_startdate')
//end if


end event

type dw_1 from datawindow within w_gtelaf041
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 2830
integer height = 2052
integer taborder = 40
string dataobject = "dw_gtelaf041"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
//	if currentrow <> dw_1.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
//	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'la_entry_by',gs_user)
		dw_1.setitem(newrow,'la_entry_dt',datetime(today()))
		dw_1.setcolumn('la_pfopening')
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
	cb_3.enabled = true
end if

end event

