$PBExportHeader$w_gtelaf002.srw
forward
global type w_gtelaf002 from window
end type
type cb_5 from commandbutton within w_gtelaf002
end type
type rb_3 from radiobutton within w_gtelaf002
end type
type rb_2 from radiobutton within w_gtelaf002
end type
type rb_1 from radiobutton within w_gtelaf002
end type
type cb_10 from commandbutton within w_gtelaf002
end type
type cb_8 from commandbutton within w_gtelaf002
end type
type cb_7 from commandbutton within w_gtelaf002
end type
type cb_9 from commandbutton within w_gtelaf002
end type
type cb_4 from commandbutton within w_gtelaf002
end type
type cb_3 from commandbutton within w_gtelaf002
end type
type cb_2 from commandbutton within w_gtelaf002
end type
type cb_1 from commandbutton within w_gtelaf002
end type
type labour_details from tab within w_gtelaf002
end type
type tabpage_1 from userobject within labour_details
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within labour_details
dw_1 dw_1
end type
type tabpage_2 from userobject within labour_details
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within labour_details
dw_2 dw_2
end type
type tabpage_3 from userobject within labour_details
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within labour_details
dw_3 dw_3
end type
type labour_details from tab within w_gtelaf002
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type gb_1 from groupbox within w_gtelaf002
end type
end forward

global type w_gtelaf002 from window
integer width = 4425
integer height = 2448
boolean titlebar = true
string title = "(w_gtelaf002) Permanent/Temporary/Outside Labours"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_5 cb_5
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_10 cb_10
cb_8 cb_8
cb_7 cb_7
cb_9 cb_9
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
labour_details labour_details
gb_1 gb_1
end type
global w_gtelaf002 w_gtelaf002

type variables
long ll_ctr, ll_cnt,ll_year,ll_user_level,ll_count,ll_pfno,ll_paybook,ll_retage,ll_agediff
string ls_temp,ls_del_ind,ls_mac_id,ls_tmp_id, ls_name,ls_fname, ls_nname, ls_add, ls_phone, ls_fax, ls_mobile, ls_email, ls_count, ls_last,ls_rowid
string ls_contactp,ls_contacno,ls_cst,ls_lst,ls_field, ls_ele,ls_house,lab,ls_empno,ls_ref,ls_autopf, ls_line
string ls_labour_id,ls_child_name,ls_child_gender,ls_dob, ls_sex,ls_pfno
string ls_sp_id,ls_spouse_name,ls_emp
boolean lb_neworder, lb_query
datetime ld_dob, ld_doj, ld_dt, ld_dol,ld_dobpre,ld_labdob,ld_childdob, ld_tempdt
datawindowchild idw_paybook,idw_sptype,idw_labournm
string ls_retirment_ind,ls_idproof_ind

date ld_date
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_lab_nm, string fl_lab_add)
public function integer wf_check_fillcol3 (integer fl_row)
public function integer wf_check_fillcol2 (integer fl_row)
public function integer wf_check_duplicate_rec_id (string fs_spid)
public function integer wf_check_duplicate_emp (string fs_emp)
public function integer wf_check_duplicate_rec2 (string fs_spid, string fs_sp_nm, datetime fd_dob)
end prototypes

event ue_option();//choose case gs_ueoption
//	case "PRINT"
//			OpenWithParm(w_print,this.dw_1)
//	case "PRINTPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = yes")
//	case "RESETPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = no")
//	case "SAVEAS"
//			this.dw_1.saveas()
//	case "FILTER"
//			setnull(gs_filtertext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setfilter(gs_filtertext)
//			this.dw_1.filter()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	case "SORT"
//			setnull(gs_sorttext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setsort(gs_sorttext)
//			this.dw_1.sort()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//end choose
//
//
end event

public function integer wf_check_fillcol (integer fl_row);long ls_paybookno
ls_paybookno=0
if labour_details.tabpage_1.dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_name')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_name'))=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemdatetime(fl_row,'emp_dob')) or string(labour_details.tabpage_1.dw_1.getitemdatetime(fl_row,'emp_dob')) = '00/00/0000' or &
		 isnull(labour_details.tabpage_1.dw_1.getitemdatetime(fl_row,'emp_jdate')) or &
		 isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_sex')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_sex'))=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_marital')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_marital'))=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_inactivetype')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_inactivetype'))=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'field_id')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'field_id'))=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemnumber(fl_row,'ls_id')) or  labour_details.tabpage_1.dw_1.getitemnumber(fl_row,'ls_id')=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_pfno')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_pfno'))=0 or &
		 isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_add')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_add'))=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Labour Name, Date Of Birth, Gender, Marital Status, Status, Division, Pay Book,  Address, PF NO., Please Check !!!')
		 return -1
	end if
	if  (labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_house') = '1' and (isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'rh_id')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'rh_id'))= 0)) or &
		     (labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_elect') = '1' and (isnull(labour_details.tabpage_1.dw_1.getitemnumber(fl_row,'edg_id')) or  labour_details.tabpage_1.dw_1.getitemnumber(fl_row,'edg_id')= 0)) then
		messagebox('Warning: ','If Electricity/ Labour line Check Box Is Checked The Detail Must Be Entered, Address, Please Check !!!')
		 return -1
	end if
	if  (labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_inactivetype') <> 'Regular' and (isnull(labour_details.tabpage_1.dw_1.getitemdatetime(fl_row,'emp_jobleavingdate')) or  &
		isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_jobleavingreason')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_jobleavingreason'))= 0) ) then
		messagebox('Missing Leaving Date/Remark ','If Case Of Status Other Than Regular, the Leaving Date/Remark Must Be Entered. Please Check !!!')
		 return -1
	end if
	if  (labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_active') = '0' and labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_inactivetype') = 'Regular' ) then
		messagebox('Warning','If user is inactive, his status should not be Regular. Please Check !!!')
		 return -1
	end if
	if  (labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_active') = '1' and labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_inactivetype') <> 'Regular' ) then
		messagebox('Warning','If user is active, his status should be Regular. Please Check !!!')
	 	return -1
	end if
	
	
	ls_paybookno =labour_details.tabpage_1.dw_1.getitemnumber(fl_row,'ls_id')
	

//	select nvl(ls_retirment_ind,'N') ,nvl(ls_idproof_ind,'N') into :ls_retirment_ind,:ls_idproof_ind from fb_laboursheet where LS_ID= :ls_paybookno;
//	if sqlca.sqlcode = -1 then
//		messagebox('Error : While Getting Paybook No.',sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1	
//	end if
	
//	if(ls_idproof_ind='N') then 	
		if  (isnull(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_aadhar_no')) or  len(labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_aadhar_no'))=0 ) then
			messagebox('Warning','Adhar Card No is Missing. Please Check !!!')
			return -1
		end if
	//end if
	
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fl_lab_nm, string fl_lab_add);long fl_row
string ls_emp_nm1, ls_emp_add1

labour_details.tabpage_1.dw_1.SelectRow(0, FALSE)
if labour_details.tabpage_1.dw_1.rowcount() > 1 then
	for fl_row = 1 to (labour_details.tabpage_1.dw_1.rowcount() - 1)
		ls_emp_nm1 = labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_name')
		ls_emp_add1 = labour_details.tabpage_1.dw_1.getitemstring(fl_row,'emp_add')
		
		if ls_emp_nm1 = fl_lab_nm and ls_emp_add1 = fl_lab_add then
			labour_details.tabpage_1.dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol3 (integer fl_row);if labour_details.tabpage_3.dw_3.rowcount() > 0 and fl_row > 0 then
	 if (isnull(labour_details.tabpage_3.dw_3.getitemstring(fl_row,'child_name')) or  len(labour_details.tabpage_3.dw_3.getitemstring(fl_row,'child_name'))=0 or &
	    isnull(labour_details.tabpage_3.dw_3.getitemdatetime(fl_row,'child_dob')) ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Child Name, Child DOB, Please Check !!!')
	    return -1
	end if
end if
return 1

end function

public function integer wf_check_fillcol2 (integer fl_row);if labour_details.tabpage_2.dw_2.rowcount() > 0 and fl_row > 0 then
	 if (isnull(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_type')) or  len(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_type'))= 0) then
		messagebox('Warning: One Of The Following Fields Is Blank','Spouse Type , Please Check !!!')
	     return -1
	 elseif (labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_type') <> 'NONE' and &
			 isnull(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_id')) or  len(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_id'))=0 or &
			 isnull(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_name')) or  len(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_name'))=0 or &
			 isnull(labour_details.tabpage_2.dw_2.getitemdatetime(fl_row,'spouse_dob')) ) then
			 messagebox('Warning: One Of The Following Fields Are Blank','Spouse Type, Spouse Id, Spouse Name, Spouse DOB, Please Check !!!')
	    return -1
	 elseif (labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_type') = 'NONE' and &
			 isnull(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_name')) or  len(labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_name'))=0 or &
			 isnull(labour_details.tabpage_2.dw_2.getitemdatetime(fl_row,'spouse_dob')) ) then
			 messagebox('Warning: One Of The Following Fields Are Blank','Spouse Type, Spouse Name, Spouse DOB, Please Check !!!')
	    return -1
	 end if
end if
return 1
end function

public function integer wf_check_duplicate_rec_id (string fs_spid);long fl_row
string ls_dpid1, ls_emp1


labour_details.tabpage_2.dw_2.SelectRow(0, FALSE)
if labour_details.tabpage_2.dw_2.rowcount() > 1 then
	for fl_row = 1 to (labour_details.tabpage_2.dw_2.rowcount() - 1)
		ls_dpid1 = labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_id')
		ls_emp1 = labour_details.tabpage_2.dw_2.getitemstring(fl_row,'labour_id')
		
		if ls_dpid1 = fs_spid or ls_emp1 = fs_spid then
			labour_details.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Spouse ID Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_duplicate_emp (string fs_emp);long fl_row
string ls_emp1, ls_spid1

labour_details.tabpage_2.dw_2.SelectRow(0, FALSE)
if labour_details.tabpage_2.dw_2.rowcount() > 1 then
	for fl_row = 1 to (labour_details.tabpage_2.dw_2.rowcount() - 1)
		ls_emp1 = labour_details.tabpage_2.dw_2.getitemstring(fl_row,'labour_id')
		ls_spid1 = labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_id')
		
		if ls_emp1 = fs_emp or ls_spid1 = fs_emp then
			labour_details.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Labour Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 
return 1
end function

public function integer wf_check_duplicate_rec2 (string fs_spid, string fs_sp_nm, datetime fd_dob);long fl_row
string ls_sp_nm,ls_dpid1
datetime ld_dob1

labour_details.tabpage_2.dw_2.SelectRow(0, FALSE)
if labour_details.tabpage_2.dw_2.rowcount() > 1 then
	for fl_row = 1 to (labour_details.tabpage_2.dw_2.rowcount() - 1)
		ls_sp_nm = labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_name')
		ld_dob1 = labour_details.tabpage_2.dw_2.getitemdatetime(fl_row,'spouse_dob')
		ls_dpid1 = labour_details.tabpage_2.dw_2.getitemstring(fl_row,'spouse_id')
		if isnull(ls_dpid1) then ls_dpid1 = 'x'
		if isnull(fs_spid) then fs_spid = 'x'
		
		if ls_dpid1 = fs_spid and ls_sp_nm = fs_sp_nm and ld_dob1 = fd_dob then
			labour_details.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf002.create
this.cb_5=create cb_5
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_10=create cb_10
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.labour_details=create labour_details
this.gb_1=create gb_1
this.Control[]={this.cb_5,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_10,&
this.cb_8,&
this.cb_7,&
this.cb_9,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.labour_details,&
this.gb_1}
end on

on w_gtelaf002.destroy
destroy(this.cb_5)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_10)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.labour_details)
destroy(this.gb_1)
end on

event open;if f_openwindow(labour_details.tabpage_1.dw_1) = -1 then	
	close(this)
	return 1
end if


labour_details.tabpage_1.dw_1.settransobject(sqlca)
labour_details.tabpage_2.dw_2.settransobject(sqlca)
labour_details.tabpage_3.dw_3.settransobject(sqlca)

lb_query = false	
lb_neworder = false
labour_details.tabpage_1.dw_1.modify("t_co.text = '"+gs_co_name+"'")

labour_details.tabpage_1.dw_1.GetChild ("ls_id", idw_paybook)
idw_paybook.settransobject(sqlca)

labour_details.tabpage_1.dw_1.GetChild ("emp_name", idw_labournm)
idw_labournm.settransobject(sqlca)


labour_details.tabpage_2.dw_2.GetChild ("spouse_id", idw_sptype)
idw_sptype.settransobject(sqlca)	


this.tag = Message.StringParm
ll_user_level = long(this.tag)

//if (gs_garden_snm = 'AD' or gs_garden_snm = 'DR' or gs_garden_snm = 'MH' or gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'LP' or gs_garden_snm = 'MR') then
//	cb_1.enabled = false
//end if 
if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' and GS_USER <> 'PIYUSH' then
	cb_1.enabled = false
else
	cb_1.enabled = true
end if 

end event

event key;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

type cb_5 from commandbutton within w_gtelaf002
boolean visible = false
integer x = 2523
integer y = 28
integer width = 782
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Promote To Staff && Sub Staff"
end type

event clicked;gl_temp = ll_user_level
opensheetwithparm(w_gtelaf002a,this.tag,w_mdi,0,layered!)

end event

type rb_3 from radiobutton within w_gtelaf002
integer x = 1024
integer y = 44
integer width = 407
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LO - Outsider"
end type

event clicked;cb_1.enabled = true
end event

type rb_2 from radiobutton within w_gtelaf002
integer x = 544
integer y = 44
integer width = 480
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LT - Temporary"
end type

event clicked;cb_1.enabled = true

end event

type rb_1 from radiobutton within w_gtelaf002
integer x = 59
integer y = 44
integer width = 475
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LP - Permanent"
boolean checked = true
end type

event clicked;//if (gs_garden_snm = 'AD' or gs_garden_snm = 'DR' or gs_garden_snm = 'MH' or gs_garden_snm = 'AB' or gs_garden_snm = 'SP' or gs_garden_snm = 'LP' or gs_garden_snm = 'MR') then
//	cb_1.enabled = false
//end if 

if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' then
	cb_1.enabled = false
else
	cb_1.enabled = true
end if 
end event

type cb_10 from commandbutton within w_gtelaf002
integer x = 3461
integer y = 152
integer width = 142
integer height = 80
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;if labour_details.tabpage_1.dw_1.rowcount() > 0 then
	//dw_1.setcolumn('ind1')
	labour_details.tabpage_1.dw_1.ScrolltoRow(1)
	labour_details.tabpage_2.dw_2.ScrolltoRow(1)
	labour_details.tabpage_3.dw_3.ScrolltoRow(1)
end if
end event

type cb_8 from commandbutton within w_gtelaf002
integer x = 3598
integer y = 152
integer width = 142
integer height = 80
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if labour_details.tabpage_1.dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	labour_details.tabpage_1.dw_1.ScrollPriorRow()
	labour_details.tabpage_2.dw_2.ScrollPriorRow()
	labour_details.tabpage_3.dw_3.ScrollPriorRow()
end if
end event

type cb_7 from commandbutton within w_gtelaf002
integer x = 3735
integer y = 152
integer width = 142
integer height = 80
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;if labour_details.tabpage_1.dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	labour_details.tabpage_1.dw_1.ScrollnextRow()
	labour_details.tabpage_2.dw_2.ScrollnextRow()
	labour_details.tabpage_3.dw_3.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gtelaf002
integer x = 3872
integer y = 152
integer width = 142
integer height = 80
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;if labour_details.tabpage_1.dw_1.rowcount() > 0 then
//	dw_1.setcolumn('ind1')
	labour_details.tabpage_1.dw_1.ScrolltoRow(labour_details.tabpage_1.dw_1.rowcount())
	labour_details.tabpage_2.dw_2.ScrolltoRow(labour_details.tabpage_2.dw_2.rowcount())
	labour_details.tabpage_3.dw_3.ScrolltoRow(labour_details.tabpage_3.dw_3.rowcount())
end if
end event

type cb_4 from commandbutton within w_gtelaf002
integer x = 2258
integer y = 28
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

event clicked;if labour_details.tabpage_1.dw_1.modifiedcount() > 0 or labour_details.tabpage_1.dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtelaf002
integer x = 1989
integer y = 28
integer width = 270
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

event clicked;if labour_details.tabpage_1.dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if labour_details.tabpage_1.dw_1.rowcount() > 0 then
	IF (isnull(labour_details.tabpage_1.dw_1.getitemstring(labour_details.tabpage_1.dw_1.rowcount(),'emp_name')) or len(labour_details.tabpage_1.dw_1.getitemstring(labour_details.tabpage_1.dw_1.rowcount(),'emp_name'))=0) THEN
		 labour_details.tabpage_1.dw_1.deleterow(labour_details.tabpage_1.dw_1.rowcount())
	END IF
end if

if labour_details.tabpage_3.dw_3.rowcount() > 0 then
	IF (isnull(labour_details.tabpage_3.dw_3.getitemstring(labour_details.tabpage_3.dw_3.rowcount(),'child_name')) or len(labour_details.tabpage_3.dw_3.getitemstring(labour_details.tabpage_3.dw_3.rowcount(),'child_name'))=0) THEN
		 labour_details.tabpage_3.dw_3.deleterow(labour_details.tabpage_3.dw_3.rowcount())
	END IF
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

if labour_details.tabpage_1.dw_1.rowcount() > 0 then
	 IF wf_check_fillcol(labour_details.tabpage_1.dw_1.getrow()) = -1 THEN
			return 1
	end if
//	if labour_details.tabpage_1.dw_1.getitemstring(labour_details.tabpage_1.dw_1.getrow(),'emp_marital') = 'M' then
//		if lb_neworder = true then
//			IF wf_check_fillcol2(labour_details.tabpage_2.dw_2.getrow()) = -1 THEN
//					return 1
//			end if
//			if labour_details.tabpage_3.dw_3.rowcount() = 0 or (labour_details.tabpage_3.dw_3.rowcount() = 1 and isnull(labour_details.tabpage_3.dw_3.getitemstring(labour_details.tabpage_3.dw_3.getrow(),'child_name'))) then
//				if messagebox('Warning!','You Have Not Entered The Census Details, Want To Enter ...?',Exclamation!, YesNo!, 1) = 1 THEN
//					return 1
//				end if
//			else
//				IF wf_check_fillcol3(labour_details.tabpage_3.dw_3.getrow()) = -1 THEN
//						return 1
//				end if
//			end if
//		end if
//	else
//		if labour_details.tabpage_2.dw_2.rowcount() > 0 then
//			IF (isnull(labour_details.tabpage_2.dw_2.getitemstring(labour_details.tabpage_2.dw_2.rowcount(),'spouse_type')) or len(labour_details.tabpage_2.dw_2.getitemstring(labour_details.tabpage_2.dw_2.rowcount(),'spouse_type'))=0) THEN
//				 labour_details.tabpage_2.dw_2.deleterow(labour_details.tabpage_2.dw_2.rowcount())
//			END IF
//		END IF
//		if labour_details.tabpage_3.dw_3.rowcount() > 0 then
//			IF (isnull(labour_details.tabpage_3.dw_3.getitemstring(labour_details.tabpage_3.dw_3.rowcount(),'child_name')) or len(labour_details.tabpage_3.dw_3.getitemstring(labour_details.tabpage_3.dw_3.rowcount(),'child_name'))=0) THEN
//				 labour_details.tabpage_3.dw_3.deleterow(labour_details.tabpage_3.dw_3.rowcount())
//			END IF	
//		end if
//	end if
end if

	if labour_details.tabpage_1.dw_1.rowcount() > 0 then
		for ll_ctr = 1 to labour_details.tabpage_1.dw_1.rowcount( ) 
			if labour_details.tabpage_1.dw_1.getitemstatus(ll_ctr,0,primary!) = New! or labour_details.tabpage_1.dw_1.getitemstatus(ll_ctr,0,primary!) = Newmodified! then
				
				ls_name = labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_name')
				ls_add = labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_add')
				ll_paybook = labour_details.tabpage_1.dw_1.getitemnumber(ll_ctr,'ls_id')
				lab = left(ls_name,1)

//Auto PF Generation Removed as per Mr. Lahari on 25/05/2012 At Ub
//				select nvl(ls_autogenpfind,'N') into :ls_autopf from fb_laboursheet where LS_ID = :ll_paybook;
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Getting Paybook Details',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				elseif sqlca.sqlcode  = 0 then
//					select max(to_number(emp_pfno)) into :ll_pfno from fb_employee;
//					if sqlca.sqlcode = -1 then
//						messagebox('Error : While Getting Maximum PF No.',sqlca.sqlerrtext)
//						rollback using sqlca;
//						return 1
//					end if
//					if (isnull(labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_pfno')) or len(labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_pfno')) = 0) and ls_autopf = 'Y' then
//						labour_details.tabpage_1.dw_1.setitem(ll_ctr,'emp_pfno',string(ll_pfno + 1))
//					end if
//				end if
				
				select distinct 'x' into :ls_temp from fb_employee where upper(emp_name) = upper(:ls_name) and upper(emp_add) = upper(:ls_add);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox('Warning!','Labour Already Exists, Please Check !!!')
					return 1
				end if
				if labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_type') = 'LO' then
					ll_cnt =0; setnull(ls_tmp_id) 
					select nvl(max(emp_id),'x') into :ls_tmp_id from fb_employee where EMP_ID  like 'X%';
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Labour ID Generate',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode = 0 and ls_tmp_id <> 'x' then
						ll_cnt = long(mid(ls_tmp_id,2,len(ls_tmp_id)))
					elseif sqlca.sqlcode = 100 or ls_tmp_id = 'x' then
						select count(1) into :ll_cnt from fb_employee where emp_type='LO';
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Labour ID Generate',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					end if
					ll_cnt = ll_cnt + 1
					ls_empno = 'X'+string(ll_cnt,'000000')
				else
					if gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'SP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR'  then
						select fbfn_employee('L',:lab) into :ls_empno from dual;
					else
						if labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_type') = 'LP' then
							select max(emp_id) into :ls_empno from fb_employee where emp_id like 'P%';
							ls_empno = 'P'+string(long(right(ls_empno,5)) + 1,'00000')
						elseif labour_details.tabpage_1.dw_1.getitemstring(ll_ctr,'emp_type') = 'LT' then
							select max(emp_id) into :ls_empno from fb_employee where emp_id like 'T%';
							ls_empno = 'T'+string(long(right(ls_empno,5)) + 1,'00000')
						end if
					end if
				end if
				labour_details.tabpage_1.dw_1.setitem(ll_ctr,'emp_id',ls_empno)
				if labour_details.tabpage_2.dw_2.rowcount() > 0 and isnull(labour_details.tabpage_2.dw_2.getitemstring(ll_ctr,'spouse_type'))=false then
					labour_details.tabpage_2.dw_2.setitem(labour_details.tabpage_2.dw_2.getrow(),'labour_id',ls_empno)
				end if
				if labour_details.tabpage_3.dw_3.rowcount() > 0 then
					for ll_count = 1 to labour_details.tabpage_3.dw_3.rowcount()
						labour_details.tabpage_3.dw_3.setitem(ll_count,'labour_id',ls_empno)
					next
				end if
			end if
		next	
	end if

	if labour_details.tabpage_1.dw_1.update(true,false) = 1 then 
		labour_details.tabpage_1.dw_1.resetupdate();
		if labour_details.tabpage_2.dw_2.rowcount() > 0  then 
			if labour_details.tabpage_2.dw_2.update(true,false) = 1 then
				labour_details.tabpage_2.dw_2.resetupdate()
			end if
		end if
		if labour_details.tabpage_3.dw_3.rowcount() > 0 then 
			if labour_details.tabpage_3.dw_3.update(true,false) = 1 then
				labour_details.tabpage_3.dw_3.resetupdate()
			end if
		end if
		
		if lb_neworder = true then
			Messagebox('Information!','Labour ID Generated Is ('+ls_empno+')')
		end if
		
		commit using sqlca;
		cb_3.enabled = false
		labour_details.tabpage_1.dw_1.reset()
		labour_details.tabpage_2.dw_2.reset()
		labour_details.tabpage_3.dw_3.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtelaf002
integer x = 1728
integer y = 28
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

event clicked;rb_1.enabled = true
rb_2.enabled = true
rb_3.enabled = true

if rb_1.checked then
	gs_emp_type = 'LP'	
elseif rb_2.checked then
	gs_emp_type = 'LT'
elseif rb_3.checked then
	gs_emp_type = 'LO'
end if

if gs_emp_type = 'LP' then
	labour_details.tabpage_1.dw_1.modify("h1.text = 'Permanent Labours'")
elseif gs_emp_type = 'LT' then
	labour_details.tabpage_1.dw_1.modify("h1.text = 'Temporary Labours'")
elseif gs_emp_type = 'LO' then
	labour_details.tabpage_1.dw_1.modify("h1.text = 'Outside Labours'")	
end if

idw_labournm.SetFilter ("EMP_TYPE = '"+trim(gs_emp_type)+"'")
idw_labournm.filter( )

if cb_2.text = "&Query" then
	lb_neworder = true
	if labour_details.tabpage_1.dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	labour_details.tabpage_1.dw_1.reset()
	labour_details.tabpage_1.dw_1.settaborder('emp_id',5)
	labour_details.tabpage_1.dw_1.settaborder('emp_name',10)
	lb_query = true
	labour_details.tabpage_1.dw_1.modify("datawindow.queryclear= yes")
	labour_details.tabpage_1.dw_1.Object.datawindow.querymode= 'yes'
	labour_details.tabpage_1.dw_1.SetFocus ()
	labour_details.tabpage_1.dw_1.setcolumn('emp_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	labour_details.tabpage_1.dw_1.settransobject(sqlca)
	labour_details.tabpage_1.dw_1.SetRedraw (FALSE)
	labour_details.tabpage_1.dw_1.settaborder('emp_id',0)
	if (gs_emp_type = 'LT' or gs_emp_type = 'LO') then
		if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' then
			labour_details.tabpage_1.dw_1.settaborder('emp_type',0)
			//labour_details.tabpage_1.dw_1.settaborder('emp_name',0)
		else
			labour_details.tabpage_1.dw_1.settaborder('emp_type',125)
			//labour_details.tabpage_1.dw_1.settaborder('emp_name',10)
		end if 
	else
		labour_details.tabpage_1.dw_1.settaborder('emp_type',0)
		if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' then
			labour_details.tabpage_1.dw_1.settaborder('emp_name',0)
		end if
	end if
	labour_details.tabpage_1.dw_1.Object.datawindow.querymode = 'no'
	labour_details.tabpage_1.dw_1.Retrieve(gs_garden_snm,gs_emp_type,GS_USER)
	labour_details.tabpage_1.dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' then
		if gs_emp_type = 'LT' or gs_emp_type = 'LO' then
			cb_1.enabled = true
		else 
			cb_1.enabled = false
		end if
	else
		cb_1.enabled = true
	end if 
end if

end event

type cb_1 from commandbutton within w_gtelaf002
integer x = 1463
integer y = 28
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

event clicked;if (rb_2.checked = true or rb_3.checked = true) and ll_user_level <> 1 then
	messagebox('Warning!','You Are Not Authorised To Add New Records Of Temporary & Outsider, Please Contact Admin User !!!')
	return 1
end if

if lb_neworder = false then
	if labour_details.tabpage_1.dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	labour_details.tabpage_1.dw_1.reset()
	labour_details.tabpage_2.dw_2.reset()
	labour_details.tabpage_3.dw_3.reset()
end if

labour_details.tabpage_1.dw_1.settransobject(sqlca)

rb_1.enabled = false
rb_2.enabled = false
rb_3.enabled = false


if rb_1.checked then
	gs_emp_type = 'LP'
	if gs_emp_type = 'LP' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Permanent Labours'")
	elseif gs_emp_type = 'LT' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Temporary Labours'")
	elseif gs_emp_type = 'LO' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Outside Labours'")	
	end if
elseif rb_2.checked then
	gs_emp_type = 'LT'
	if gs_emp_type = 'LP' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Permanent Labours'")
	elseif gs_emp_type = 'LT' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Temporary Labours'")
	elseif gs_emp_type = 'LO' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Outside Labours'")	
	end if	
elseif rb_3.checked then
	gs_emp_type = 'LO'
	if gs_emp_type = 'LP' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Permanent Labours'")
	elseif gs_emp_type = 'LT' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Temporary Labours'")
	elseif gs_emp_type = 'LO' then
		labour_details.tabpage_1.dw_1.modify("h1.text = 'Outside Labours'")	
	end if	
end if


lb_neworder = true
lb_query = false


if labour_details.tabpage_1.dw_1.rowcount() = 0 then
	labour_details.tabpage_1.dw_1.scrolltorow(labour_details.tabpage_1.dw_1.insertrow(0))
	labour_details.tabpage_1.dw_1.setfocus()
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'gs_gsnm',gs_garden_snm)
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'emp_type',gs_emp_type)
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'emp_entry_by',gs_user)
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'emp_entry_dt',datetime(today()))
	labour_details.tabpage_1.dw_1.setcolumn('emp_name')
else
	IF wf_check_fillcol(labour_details.tabpage_1.dw_1.getrow()) = -1 THEN
		return 1
	END IF
	labour_details.tabpage_1.dw_1.scrolltorow(labour_details.tabpage_1.dw_1.insertrow(0))
	labour_details.tabpage_1.dw_1.setfocus()
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'gs_gsnm',gs_garden_snm)	
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'emp_type',gs_emp_type)
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'emp_entry_by',gs_user)
	labour_details.tabpage_1.dw_1.setitem(labour_details.tabpage_1.dw_1.getrow(),'emp_entry_dt',datetime(today()))
	labour_details.tabpage_1.dw_1.setcolumn('emp_name')
end if
labour_details.tabpage_1.dw_1.settaborder('emp_type',0)
labour_details.tabpage_1.dw_1.settaborder('emp_name',10)
end event

type labour_details from tab within w_gtelaf002
event create ( )
event destroy ( )
integer x = 27
integer y = 140
integer width = 4000
integer height = 2144
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on labour_details.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on labour_details.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within labour_details
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 3963
integer height = 2020
long backcolor = 67108864
string text = "Labour"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 20
integer width = 3648
integer height = 1952
integer taborder = 70
string dataobject = "dw_gtelaf002"
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
		dw_1.setitem(newrow,'emp_type',gs_emp_type)
		dw_1.setitem(newrow,'emp_entry_by',gs_user)
		dw_1.setitem(newrow,'emp_entry_dt',datetime(today()))
		dw_1.setcolumn('emp_name')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;integer ls_paybookno
if lb_query = false then
	
	if dwo.name = 'emp_name'  then
		ls_name = data
		if f_check_initial_space(ls_name) = -1 then return 1
		if f_check_alphanumeric(ls_name) = -1 then return 1
		if f_check_string_sp(ls_name) = -1 then return 1
		if rb_1.checked = true then
			if labour_details.tabpage_2.dw_2.rowcount( ) = 0 then
				labour_details.tabpage_2.dw_2.insertrow(0)
			end if
			
			if labour_details.tabpage_3.dw_3.rowcount( ) = 0 then
				labour_details.tabpage_3.dw_3.insertrow(0)
			end if
		end if
	end if
	
	if dwo.name = 'emp_pfno'  then
		ls_pfno = trim(data)
		select distinct 'x' into :ls_temp from fb_employee where trim(emp_pfno) = trim(upper(:ls_pfno));
		if sqlca.sqlcode = -1 then
			messagebox('Error : While checking PF No.',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','This PF No. already exists in system, Please Check !!!')
			return 1
		end if
	end if

	if dwo.name = 'emp_fathername'  then
		ls_fname = data		
		if f_check_initial_space(ls_fname) = -1 then return 1
		if f_check_alphanumeric(ls_fname) = -1 then return 1
		if f_check_string_sp(ls_fname) = -1 then return 1
	end if
    // rgb buttoneface (236,233,216)
	if dwo.name = 'emp_nomineename'  then
		ls_nname = data
		
		if f_check_initial_space(ls_nname) = -1 then return 1
		
		if f_check_alphanumeric(ls_nname) = -1 then return 1
		
		if f_check_string_sp(ls_nname) = -1 then return 1
		
		if isnull(ls_nname) or len(ls_nname) = 0 then
			setnull(ls_temp)
			dw_1.setitem(row,'emp_nomineerelation',ls_temp)
		end if	
	end if
	
	if dwo.name = 'ls_id'  then		
		select  LS_GENDER, FIELD_ID,ls_autogenpfind into :ls_sex,:ls_field, :ls_autopf from fb_laboursheet where LS_ID = :data;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Paybook Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			dw_1.setitem(row,'emp_sex',ls_sex)
			dw_1.setitem(row,'field_id',ls_field)
			if ls_autopf = 'Y' then
				dw_1.modify("emp_pfno.protect = '1'")
			else
				dw_1.modify("emp_pfno.protect = '0'")
			end if
		elseif sqlca.sqlcode  = 100 then
			setnull(ls_sex); setnull(ls_field)			
			dw_1.setitem(row,'emp_sex',ls_sex)
			dw_1.setitem(row,'field_id',ls_field)						
		end if
	end if
	
	if dwo.name = 'emp_inactivetype' then
		if data = 'Regular' then
			setnull(ls_temp);setnull(ld_dt);
			dw_1.setitem(row,'emp_jobleavingdate',ld_dt)
			dw_1.setitem(row,'emp_jobleavingreason',ls_temp)
			dw_1.setitem(row, 'emp_active', '1')
		elseif data <> 'Regular'then
			dw_1.setitem(row, 'emp_active', '0')
		end if
	end if
	
	if dwo.name = 'emp_add'  then
		ls_add = data
		ls_name = dw_1.getitemstring(row,'emp_name')
		
		if f_check_initial_space(ls_add) = -1 then return 1
		
	//	if f_check_string(ls_add) = -1 then return 1
	//
		if  wf_check_duplicate_rec(ls_name, ls_add) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_employee where upper(emp_name) = upper(:ls_name) and upper(emp_add) = upper(:ls_add);
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Labour Already Exists, Please Check !!!')
			return 1
		end if
		
	end if
	
	if dwo.name = 'emp_dob' then
		ld_dob = datetime(data)
		if f_check_initial_space(string(ld_dob)) = -1 then return 1
		
//		messagebox('ff',string(ld_dob))
////		messagebox('ff',string(today() - date(ld_dob)))
//		messagebox('dd',string(relativedate(today(),-1825)))
//		ll_year = relativedate(today(),-1825)

// PAY BOOK WISE RETIRMENT CHECK
	ls_paybookno =labour_details.tabpage_1.dw_1.getitemnumber(row,'ls_id')
	
	select nvl(ls_retirment_ind,'N') ,nvl(ls_idproof_ind,'N') into :ls_retirment_ind,:ls_idproof_ind from fb_laboursheet where LS_ID= :ls_paybookno;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Paybook No.',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1	
	end if
				
		select round((trunc(sysdate) - trunc(:ld_dob))/365) into :ll_year from dual; 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting No of Years',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		if isnull(ll_year) then ll_year = 0
		
		select nvl(PD_VALUE,0) into :ll_retage from fb_param_detail where PD_DOC_TYPE = 'RETIREMENT' and PD_PERIOD_TO is null;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Retirement Age',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if isnull(ll_retage) then ll_retage = 0
		 
		
		if ll_year >= ll_retage then
			if(ls_retirment_ind='N') then 
				messagebox('Warning!','Employee ('+ls_name+') Has Reached Retirement Age, Please Check !!!')
				return 1
			end if
//		end if		
//		if ll_year >= 60 then
//			messagebox('Warning!','Employee Has Already Reached Retirement Age, Please Check !!!')
//			return 1
		elseif 	ll_year <= 5 then
			messagebox('Warning!','Age Of Labour Should Be > 5 years, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'emp_jdate' then
		ld_doj = datetime(data)
		ld_dob = dw_1.getitemdatetime(row,'emp_dob')
		
		if date(ld_doj) > today() then
			messagebox('Warning!','Date Of Joining Should Not Be > Current Date, Please Check !!!')
			return 1
		end if
		
		if f_check_initial_space(string(ld_doj)) = -1 then return 1
		
		select round((trunc(:ld_doj) - trunc(:ld_dob))/365) into :ll_year from dual; 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting No of Years',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		if isnull(ll_year) then ll_year = 0
		
		if ll_year < 5 then
			messagebox('Warning!','Difference Between Date Of Joining And Date Of Birth Should Be >= 5, Please Check !!!')
			return 1
		end if

		if ll_year >= 60 then
			messagebox('Warning!','Employee Has Already Reached Retirement Age, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'emp_nomineerelation' then
		if dw_1.getitemstring(row,'emp_marital') = 'U' and (data = 'Spouse'  or data = 'Son' or data = 'Daughter') then
			messagebox('Warning!','For Unmarrier Nominee can Be Mother, Father and Other, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'house_id' then
		select LINE_NO into :ls_line from fb_house_master where house_id = :data;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Line No.',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'rh_id',ls_line)
		end if
	end if
	
	if dwo.name = 'emp_jobleavingdate' then
		ld_dol = datetime(data)
		ld_doj = dw_1.getitemdatetime(row,'emp_jdate')
		
		if date(ld_dol) > today() then
			messagebox('Warning!','Date Of Leaving Should Not Be > Current Date, Please Check !!!')
			return 1
		end if
		
		if f_check_initial_space(string(ld_dol)) = -1 then return 1
		
		if date(ld_dol) < date(ld_doj) then
			messagebox('Warning!','Date Of Leaving Should Not Be < Date Of Joining, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'field_id' then
		ls_field = data
		idw_paybook.SetFilter ("field_id = '"+trim(data)+"'") 
		idw_paybook.filter( )

		if f_check_initial_space(ls_field) = -1 then return 1
	end if
	
	if dwo.name = 'emp_elect' then
		ls_ele = data
		if ls_ele = '0' then
			dw_1.setitem(row,'edg_id',0)
		end if
	end if

	if dwo.name = 'emp_house' then
		ls_house = data
		if ls_house = '0' then
			setnull(ls_temp)
			dw_1.setitem(row,'rh_id',ls_temp)
		end if
	end if
	
	if dwo.name = 'edg_id' then
		if f_check_initial_space(data) = -1 then return 1
		if f_check_numeric(data) = -1 then return 1
	end if

	if dwo.name = 'rh_id' then
		if f_check_initial_space(data) = -1 then return 1
		if f_check_string_sp(data) = -1 then return 1
	end if
	
	if dwo.name = 'emp_covid_active' then
		if data = 'Y' then
			dw_1.setitem(row,'emp_covid_dt',today())
			dw_1.setitem(row,'emp_covid_entryby', gs_user)
		elseif data = 'N' then
			setnull(ld_tempdt); setnull(ls_temp);
			dw_1.setitem(row,'emp_covid_dt',ld_tempdt)
			dw_1.setitem(row,'emp_covid_entryby',ls_temp)
		end if
	end if
		
	dw_1.setitem(row,'emp_entry_by',gs_user)
	dw_1.setitem(row,'emp_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if


end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ls_ref = labour_details.tabpage_1.dw_1.getitemstring(labour_details.tabpage_1.dw_1.getrow(),'emp_id')
			labour_details.tabpage_2.dw_2.reset()
			labour_details.tabpage_2.dw_2.retrieve(ls_ref)
			labour_details.tabpage_3.dw_3.reset()
			labour_details.tabpage_3.dw_3.retrieve(ls_ref)
		end if
	end if
end if
end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_employee');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_employee',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

type tabpage_2 from userobject within labour_details
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 3963
integer height = 2020
long backcolor = 67108864
string text = "Spouse"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 20
integer width = 3630
integer height = 1556
integer taborder = 60
string dataobject = "dw_gtelaf019"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> labour_details.tabpage_2.dw_2.rowcount() then
		IF wf_check_fillcol2(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = labour_details.tabpage_2.dw_2.rowcount() and labour_details.tabpage_2.dw_2.rowcount() > 1  then
		labour_details.tabpage_2.dw_2.setitem(newrow,'spouse_entry_by',gs_user)
		labour_details.tabpage_2.dw_2.setitem(newrow,'spouse_entry_dt',datetime(today()))
		labour_details.tabpage_2.dw_2.setcolumn('labour_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if  lb_query = false then
	if dwo.name = 'labour_id'  then
		ls_labour_id = data	
		if isnull(ls_labour_id)=true or len(ls_labour_id) = 0 then
			messagebox('Warrnig:','Labour ID Should Not Be Blank, Please Check !!!')
			return 1
		end if;
		
		if wf_check_duplicate_emp(ls_labour_id) = -1 then return 1
		
		select distinct 'x'  into :ls_temp	from fb_labourspouse where (labour_id = :ls_labour_id or spouse_id = :ls_labour_id) and nvl(SPOUSE_ACTIVE,'0') = '1';
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting Employee spouse Detail  : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then 
			 messagebox('Warning!','Labour Detail Already Present, Please Check !!!')
			return 1
		end if;		
	end if;
	
	if dwo.name = 'spouse_type' then
		if data = 'LABOUR' then
			idw_sptype.SetFilter ("emp_type in ('LP','LT','LO')")
			idw_sptype.settransobject(sqlca)	
			idw_sptype.retrieve()
			setnull(ls_temp);setnull(ld_dt);
			//labour_details.tabpage_2.dw_2.settaborder('spouse_name',0)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_id',ls_temp)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_name',ls_temp)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_dob',ld_dt)
		elseif data = 'EMP' then
			idw_sptype.SetFilter ("emp_type not in ('LP','LT','LO')")
			idw_sptype.settransobject(sqlca)	
			idw_sptype.retrieve()	
			setnull(ls_temp);setnull(ld_dt);
			//labour_details.tabpage_2.dw_2.settaborder('spouse_name',0)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_id',ls_temp)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_name',ls_temp)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_dob',ld_dt)			
		else
			setnull(ls_temp);setnull(ld_dt);
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_id',ls_temp)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_name',ls_temp)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_dob',ld_dt)
			//labour_details.tabpage_2.dw_2.settaborder('spouse_name',10)
		end if
	end if
	
	if dwo.name = 'spouse_id' then
		ls_sp_id = data
		ls_labour_id = labour_details.tabpage_2.dw_2.getitemstring(row,'labour_id')
		
		if ls_sp_id = ls_labour_id then
			messagebox('Warning!','Labour Id and Spouse ID Should Not Be Same, Please Check !!!')
			return 1
		end if
		
		if wf_check_duplicate_rec_id(ls_sp_id) = -1 then return 1
		
		select distinct 'x'  into :ls_temp	from fb_labourspouse where (labour_id = :ls_labour_id or  nvl(spouse_id,'x') = nvl(:ls_sp_id,'x')) and nvl(SPOUSE_ACTIVE,'0') = '1';
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting Employee spouse Detail  : '+sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then 
			 messagebox('Warning!','Spouse Detail Already Present, Please Check !!!')
		end if;	
		
		select distinct emp_name, emp_dob  into :ls_spouse_name,:ld_dt from fb_employee	where emp_id=:ls_sp_id;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting Labour spouse Detail  : '+sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_name',ls_spouse_name)
			labour_details.tabpage_2.dw_2.setitem(row,'spouse_dob',ld_dt)
		elseif sqlca.sqlcode = 100 then 
			messagebox('Warning!','Invalid Spouse ID, Please Check !!!')
			return 1
		end if;	
	end if
	
	if dwo.name = 'spouse_dob'  then
		ls_dob= data
		ls_labour_id = labour_details.tabpage_2.dw_2.getitemstring(row,'labour_id')
		ls_sp_id = labour_details.tabpage_2.dw_2.getitemstring(row,'spouse_id')
		ls_spouse_name = labour_details.tabpage_2.dw_2.getitemstring(row,'spouse_name')
		ld_date = Date(ls_dob);
		if isnull(ls_dob) = true or ls_dob='00/00/0000'  then
			messagebox('Warning!', 'Spouse DOB Should Be Enter , Please Check !!!')
			return 1
		end if
		
		if Date(ls_dob) > today()  then
			messagebox('Alert!','Spouse DOB Should Be <= Current Date  !!!')
			return 1
		end if
		
		if wf_check_duplicate_rec2(ls_sp_id,ls_spouse_name,datetime(ls_dob)) = -1 then return 1
		 
		select distinct 'x'  into :ls_temp
			from fb_labourspouse
			where (labour_id = :ls_labour_id or (nvl(spouse_id,'x') = nvl(:ls_sp_id,'x')) and spouse_name=:ls_spouse_name and trunc(spouse_dob)=trunc(:ld_date)) and nvl(SPOUSE_ACTIVE,'0') = '1';
		
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting Labour spouse Detail  : '+sqlca.sqlerrtext)
			return 1 
		elseif sqlca.sqlcode = 0 then 
			messagebox('Warning!','Spouse Detail Already Present, Please Check !!!')
			return 1
		end if;	
	end if
	
	if dwo.name = 'spouse_name'  then
		ls_spouse_name = data
		
		if f_check_special_char(ls_spouse_name) = -1 then return 1
		
		if isnull(ls_spouse_name)=true or len(ls_spouse_name) = 0 then
			messagebox('Warrnig:','Spouse Name Should Not Be Blank, Please Check !!!')
			return 1
		end if;
	end if;
	
	labour_details.tabpage_2.dw_2.setitem(row,'spouse_entry_by',gs_user)
	labour_details.tabpage_2.dw_2.setitem(row,'spouse_entry_dt',datetime(today()))

cb_3.enabled = true 	
end if;

end event

event clicked;if dwo.name = 'b_1'  then
	if labour_details.tabpage_1.dw_1.rowcount( ) > 0 then
		labour_details.tabpage_2.dw_2.insertrow(0)
		ls_labour_id = labour_details.tabpage_1.dw_1.getitemstring(labour_details.tabpage_1.dw_1.getrow(),'emp_id')
		labour_details.tabpage_2.dw_2.setitem(labour_details.tabpage_2.dw_2.getrow(),'labour_id',ls_labour_id)
		labour_details.tabpage_2.dw_2.setitem(row,'spouse_entry_by',gs_user)
		labour_details.tabpage_2.dw_2.setitem(row,'spouse_entry_dt',datetime(today()))
	end if
end if


end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_labourspouse');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_2.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_2.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_labourspouse',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

type tabpage_3 from userobject within labour_details
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 3963
integer height = 2020
long backcolor = 67108864
string text = "Census"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tabpage_3
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 20
integer width = 3950
integer height = 1568
integer taborder = 60
string dataobject = "dw_gtelaf003"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> labour_details.tabpage_3.dw_3.rowcount() then
		IF wf_check_fillcol3(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = labour_details.tabpage_3.dw_3.rowcount() and labour_details.tabpage_3.dw_3.rowcount() > 1  then
		labour_details.tabpage_3.dw_3.setitem(newrow,'child_entry_by',gs_user)
		labour_details.tabpage_3.dw_3.setitem(newrow,'child_entry_dt',datetime(today()))
		labour_details.tabpage_3.dw_3.setitem(newrow,'labour_id',labour_details.tabpage_3.dw_3.getitemstring(currentrow,'labour_id'))
	end if
 end if
end if
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'labour_id'  then
	ls_labour_id = data	
	if isnull(ls_labour_id)=true or len(ls_labour_id)<1 then
		messagebox('Warrnig:','Please select a valid Labour Id')
          rollback using sqlca;
	      return 1
	end if;
end if;

if dwo.name = 'child_name'  then
	ls_child_name = data	
	
	if f_check_string_sp(data) = -1 then return 1
	
	if isnull(ls_child_name)=true or len(ls_child_name)<1 then
		messagebox('Warrnig:','Please Enter a valid Child Name')
          rollback using sqlca;
	      return 1
	end if;
end if;

if dwo.name = 'child_gender'  then
	ls_child_gender = data	
	if isnull(ls_child_gender)=true or len(ls_child_gender)<1 then
		messagebox('Warrnig:','Please Enter a valid Child gender')
          rollback using sqlca;
	      return 1
	end if;
end if;


if dwo.name = 'child_dob' then
	if  labour_details.tabpage_3.dw_3.getitemstring(row,'child_dependenttype') = 'CHILD' then
		ld_labdob = labour_details.tabpage_1.dw_1.getitemdatetime(labour_details.tabpage_1.dw_1.getrow(),'emp_dob')
		ld_childdob = datetime(data)
		ls_rowid = labour_details.tabpage_3.dw_3.getitemstring(row,'rowid')
		select months_between(:ld_childdob,:ld_labdob) into :ll_agediff from dual;
		if sqlca.sqlcode = -1 then
			messagebox('Error while checking age difference',sqlca.sqlerrtext)
			return 1
		end if
		if ll_agediff <= 216 then
			messagebox('Error','Age difference between parent and child should be greater then 18 yrs.')
			return 1
		end if
		ls_emp =  labour_details.tabpage_3.dw_3.getitemstring(row,'labour_id')
		select 'x' into :ls_temp from fb_labourdependent where labour_id = :ls_emp and child_dependenttype = 'CHILD' and   months_between(:ld_childdob,child_dob) between - 6 and 6 and rownum = 1 and rowid <> nvl(:ls_rowid, 'x');
		if sqlca.sqlcode = -1 then
			messagebox('Error while checking age difference 2',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning','Age difference between 2 child can not be less than 6 months')
			return 1
		end if 
	end if
end if

if dwo.name = 'child_dob'  and lb_query = false then
	ls_dob= data
	
	if isnull(ls_dob) = true or ls_dob='00/00/0000'  then
		messagebox('Warning!', 'Child DOB Should Be Enter , Please Check !!!')
		return 1
	end if
	
	if Date(ls_dob) > date(string(today(),'dd/mm/yyyy'))  then
		messagebox('Alert!','Child DOB Should Be <= Current Date  !!!')
		return 1
	end if
	
	select distinct 'x'  into :ls_temp
	   from fb_labourdependent
      where labour_id=:ls_labour_id and child_name=:ls_child_name and trunc(child_dob)=to_date(:ls_dob,'dd/mm/yyyy');
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During Getting Labour Child Detail  : '+sqlca.sqlerrtext)
	      rollback using sqlca;
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Labour & Child Already Present In Child Detail Master  : '+sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if;	
	ld_dobpre = datetime(data)
	labour_details.tabpage_3.dw_3.setitem(row,'child_dob',date(ld_dobpre))
end if;
	labour_details.tabpage_3.dw_3.setitem(row,'child_entry_by',gs_user)
	labour_details.tabpage_3.dw_3.setitem(row,'child_entry_dt',datetime(today()))

cb_3.enabled = true 

if labour_details.tabpage_3.dw_3.getrow() = labour_details.tabpage_3.dw_3.rowcount() and lb_neworder =true then
	labour_details.tabpage_3.dw_3.insertrow(0)
end if
end event

event clicked;if dwo.name = 'b_1'  then
	if labour_details.tabpage_1.dw_1.rowcount( ) > 0 then
		labour_details.tabpage_3.dw_3.scrolltorow(labour_details.tabpage_3.dw_3.insertrow(0))
		labour_details.tabpage_3.dw_3.setitem(labour_details.tabpage_3.dw_3.getrow(),'child_entry_by',gs_user)
		labour_details.tabpage_3.dw_3.setitem(labour_details.tabpage_3.dw_3.getrow(),'child_entry_dt',datetime(today()))
		labour_details.tabpage_3.dw_3.setitem(labour_details.tabpage_3.dw_3.getrow(),'labour_id',labour_details.tabpage_1.dw_1.getitemstring(labour_details.tabpage_1.dw_1.getrow(),'emp_id'))
		
		labour_details.tabpage_3.dw_3.setitem(labour_details.tabpage_3.dw_3.getrow(),'rowid','XXXXXXXXXXXXXXXXXX')
		
		
	end if
end if

/// labour_details.tabpage_3.dw_3.getitemstring(row,'rowid')

end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_labourdependent');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_3.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_3.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_labourdependent',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

type gb_1 from groupbox within w_gtelaf002
integer x = 32
integer width = 1431
integer height = 136
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

