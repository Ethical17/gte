$PBExportHeader$w_gtehrf033.srw
forward
global type w_gtehrf033 from window
end type
type cbx_1 from checkbox within w_gtehrf033
end type
type cb_2 from commandbutton within w_gtehrf033
end type
type cb_1 from commandbutton within w_gtehrf033
end type
type cb_4 from commandbutton within w_gtehrf033
end type
type cb_3 from commandbutton within w_gtehrf033
end type
type dw_1 from datawindow within w_gtehrf033
end type
end forward

global type w_gtehrf033 from window
integer width = 4645
integer height = 2280
boolean titlebar = true
string title = "(w_gtehrf033) Employee Promotion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_1 cbx_1
cb_2 cb_2
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
dw_1 dw_1
end type
global w_gtehrf033 w_gtehrf033

type variables
long ll_ctr, ll_cnt,l_ctr,ll_user_level
string ls_temp,ls_emp_id,ls_appr_ind,ls_emp_type,ls_emp_grade
boolean lb_neworder, lb_query
decimal ld_basic


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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'gt_type')) or  len(dw_1.getitemstring(fl_row,'gt_type'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'sup_id')) or  len(dw_1.getitemstring(fl_row,'sup_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'pluckingdate')) or &
		 isnull(dw_1.getitemnumber(fl_row,'gt_unitprice')) or dw_1.getitemnumber(fl_row,'gt_unitprice')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'gt_quantity')) or dw_1.getitemnumber(fl_row,'gt_quantity')=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Transaction Type, Supplier, Plucking Date, Unit Price, Quantity Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_tran_ty, string fs_supp, datetime fs_plk_dt);long fl_row
string ls_tran_ty1,ls_supp1
datetime ld_plk_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tran_ty1 = dw_1.getitemstring(fl_row,'gt_type')
		ls_supp1 = dw_1.getitemstring(fl_row,'sup_id')
		ld_plk_dt1 = dw_1.getitemdatetime(fl_row,'pluckingdate')
		
		if ls_tran_ty1 = fs_tran_ty and ls_supp1 = fs_supp and ld_plk_dt1 = fs_plk_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtehrf033.create
this.cbx_1=create cbx_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.cb_2,&
this.cb_1,&
this.cb_4,&
this.cb_3,&
this.dw_1}
end on

on w_gtehrf033.destroy
destroy(this.cbx_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
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

type cbx_1 from checkbox within w_gtehrf033
integer x = 1115
integer y = 16
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "UnApprove"
boolean checked = true
end type

type cb_2 from commandbutton within w_gtehrf033
integer x = 279
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
string text = "&Query"
end type

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if
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
	dw_1.setcolumn('emp_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ls_appr_ind,string(ll_user_level))
	
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf033
integer x = 14
integer y = 4
integer width = 265
integer height = 100
integer taborder = 50
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
dw_1.insertrow(0)
lb_neworder = true
lb_query = false

end event

type cb_4 from commandbutton within w_gtehrf033
integer x = 805
integer y = 4
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

type cb_3 from commandbutton within w_gtehrf033
integer x = 539
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		
		
		
		IF (isnull(dw_1.getitemstring(ll_ctr,'emp_id')) or len(dw_1.getitemstring(ll_ctr,'emp_id')) = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
		
	if isnull(dw_1.getitemstring(ll_ctr,'ep_remarks')) then
			messagebox('Warning','Reason Is Mandatory')
			return 
		end if	
		
			
		
		if dw_1.getitemstring(ll_ctr,'appr_ind') ='Y'  then
			setnull(ls_emp_id);setnull(ls_emp_grade);setnull(ls_emp_type);setnull(ld_basic);
			ls_emp_id=dw_1.getitemstring(ll_ctr,'emp_id')

			ls_emp_grade=dw_1.getitemstring(ll_ctr,'emp_grade_new')
			ls_emp_type=dw_1.getitemstring(ll_ctr,'emp_type_new')
			ld_basic=dw_1.getitemdecimal(ll_ctr,'ebs_basicamount_new')
			
			if isnull(ls_emp_grade) or isnull(ls_emp_type) or ld_basic=0 then
				messagebox('Warning','New Grade or Type or Basic is Blank or zero')	
				rollback;
				return 1
			end  if
			
			
			update fb_employee set EMP_TYPE=:ls_emp_type,emp_grade=:ls_emp_grade,EBS_BASICAMOUNT=:ld_basic where EMP_ID = :ls_emp_id;
			if sqlca.sqlcode = -1 then				
				messagebox('SQL Error: During Update in Employee Master',sqlca.sqlerrtext)	
				rollback;
				return 1
			end if	
		end if
		
		if dw_1.getitemstring(ll_ctr,'del_ind') ='Y'  then
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

type dw_1 from datawindow within w_gtehrf033
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 116
integer width = 4050
integer height = 2052
string dataobject = "dw_gtehrf033"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then

	if dwo.name='emp_id' then
		ls_emp_id=data
		
		setnull(ls_emp_grade);setnull(ls_emp_type);setnull(ld_basic);
		
		select EMP_TYPE,emp_grade,EBS_BASICAMOUNT into :ls_emp_type,:ls_emp_grade,:ld_basic from fb_employee where emp_id=:ls_emp_id and EMP_ACTIVE='1' and EMP_TYPE not in ('LP','LT','LO');
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting Employee Data : '+sqlca.sqlerrtext)
			return 1
		elseif  sqlca.sqlcode = 100 then
			messagebox('Warring','Either Provided Employee is Not Staff or Sub-Staff or Active')
			return 1
		elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'emp_grade_old',ls_emp_grade)
			dw_1.setitem(row,'emp_type_old',ls_emp_type)
			dw_1.setitem(row,'ebs_basicamount_old',ld_basic)
			dw_1.setitem(row,'emp_grade_new',ls_emp_grade)
			dw_1.setitem(row,'emp_type_new',ls_emp_type)
			dw_1.setitem(row,'ebs_basicamount_new',ld_basic)
		end if
		
	end if
	
	if dwo.name ='appr_ind' then
		dw_1.setitem(row,'ep_approve_by',gs_user)
		dw_1.setitem(row,'ep_approve_dt',datetime(today()))
	end if
	
	if (dwo.name <> 'appr_ind') then
		dw_1.setitem(row,'ep_entry_by',gs_user)
		dw_1.setitem(row,'ep_entry_dt',datetime(today()))
	end if
	if dwo.name = 'ep_remarks' then
		dw_1.insertrow(0)
	end if
	cb_3.enabled = true
end if

end event

