$PBExportHeader$w_gtepmf001.srw
forward
global type w_gtepmf001 from window
end type
type st_2 from statictext within w_gtepmf001
end type
type ddlb_1 from dropdownlistbox within w_gtepmf001
end type
type cb_4 from commandbutton within w_gtepmf001
end type
type cb_3 from commandbutton within w_gtepmf001
end type
type cb_2 from commandbutton within w_gtepmf001
end type
type cb_1 from commandbutton within w_gtepmf001
end type
type dw_1 from datawindow within w_gtepmf001
end type
end forward

global type w_gtepmf001 from window
integer width = 4494
integer height = 2280
boolean titlebar = true
string title = "(w_gtepmf001) Parameter Master"
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
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtepmf001 w_gtepmf001

type variables
long ll_ctr, ll_cnt, ll_year, ll_last,ll_user_level
string ls_temp,ls_fp,ls_last,ls_type,ls_desc,ls_docty,ls_code
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt
double ld_value,ld_rcamt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_type, string fs_fp, datetime fd_dt, string fs_desc, string fs_code)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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
	 if dw_1.getitemstring(fl_row,'pd_valuetype') = 'N' then
		if ( isnull(dw_1.getitemstring(fl_row,'pd_doc_type')) or  len(dw_1.getitemstring(fl_row,'pd_doc_type'))=0 or &
			 isnull(dw_1.getitemstring(fl_row,'pd_desc')) or  len(dw_1.getitemstring(fl_row,'pd_desc'))=0 or &
			 isnull(dw_1.getitemstring(fl_row,'pd_valuetype')) or  len(dw_1.getitemstring(fl_row,'pd_valuetype'))=0 ) then
				messagebox('Warning: One Of The Following Fields Are Blank', 'Document Type, Description, Fixed/Percent, Please Check !!!')
			 return -1
		end if	
	elseif ( isnull(dw_1.getitemstring(fl_row,'pd_doc_type')) or  len(dw_1.getitemstring(fl_row,'pd_doc_type'))=0 or &
			 isnull(dw_1.getitemstring(fl_row,'pd_desc')) or  len(dw_1.getitemstring(fl_row,'pd_desc'))=0 or &
			 isnull(dw_1.getitemstring(fl_row,'pd_valuetype')) or  len(dw_1.getitemstring(fl_row,'pd_valuetype'))=0 or &
			 isnull(dw_1.getitemdatetime(fl_row,'pd_period_from')) or &
			 isnull(dw_1.getitemnumber(fl_row,'pd_value')) or dw_1.getitemnumber(fl_row,'pd_value') < 0) then
			 messagebox('Warning: One Of The Following Fields Are Blank', 'Document Type, Description, Fixed/Percent, Value, Please Check !!!')
			 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_type, string fs_fp, datetime fd_dt, string fs_desc, string fs_code);long fl_row
string ls_type1,ls_fp1,ls_desc1, ls_code1
datetime ld_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_type1 = dw_1.getitemstring(fl_row,'pd_doc_type')
		ls_desc1 = dw_1.getitemstring(fl_row,'pd_desc')
		ls_code1 = dw_1.getitemstring(fl_row,'pd_code')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'pd_period_from')
		ls_fp1 = dw_1.getitemstring(fl_row,'pd_valuetype')
		
		if ls_type1 = fs_type and fs_fp = ls_fp1 and ld_dt1 = fd_dt  and fs_desc=ls_desc1 and ls_code1 = fs_code then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtepmf001.create
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.ddlb_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtepmf001.destroy
destroy(this.st_2)
destroy(this.ddlb_1)
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
setpointer(hourglass!)
dw_1.settransobject(sqlca)
//ddlb_1.additem('ALL')
declare c1 cursor for
select distinct PD_DOC_TYPE from fb_param_detail
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_docty;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_docty))
		fetch c1 into :ls_docty;
	loop
	close c1;
end if

//ddlb_1.text='ALL'
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

type st_2 from statictext within w_gtepmf001
integer x = 23
integer y = 32
integer width = 485
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Document Type :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtepmf001
integer x = 512
integer y = 16
integer width = 713
integer height = 960
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_gtepmf001
integer x = 2030
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

type cb_3 from commandbutton within w_gtepmf001
integer x = 1765
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'pd_doc_type')) or len(dw_1.getitemstring(dw_1.rowcount(),'pd_doc_type'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	
		for ll_ctr = 1 to dw_1.rowcount( ) 
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'pd_period_from')
			ls_type = dw_1.getitemstring(ll_ctr,'pd_doc_type')
			ls_fp = dw_1.getitemstring(ll_ctr,'pd_valuetype')
			if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then	
				if (ls_type = 'PLUINCRT' or ls_type = 'PLUINCKG') and isnull(dw_1.getitemdatetime(ll_ctr,'pd_period_to')) or string(dw_1.getitemdatetime(ll_ctr,'pd_period_to')) = '00/00/0000' then
					messagebox('Warning!', 'Period To Should Not Be Blank, Please Enter Period To !!!')
					return 1
				end if
				
				if ls_type <> 'PLUINCRT' and ls_type <> 'PLUINCKG' then	
					select distinct 'x' into :ls_temp from fb_param_detail
					where PD_DOC_TYPE = :ls_type  and PD_DESC = :ls_desc and nvl(PD_VALUETYPE,'x') = nvl(:ls_fp,'x')  and pd_period_from >= :ld_frdt and pd_period_to is null;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode  = 0 then
						messagebox("Warning!","Record Already Exists, Please Check !!!")
						return 1
					end if
					
					update fb_param_detail set pd_period_to = (:ld_frdt - 1)
					where PD_DOC_TYPE = :ls_type and PD_DESC = :ls_desc and nvl(PD_VALUETYPE,'x') = nvl(:ls_fp,'x')  and pd_period_to is null and pd_period_from < :ld_frdt;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Record 1',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1				
					end if	
				end if
			end if
		next	
	end if

	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		
		if gs_garden_snm = 'FB'  then
			select nvl(pd_value,0) into :ld_rcamt	from fb_param_detail 
			where pd_doc_type = 'RCRATE' and trunc(sysdate) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));
		
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 0 then 
				update fb_laboursheet set ls_rcamt = :ld_rcamt where LS_RATIONCOMFLAG = '1' and  LS_LABOURTYPE = 'LT';
				if sqlca.sqlcode = -1 then
					messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
					return 1
				else
					commit using sqlca;
				end if 
			end if;
		end if		
		
		dw_1.reset()
		ddlb_1.reset()
		setnull(ls_temp)
		ddlb_1.text = ls_temp
		dw_1.settransobject(sqlca)
		declare c1 cursor for
		select distinct PD_DOC_TYPE from fb_param_detail
		order by 1 asc;
			
		open c1;
		
		IF sqlca.sqlcode = 0 THEN
			fetch c1 into :ls_docty;
			
			do while sqlca.sqlcode <> 100
				ddlb_1.additem(string(ls_docty))
				fetch c1 into :ls_docty;
			loop
			close c1;
		end if
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtepmf001
integer x = 1499
integer y = 8
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

event clicked;if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At Document Type ','The Document Type Should Not Be Blank, Please Check...!')
	return 1
end if;
ls_docty =ddlb_1.text

if ls_docty='LOCATION' then
	dw_1.modify("t_5.text = '"+'State Code'+"'")
	//t_5.text  ='State Code'
end if;	

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
	dw_1.setcolumn('pd_doc_type')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_docty)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtepmf001
integer x = 1234
integer y = 8
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
dw_1.reset()
if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Type !!!')
	return 1
end if

ls_docty = trim(ddlb_1.text)

if ls_docty='PFINTEREST' then  
	DECLARE c1 CURSOR FOR  
 	select distinct pd_desc from fb_param_detail where PD_Doc_type= 'PFINTEREST';
 	open c1;
 	IF sqlca.sqlcode = 0 THEN
		setnull(ls_desc)
		fetch c1 into :ls_desc;
	
		do while sqlca.sqlcode <> 100
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'pd_doc_type',ls_docty)
			dw_1.setitem(dw_1.getrow(),'pd_desc',ls_desc)
			dw_1.setitem(dw_1.getrow(),'pd_valuetype','F')
			dw_1.settaborder('pd_period_from',50)
			dw_1.settaborder('pd_period_to',55)
			dw_1.settaborder('pd_value',60)	
			dw_1.setitem(dw_1.getrow(),'pd_value',0)
			setnull(ls_desc)
		fetch c1 into :ls_desc;
		loop
	end if
else 	
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setitem(dw_1.getrow(),'pd_doc_type',ls_docty)
	if ls_docty='STATE CODE' then
		dw_1.settaborder('pd_desc',40) 
		dw_1.settaborder('pd_code',50) 
		dw_1.settaborder('pd_value',0) 
		dw_1.setitem(dw_1.getrow(),'pd_valuetype','F')
		dw_1.setitem(dw_1.getrow(),'pd_value',0)
	else
		dw_1.settaborder('pd_desc',0) 
		dw_1.settaborder('pd_code',0) 
		dw_1.settaborder('pd_value',50) 
		dw_1.setitem(dw_1.getrow(),'pd_valuetype','')
		dw_1.setitem(dw_1.getrow(),'pd_value',0)
	end if
end if

//commented by Piyush 21062024 Because of no use on NEW BUtton click
//DECLARE c1 CURSOR FOR  
//select PD_DESC,PD_CODE,PD_PERIOD_FROM,PD_PERIOD_TO,PD_VALUETYPE,PD_VALUE from fb_param_detail
//where PD_DOC_TYPE = :ls_docty and pd_period_to is null;
//
//open c1;
//	
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ls_desc,:ls_code,:ld_frdt,:ld_todt,:ls_type,:ld_value;
//	
//	do while sqlca.sqlcode <> 100
//		dw_1.scrolltorow(dw_1.insertrow(0))
//		dw_1.setitem(dw_1.getrow(),'pd_doc_type',ls_docty)
//		dw_1.setitem(dw_1.getrow(),'pd_desc',ls_desc)
//		dw_1.setitem(dw_1.getrow(),'pd_code',ls_code)
//		dw_1.setitem(dw_1.getrow(),'pd_period_from',ld_frdt)
//		dw_1.setitem(dw_1.getrow(),'pd_period_to',ld_todt)
//		dw_1.setitem(dw_1.getrow(),'pd_valuetype',ls_type)
//		dw_1.setitem(dw_1.getrow(),'pd_value',ld_value)		
//		dw_1.setitem(dw_1.getrow(),'pd_entry_by',gs_user)
//		dw_1.setitem(dw_1.getrow(),'pd_entry_dt',datetime(today()))
//		fetch c1 into :ls_desc,:ls_code,:ld_frdt,:ld_todt,:ls_type,:ld_value;
//	loop
//END IF
//close c1;
dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('pd_period_from')
lb_neworder = true
lb_query = false



//dw_1.settransobject(sqlca)
//lb_neworder = true
//lb_query = false
//
//if dw_1.rowcount() = 0 then
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'pd_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'pd_entry_dt',datetime(today()))
//	dw_1.setcolumn('pd_doc_type')
//else
//	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
//		return 1
//	END IF
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'pd_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'pd_entry_dt',datetime(today()))
//	dw_1.setcolumn('pd_doc_type')
//end if
//
//
end event

type dw_1 from datawindow within w_gtepmf001
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4430
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtepmf001"
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
		dw_1.setitem(newrow,'pd_entry_by',gs_user)
		dw_1.setitem(newrow,'pd_entry_dt',datetime(today()))
		dw_1.setcolumn('pd_doc_type')
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
	if dwo.name = 'pd_doc_type' then
		if f_check_initial_space(data) = -1 then return 1
		if f_check_string_sp(data) = -1 then return 1	
		if data='LOCATION' then
			dw_1.modify("t_5.text = '"+'State Code'+"'")
			//t_5.text  ='State Code'
		end if;	
		if data = 'PLUINCRT' or data = 'PLUINCKG' then
			dw_1.settaborder('pd_period_to',55)
		else
			dw_1.settaborder('pd_period_to',0)
		end if		
		
		if data='STATE CODE' then
			dw_1.settaborder('pd_desc',40) 
			dw_1.settaborder('pd_code',50) 
			dw_1.settaborder('pd_value',0) 
			dw_1.setitem(row,'pd_valuetype','F')
			dw_1.setitem(row,'pd_value',0)
		else
			dw_1.settaborder('pd_desc',0) 
			dw_1.settaborder('pd_code',0) 
			dw_1.settaborder('pd_value',50) 
			dw_1.setitem(row,'pd_valuetype','')
			dw_1.setitem(row,'pd_value',0)
		end if
		
		if data ='PFINTEREST' then
			dw_1.setitem(row,'pd_desc','PF Form5 interest per')
			dw_1.setitem(row,'pd_valuetype','F')
			dw_1.settaborder('pd_period_from',50)
			dw_1.settaborder('pd_period_to',55)
			dw_1.settaborder('pd_value',60)
			dw_1.setitem(row,'pd_value',0)
		end if
		
	end if
	
	if dwo.name = 'pd_desc' then
		if f_check_initial_space(data) = -1 then return 1
		if f_check_string_sp(data) = -1 then return 1	
	end if
	
	if dwo.name = 'pd_valuetype' then
		ls_type = dw_1.getitemstring(row,'pd_doc_type')
		ls_fp = data
		ld_value = 0
		dw_1.setitem(row,'pd_value',ld_value)
		select PD_VALUE into :ld_value from fb_param_detail
		where PD_DOC_TYPE = :ls_type and PD_DESC = :ls_desc and nvl(PD_VALUETYPE,'x') = nvl(:ls_fp,'x') and pd_period_to is null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Parameter Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			dw_1.setitem(row,'pd_value',ld_value)
		end if

	end if
	
	if dwo.name = 'pd_period_from'  then
		ld_frdt = datetime(data)
		ls_type = dw_1.getitemstring(row,'pd_doc_type')
		ls_desc = dw_1.getitemstring(row,'pd_desc')
		ls_code = dw_1.getitemstring(row,'pd_code')
		ls_fp = dw_1.getitemstring(row,'pd_valuetype')
		if ls_type = 'PLUINCRT' or ls_type = 'PLUINCKG' then
			dw_1.settaborder('pd_period_to',25)
			dw_1.setcolumn('pd_period_to')
		elseif ls_type='PFINTEREST'	then
			dw_1.settaborder('pd_period_to',55)
			dw_1.setcolumn('pd_period_to')
		else 
			dw_1.settaborder('pd_period_to',0)
		end if		

				
//		if  wf_check_duplicate_rec(ls_type,ls_fp,ld_frdt,ls_desc,ls_code) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_param_detail
		where PD_DOC_TYPE = :ls_type and PD_DESC = :ls_desc and nvl(PD_VALUETYPE,'x') = nvl(:ls_fp,'x') and pd_period_from >= :ld_frdt and pd_period_to is null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Parameter Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			if lb_neworder = true then
				messagebox("Warning!","Record Already Exists, Please Check !!!")
				return 1
			end if
		end if
	end if
	
	dw_1.setitem(row,'pd_entry_by',gs_user)
	dw_1.setitem(row,'pd_entry_dt',datetime(today()))

cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

event updatestart;integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id,ls_datatype

// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name,DATA_TYPE FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_param_detail');
close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);setnull(ls_datatype);
	fetch c1 into :ll_coumnid,:ls_columnname,:ls_datatype;

		do while sqlca.sqlcode <> 100
			
			if(ls_datatype='DATE') then
			// Get the old value for the data column
			       ls_old_value = string(dw_1.GetItemdatetime(li_row, ll_coumnid, Primary!, true),'dd/mm/yyyy')
			 // Get the new value for the data column
			       ls_new_value =  string(This.GetItemdatetime(li_row, ll_coumnid),'dd/mm/yyyy')
			elseif(ls_datatype='NUMBER' or ls_datatype='FLOAT' ) then
			// Get the old value for the data column
			       ls_old_value = string(dw_1.GetItemnumber(li_row, ll_coumnid, Primary!, true))
			 // Get the new value for the data column
			       ls_new_value =  string(This.GetItemnumber(li_row, ll_coumnid))
			else
			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemstring(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value =  This.GetItemstring(li_row, ll_coumnid)
			end if	
			
			// Get the unique Value of Row			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
			
			if ls_old_value <> ls_new_value then
				insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
										('fb_param_detail',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
				if sqlca.sqlcode = -1 then
					messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
					close c1;
					rollback using sqlca;
					return -1 
				end if
			end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);setnull(ls_datatype);

	fetch c1 into :ll_coumnid,:ls_columnname,:ls_datatype;
	loop
end if	
NEXT
close c1;
end event

