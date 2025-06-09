$PBExportHeader$w_gtehrf016.srw
forward
global type w_gtehrf016 from window
end type
type em_1 from editmask within w_gtehrf016
end type
type st_1 from statictext within w_gtehrf016
end type
type cb_4 from commandbutton within w_gtehrf016
end type
type cb_3 from commandbutton within w_gtehrf016
end type
type cb_2 from commandbutton within w_gtehrf016
end type
type cb_1 from commandbutton within w_gtehrf016
end type
type dw_1 from datawindow within w_gtehrf016
end type
end forward

global type w_gtehrf016 from window
integer width = 3666
integer height = 2284
boolean titlebar = true
string title = "(w_gtehrf016) Eletricity Deduction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtehrf016 w_gtehrf016

type variables
long ll_ctr, ll_cnt,l_ctr,ll_st_year, ll_end_year,ll_last,ll_user_level,ll_runyrmn
string ls_temp,ls_tmp_id,ls_last,ls_count,ls_labour_id,ls_emp_id
boolean lb_neworder, lb_query
double ld_price
datetime ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_lab_id, datetime fs_dt)
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
	if (isnull(dw_1.getitemnumber(fl_row,'edg_electricded')) or dw_1.getitemnumber(fl_row,'edg_electricded')=0 or &
	    isnull(dw_1.getitemstring(fl_row,'edg_desc')) or len(dw_1.getitemstring(fl_row,'edg_desc')) =0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Electricity Deduction Amount, Description, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_lab_id, datetime fs_dt);long fl_row
string ls_lab_id1
datetime ld_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_lab_id1 = dw_1.getitemstring(fl_row,'labour_id')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'la_date')
		
		if ls_lab_id1 = fs_lab_id and ld_dt1 = fs_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtehrf016.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtehrf016.destroy
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

type em_1 from editmask within w_gtehrf016
integer x = 315
integer y = 24
integer width = 201
integer height = 80
integer taborder = 70
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
string mask = "YYYYMM"
end type

type st_1 from statictext within w_gtehrf016
integer x = 9
integer y = 32
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gtehrf016
integer x = 1339
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

type cb_3 from commandbutton within w_gtehrf016
integer x = 1074
integer y = 12
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

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'ed_amount')) or dw_1.getitemnumber(ll_ctr,'ed_amount') = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next	

	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
			dw_1.deleterow(ll_ctr)
		end if
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

type cb_2 from commandbutton within w_gtehrf016
integer x = 809
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
//	dw_1.setcolumn('ed_electricded')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf016
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
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

ll_runyrmn = long(em_1.text) 

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

DECLARE c1 CURSOR FOR  
select EMP_ID from fb_employee a where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('ST','SS','AT') and 
	   not exists (select distinct ed_empid from FB_EMPELECTRICDED b where ((ED_YEAR * 100) +  ED_Month) = trunc(:ll_runyrmn) and b.ed_empid = a.emp_id)
order by emp_id;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_emp_id;
	
	do while sqlca.sqlcode <> 100
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'ed_empid',ls_emp_id)
		dw_1.setitem(dw_1.getrow(),'ed_year',long(left(string(ll_runyrmn),4)))
		dw_1.setitem(dw_1.getrow(),'ed_month',long(right(string(ll_runyrmn),2)))
		dw_1.setitem(dw_1.getrow(),'ed_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'ed_entry_dt',datetime(today()))
		fetch c1 into :ls_emp_id;
	loop
END IF
close c1;
dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('ed_amount')
lb_neworder = true
lb_query = false


end event

type dw_1 from datawindow within w_gtehrf016
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 120
integer width = 3598
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtehrf016"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
//	if currentrow <> dw_1.rowcount() then
////		IF wf_check_fillcol(currentrow) = -1 THEN
////			return 1
////		END IF
//	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'ed_entry_by',gs_user)
		dw_1.setitem(newrow,'ed_entry_dt',datetime(today()))
		dw_1.setcolumn('ed_amount')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
//	if dwo.name = 'edg_date'  then
//		ld_dt = datetime(data)
//		ls_labour_id = dw_1.getitemstring(row,'labour_id')
//		
//		if long(string(today(),'mm')) < 4 then
//			ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
//			ll_end_year = (long(string(today(),'YYYY'))*100)+3;
//		else
//			ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
//			ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
//		end if;
//	
//		if (long(right(string(ld_dt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_dt,'dd/mm/yyyy'),4,2))) < ll_st_year or &
//			(long(right(string(ld_dt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_dt,'dd/mm/yyyy'),4,2)))  > ll_end_year then
//			messagebox('Warning!','Date Should Be Between Current Financial Year, Please Check !!!')
//			return 1
//		end if
//	
//		
//		if  wf_check_duplicate_rec(ls_labour_id,ld_dt) = -1 then return 1
//		
//		select distinct 'x' into :ls_temp from fb_labouradvance where labour_id = :ls_labour_id and trunc(edg_date) = :ld_dt;
//	
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Transaction Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode  = 0 then
//			messagebox('Warning!','Entry Already Exists For This Employee and Date, Please Check !!!')
//			return 1
//		end if	
//	end if
	dw_1.setitem(row,'ed_entry_by',gs_user)
	dw_1.setitem(row,'ed_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

