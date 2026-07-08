$PBExportHeader$w_gtehrf032.srw
forward
global type w_gtehrf032 from window
end type
type cbx_1 from checkbox within w_gtehrf032
end type
type cb_2 from commandbutton within w_gtehrf032
end type
type cb_1 from commandbutton within w_gtehrf032
end type
type cb_4 from commandbutton within w_gtehrf032
end type
type cb_3 from commandbutton within w_gtehrf032
end type
type dw_1 from datawindow within w_gtehrf032
end type
end forward

global type w_gtehrf032 from window
integer width = 4645
integer height = 2280
boolean titlebar = true
string title = "(w_gtehrf005) Employee Attendance"
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
global w_gtehrf032 w_gtehrf032

type variables
long ll_ctr, ll_cnt,l_ctr,ll_user_level,ll_year,ll_retage
string ls_temp,ls_year,ls_month,ls_paycal,ls_emp_id,ls_old_status,ls_old_hajari,ls_appr_ind,ls_entry_by,ls_hazira,ls_status,ls_ind
boolean lb_neworder, lb_query
datetime ld_date
double ld_sick, ld_mat, ld_cl, ld_el,ld_stcl,ld_sscl,ld_sssk,ld_sickout
date ld_lastattndate,ld_rundt

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

on w_gtehrf032.create
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

on w_gtehrf032.destroy
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

type cbx_1 from checkbox within w_gtehrf032
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

type cb_2 from commandbutton within w_gtehrf032
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
	dw_1.Retrieve(ls_appr_ind)
	
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf032
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

type cb_4 from commandbutton within w_gtehrf032
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

type cb_3 from commandbutton within w_gtehrf032
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
		IF (isnull(dw_1.getitemstring(ll_ctr,'eattenl_new_status')) or len(dw_1.getitemstring(ll_ctr,'eattenl_new_status')) = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
		
		
		if isnull(dw_1.getitemstring(ll_ctr,'eattenl_reason')) then
			messagebox('Warning','Reason Is Mandatory')
			return 
		end if	
		
		if dw_1.getitemstring(ll_ctr,'appr_ind') ='Y'  then
			setnull(ls_emp_id);setnull(ld_date);setnull(ls_hazira);setnull(ls_status);
			ls_emp_id=dw_1.getitemstring(ll_ctr,'emp_id')
			ld_date=dw_1.getitemdatetime(ll_ctr,'eattenl_date')
			ls_hazira=dw_1.getitemstring(ll_ctr,'eattenl_new_hajari')
			ls_status=dw_1.getitemstring(ll_ctr,'eattenl_new_status')
			
			
			update FB_EMPATTENDANCE set EATTEN_STATUS = :ls_status, EATTEN_HAJARI = :ls_hazira where EMP_ID = :ls_emp_id and trunc(EATTEN_DATE)=trunc(:ld_date);
			if sqlca.sqlcode = -1 then				
				messagebox('SQL Error: During Update in Emp attendance',sqlca.sqlerrtext)	
				rollback;
				return 1
			end if
		
		
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

type dw_1 from datawindow within w_gtehrf032
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
string dataobject = "dw_gtehrf032"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then

	
	if dwo.name='eattenl_date' then
		ld_date = datetime(data)
		
		select to_char(:ld_date,'YYYY'),to_char(:ld_date,'MM') into :ls_year,:ls_month  from dual;
		
		setnull(ls_paycal)
		select EPS_PAYCALFLAG into :ls_paycal from fb_emppaymentstatus where EPS_YEAR || lpad(EPS_MONTH,2,0) =:ls_year || :ls_month;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Checking Payment Indicator Current Month : '+sqlca.sqlerrtext)
			return 1
		end if
		
		if ls_paycal ='1' then
			messagebox('Warning','Payment Already Done For This Year Month'+ ls_year + ls_month)
			return 1
		end if	
		
		
		select distinct 'X' into :ls_temp from FB_EMPATTENDANCE where  trunc(EATTEN_DATE)=trunc(:ld_date);
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Checking Attendance date : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warining','No data Found On selected date')
			return 1
		end if
	else
		ld_date = dw_1.getitemdatetime(row,'eattenl_date')
	end if
	
	if dwo.name ='emp_id' then
		ls_emp_id=data
		
		
		select EATTEN_STATUS, EATTEN_HAJARI into :ls_old_status,:ls_old_hajari from FB_EMPATTENDANCE where EMP_ID = :ls_emp_id and trunc(EATTEN_DATE)=trunc(:ld_date);
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Checking Employee Attn : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then 
			messagebox('Warning','No record Found')
			return 1
		elseif sqlca.sqlcode = 0 then 
			dw_1.setitem(row,'eattenl_old_status',ls_old_status)
			dw_1.setitem(row,'eattenl_old_hajari',ls_old_hajari)
		end if
	end if
	
	
	if dwo.name='appr_ind' then
		ls_appr_ind=data
		
		
		ls_entry_by=dw_1.getitemstring(row,'eattenl_entry_by')
		
		if upper(trim(ls_entry_by))=upper(trim(gs_user)) then
			messagebox('Warning .. !','Entry By And approve BY cannot be same.')
			return 1;
		end if
		setnull(ld_rundt)
		if(ls_appr_ind='Y') then
			dw_1.setitem(row,'eattenl_approve_by',gs_user)
			dw_1.setitem(row,'eattenl_approve_dt',today())
		else
			dw_1.setitem(row,'eattenl_approve_by','')
			dw_1.setitem(row,'eattenl_approve_dt',ld_rundt)
		end if
	
	end if
	
	if dwo.name = 'del_ind' then
		
		ls_ind =data
		
		if ls_ind ='Y' then
			if	MessageBox("Save  Alert", 'Do You Want To Reject ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
				dw_1.deleterow(row)
			else
				
			end if
		end if
		
	end if
	
	
	if (dwo.name <> 'appr_ind') then
		dw_1.setitem(row,'eattenl_entry_by',gs_user)
		dw_1.setitem(row,'eattenl_entry_dt',datetime(today()))
	end if
	if dwo.name = 'eattenl_reason' then
		dw_1.insertrow(0)
	end if
	cb_3.enabled = true
end if

end event

