$PBExportHeader$w_gtehrf005a.srw
forward
global type w_gtehrf005a from window
end type
type st_2 from statictext within w_gtehrf005a
end type
type ddlb_1 from dropdownlistbox within w_gtehrf005a
end type
type cb_2 from commandbutton within w_gtehrf005a
end type
type cb_1 from commandbutton within w_gtehrf005a
end type
type st_1 from statictext within w_gtehrf005a
end type
type dp_1 from datepicker within w_gtehrf005a
end type
type cb_4 from commandbutton within w_gtehrf005a
end type
type cb_3 from commandbutton within w_gtehrf005a
end type
type dw_1 from datawindow within w_gtehrf005a
end type
end forward

global type w_gtehrf005a from window
integer width = 4210
integer height = 2280
boolean titlebar = true
string title = "(w_gtehrf005a) Employee Attendance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dp_1 dp_1
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_gtehrf005a w_gtehrf005a

type variables
long ll_ctr, ll_cnt,l_ctr,ll_user_level,ll_year,ll_retage
string ls_temp,ls_del_ind,ls_tran_ty,ls_emp_id,ls_tmp_id,ls_entry_user,ls_last,ls_count,ls_emp_name,ls_division
boolean lb_neworder, lb_query
datetime ld_rundt
double ld_sick, ld_mat, ld_cl, ld_el, ld_year

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_tran_ty, string fs_supp, datetime fs_plk_dt)
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

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'gt_type')) or  len(dw_1.getitemstring(fl_row,'gt_type'))=0 or &
//		isnull(dw_1.getitemstring(fl_row,'sup_id')) or  len(dw_1.getitemstring(fl_row,'sup_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'pluckingdate')) or &
//		 isnull(dw_1.getitemnumber(fl_row,'gt_unitprice')) or dw_1.getitemnumber(fl_row,'gt_unitprice')=0 or &
//		 isnull(dw_1.getitemnumber(fl_row,'gt_quantity')) or dw_1.getitemnumber(fl_row,'gt_quantity')=0) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Transaction Type, Supplier, Plucking Date, Unit Price, Quantity Please Check !!!')
//		 return -1
//	end if
//end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_tran_ty, string fs_supp, datetime fs_plk_dt);//long fl_row
//string ls_tran_ty1,ls_supp1
//datetime ld_plk_dt1
//
//dw_1.SelectRow(0, FALSE)
//if dw_1.rowcount() > 1 then
//	for fl_row = 1 to (dw_1.rowcount() - 1)
//		ls_tran_ty1 = dw_1.getitemstring(fl_row,'gt_type')
//		ls_supp1 = dw_1.getitemstring(fl_row,'sup_id')
//		ld_plk_dt1 = dw_1.getitemdatetime(fl_row,'pluckingdate')
//		
//		if ls_tran_ty1 = fs_tran_ty and ls_supp1 = fs_supp and ld_plk_dt1 = fs_plk_dt then
//			dw_1.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
//end if 

return 1
end function

on w_gtehrf005a.create
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dp_1=create dp_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dp_1,&
this.cb_4,&
this.cb_3,&
this.dw_1}
end on

on w_gtehrf005a.destroy
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.cb_4)
destroy(this.cb_3)
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

setpointer(hourglass!)

ddlb_1.reset()
//ddlb_1.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if

//ddlb_1.text = 'ALL'
setpointer(arrow!)
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

type st_2 from statictext within w_gtehrf005a
integer x = 18
integer y = 28
integer width = 215
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrf005a
integer x = 238
integer y = 16
integer width = 1266
integer height = 608
integer taborder = 10
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

type cb_2 from commandbutton within w_gtehrf005a
integer x = 2633
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
string text = "&Query"
end type

event clicked;if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select Division !!!')
	return 
end if

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if
ls_division = left(right(ddlb_1.text,6),5)

ld_rundt = datetime(dp_1.text)

select distinct 'x' into :ls_temp from fb_empattendance_summary b where  (nvl(es_year,0) * 100 + nvl(es_month,0)) = to_number(to_char(:ld_rundt,'yyyymm'));
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning!','Attendance Reading For Selected Date Not Exists, Please Check !!!')
	return 1
end if

if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	dw_1.settaborder('es_empid',5)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('es_empid')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,long(string(ld_rundt,'YYYYMM')),ls_division)
	dw_1.settaborder('es_empid',0)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf005a
integer x = 2368
integer y = 8
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
end if
dw_1.reset()

dw_1.settransobject(sqlca)

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select Division !!!')
	return 
end if

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

ls_division = left(right(ddlb_1.text,6),5)

ld_rundt = datetime(dp_1.text)


DECLARE c1 CURSOR FOR  
select EMP_ID from fb_employee a where nvl(EMP_ACTIVE,'1') = '1' and emp_type in ('ST','SS','AT') and FIELD_ID = :ls_division and
	   not exists (select distinct es_empid from fb_empattendance_summary b where (nvl(es_year,0) * 100 + nvl(es_month,0)) = to_number(to_char(:ld_rundt,'yyyymm')) and es_empid = a.emp_id)
order by emp_id;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_emp_id;
	
	do while sqlca.sqlcode <> 100
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'es_empid',ls_emp_id)
		dw_1.setitem(dw_1.getrow(),'es_year',long(string(ld_rundt,'yyyy')))
		dw_1.setitem(dw_1.getrow(),'es_month',long(string(ld_rundt,'mm')))
		dw_1.setitem(dw_1.getrow(),'es_division',ls_division)
		dw_1.setitem(dw_1.getrow(),'es_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'es_entry_dt',datetime(today()))
		fetch c1 into :ls_emp_id;
	loop
END IF
close c1;
dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('es_present')
lb_neworder = true
lb_query = false


end event

type st_1 from statictext within w_gtehrf005a
integer x = 1554
integer y = 28
integer width = 407
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Attendance Date"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtehrf005a
integer x = 1966
integer y = 16
integer width = 384
integer height = 84
integer taborder = 20
boolean border = true
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-07-10"), Time("10:36:38.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_4 from commandbutton within w_gtehrf005a
integer x = 3159
integer y = 8
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

type cb_3 from commandbutton within w_gtehrf005a
integer x = 2894
integer y = 8
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

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'es_present')) or dw_1.getitemnumber(ll_ctr,'es_present') = 0) THEN
			 dw_1.deleterow(ll_ctr)
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

type dw_1 from datawindow within w_gtehrf005a
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 116
integer width = 4160
integer height = 2052
string dataobject = "dw_gtehrf005a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;//if lb_query = false then
// if lb_neworder = true then	
//	if currentrow <> dw_1.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
//	END If
//	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
//		dw_1.setitem(newrow,'eatten_entry_by',gs_user)
//		dw_1.setitem(newrow,'eatten_entry_dt',datetime(today()))
//		dw_1.setitem(newrow,'eatten_date',datetime(today()))
//		dw_1.setcolumn('emp_id')
//	end if
// end if
//end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then

	if dwo.name = 'es_present'  then
		ls_emp_id = dw_1.getitemstring(row,'es_empid')
		
		// Checking Employee Retirement Age
		
		select ((trunc(sysdate) - trunc(EMP_DOB))/365) into :ld_year from fb_employee where emp_id = :ls_emp_id; 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		if isnull(ld_year) then ld_year = 0
		
		select nvl(PD_VALUE,0) into :ll_retage from fb_param_detail where PD_DOC_TYPE = 'RETIREMENT' and PD_PERIOD_TO is null;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Retirement Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if isnull(ll_retage) then ll_retage = 0
		
		if ld_year >= ll_retage then
			messagebox('Warning!','Employee Has Reached Retirement Age, Please Check !!!')
			return 1
		end if
		
		// Checking Employee Retirement Age
	end if	
	if dwo.name = 'es_maternity' then
		select EMP_SEX into :ls_temp from fb_employee where emp_id = :ls_emp_id;
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if	
	
		if double(data) > 0 and ls_temp = 'M' then
			messagebox('Warning','Maternity Leave Is Applicaple For Female Employees Only, Please Check !!!')
			return 1
		end if
		
//		select sum(nvl(decode(nvl(EATTEN_STATUS,'X'),'SI',1,0),0)), sum(nvl(decode(nvl(EATTEN_STATUS,'X'),'MA',1,0),0)) ,
//		         sum(nvl(decode(nvl(EATTEN_STATUS,'X'),'CL',1,0),0)), sum(nvl(decode(nvl(EATTEN_STATUS,'X'),'CL',1,0),0))
//		into :ld_sick, :ld_mat, :ld_cl, :ld_el from fb_empattendance 
//		where EMP_ID = :ls_emp_id and trunc(EATTEN_DATE) between to_date('01/01/'||to_char(sysdate,'YYYY'),'dd/mm/yyyy') and trunc(sysdate);
//									
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Maternity Availed Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		end if
//		if isnull(ld_sick) then ld_sick = 0;
//		if isnull(ld_mat) then ld_mat = 0;
//		if isnull(ld_cl) then ld_cl = 0;
//		if isnull(ld_el) then ld_el = 0;
//		
//		if ld_sick >= 14 then
//			messagebox('Warning !','This Employee Has Already Availed 14 Days Sick Leave This Year, Pleae Check !!!')
//			return 1
//		end if
//		
//		if ld_mat >= 84 then
//			messagebox('Warning !','This Employee Has Already Availed 84 Days Maternity Leave This Year, Pleae Check !!!')
//			return 1
//		end if
	end if

	dw_1.setitem(row,'es_entry_by',gs_user)
	dw_1.setitem(row,'es_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if

end event

