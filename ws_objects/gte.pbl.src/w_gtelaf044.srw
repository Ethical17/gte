$PBExportHeader$w_gtelaf044.srw
forward
global type w_gtelaf044 from window
end type
type cb_4 from commandbutton within w_gtelaf044
end type
type cb_3 from commandbutton within w_gtelaf044
end type
type cb_2 from commandbutton within w_gtelaf044
end type
type cb_1 from commandbutton within w_gtelaf044
end type
type dw_1 from datawindow within w_gtelaf044
end type
end forward

global type w_gtelaf044 from window
integer width = 4037
integer height = 2280
boolean titlebar = true
string title = "(w_gtelaf044) Special Deductions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf044 w_gtelaf044

type variables
long ll_ctr, ll_cnt, ll_year, ll_last, ll_st_year, ll_end_year,ll_user_level,ll_temp,ll_paybook
string ls_temp,ls_name,ls_last,ls_type,ls_tmp_id,ls_count, ls_field,ls_emp_type, ls_lww_id,ls_dt, ls_dedtype
double ld_instamt, ld_totamt
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt, ld_ldt, ld_pdt, ld_dt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_division, string fs_emp_ty, string fs_dedty, datetime fd_frdt)
end prototypes

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if ( isnull(dw_1.getitemstring(fl_row,'field_id'))  or len(dw_1.getitemstring(fl_row,'field_id')) = 0 or &
		isnull(dw_1.getitemstring(fl_row,'sd_type'))  or len(dw_1.getitemstring(fl_row,'sd_type')) = 0 or &
		isnull(dw_1.getitemstring(fl_row,'emp_type'))  or len(dw_1.getitemstring(fl_row,'emp_type')) = 0 or &
		isnull(dw_1.getitemstring(fl_row,'sd_dedtype'))  or len(dw_1.getitemstring(fl_row,'sd_dedtype')) = 0 or &
		isnull(dw_1.getitemdatetime(fl_row,'sd_from_dt')) or string(dw_1.getitemdatetime(fl_row,'sd_from_dt')) = '00/00/0000' or &
		isnull(dw_1.getitemnumber(fl_row,'sd_installment_amt')) or dw_1.getitemnumber(fl_row,'sd_installment_amt') = 0 or &
		isnull(dw_1.getitemnumber(fl_row,'sd_netded_amt')) or dw_1.getitemnumber(fl_row,'sd_netded_amt') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Division, Worker Type, Deduction Type, Fixed / Installement, From Date, Installment Amt Or Total Amount ,  Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_division, string fs_emp_ty, string fs_dedty, datetime fd_frdt);long fl_row
datetime ld_fdt1
string ls_empty, ls_dedty, ls_div 

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ld_fdt1 = dw_1.getitemdatetime(fl_row,'sd_from_dt')
		ls_dedty = dw_1.getitemstring(fl_row,'sd_type')
		ls_div = dw_1.getitemstring(fl_row,'field_id')
		ls_empty = dw_1.getitemstring(fl_row,'emp_type')
		
		if ld_fdt1 = fd_frdt and ls_empty = fs_emp_ty  and ls_div = fs_division and ls_dedty = fs_dedty then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf044.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf044.destroy
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

type cb_4 from commandbutton within w_gtelaf044
integer x = 814
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

type cb_3 from commandbutton within w_gtelaf044
integer x = 549
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
//	for ll_ctr = dw_1.rowcount() to 1 step -1
//		if dw_1.getitemstring(ll_ctr,'em_pfind') = 'N' and dw_1.getitemstring(ll_ctr,'em_bonusind') = 'N' and dw_1.getitemstring(ll_ctr,'em_lwwind') = 'N' then
//			dw_1.deleterow(ll_ctr)
//		end if
//	next
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

type cb_2 from commandbutton within w_gtelaf044
integer x = 283
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
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf044
integer x = 18
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

event clicked;date ld_dtfr, ld_dtto

if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
end if


lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sd_entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sd_entry_dt',datetime(today()))
	dw_1.setcolumn('field_id')
end if


end event

type dw_1 from datawindow within w_gtelaf044
event key_down pbm_dwnrowchanging
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 3982
integer height = 2052
string dataobject = "dw_gtelaf044"
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
		dw_1.setitem(newrow,'sd_entry_by',gs_user)
		dw_1.setitem(newrow,'sd_entry_dt',datetime(today()))
		dw_1.setcolumn('field_id')
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
	
	if dwo.name = 'sd_installment_amt'  then
		ld_instamt = double(data)
		ls_dedtype = dw_1.getitemstring(row,'sd_dedtype')
		dw_1.setitem(row,'sd_netded_amt',ld_instamt)
	end if
	
	
	if dwo.name = 'sd_from_dt'  then
		ld_frdt = datetime(data)
		ls_emp_type = dw_1.getitemstring(row,'emp_type')
		ls_type = dw_1.getitemstring(row,'sd_type')
		ls_field = dw_1.getitemstring(row,'field_id')
		
//		if date(ld_frdt) < date(ld_frdt) then
//			messagebox('Warning!','Start Date Should Be < End Date, Please Check !!!')
//			return 1
//		end if
		
		if  wf_check_duplicate_rec(ls_field,ls_emp_type, ls_type, ld_frdt) = -1 then return 1
			
//		if ld_dt <> ld_frdt then
//			messagebox('Warning!','Please Select The Start day Of Week !!!')
//			return 1
//		end if
		
		select distinct 'x' into :ls_temp from FB_LABSPLDEDUCTION where field_id = :ls_field and emp_type = :ls_emp_type and sd_type = :ls_type and trunc(sd_from_dt) = trunc(:ld_frdt);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Ration Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Duplicate Entry Existing for this Date, Please Check !!!')
			return 1
		end if

	end if

	dw_1.setitem(row,'sd_entry_by',gs_user)
	dw_1.setitem(row,'sd_entry_dt',datetime(today()))

cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

