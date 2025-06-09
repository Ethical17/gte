$PBExportHeader$w_gtehrf018.srw
forward
global type w_gtehrf018 from window
end type
type ddlb_1 from dropdownlistbox within w_gtehrf018
end type
type st_5 from statictext within w_gtehrf018
end type
type em_2 from editmask within w_gtehrf018
end type
type st_3 from statictext within w_gtehrf018
end type
type ddlb_3 from dropdownlistbox within w_gtehrf018
end type
type st_4 from statictext within w_gtehrf018
end type
type st_1 from statictext within w_gtehrf018
end type
type em_1 from editmask within w_gtehrf018
end type
type cb_5 from commandbutton within w_gtehrf018
end type
type cb_2 from commandbutton within w_gtehrf018
end type
type cb_1 from commandbutton within w_gtehrf018
end type
type cb_3 from commandbutton within w_gtehrf018
end type
type cb_4 from commandbutton within w_gtehrf018
end type
type dw_1 from datawindow within w_gtehrf018
end type
end forward

global type w_gtehrf018 from window
integer width = 4343
integer height = 2152
boolean titlebar = true
string title = "(w_gtelaf045) All Deduction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_5 st_5
em_2 em_2
st_3 st_3
ddlb_3 ddlb_3
st_4 st_4
st_1 st_1
em_1 em_1
cb_5 cb_5
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
cb_4 cb_4
dw_1 dw_1
end type
global w_gtehrf018 w_gtehrf018

type variables
boolean lb_neworder, lb_query
string ls_temp,ls_yrmn,ls_labid,ls_div,ls_dt, ls_lwawid, ls_emptype, ls_ded_ty,ls_ym
long ll_ctr,ll_workdays,ll_mworkdays, ll_lsid, ll_user_level, ll_pbno
double  ld_amount
date ld_dtfr, ld_dtto, ld_dt
end variables

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
	case "PDF"
			this.dw_1.saveas("C:\reports\Gtebgr001.pdf",pdf!,true)
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

on w_gtehrf018.create
this.ddlb_1=create ddlb_1
this.st_5=create st_5
this.em_2=create em_2
this.st_3=create st_3
this.ddlb_3=create ddlb_3
this.st_4=create st_4
this.st_1=create st_1
this.em_1=create em_1
this.cb_5=create cb_5
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_5,&
this.em_2,&
this.st_3,&
this.ddlb_3,&
this.st_4,&
this.st_1,&
this.em_1,&
this.cb_5,&
this.cb_2,&
this.cb_1,&
this.cb_3,&
this.cb_4,&
this.dw_1}
end on

on w_gtehrf018.destroy
destroy(this.ddlb_1)
destroy(this.st_5)
destroy(this.em_2)
destroy(this.st_3)
destroy(this.ddlb_3)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false

this.tag = Message.StringParm
ll_user_level = long(this.tag)

setpointer(hourglass!)



setpointer(hourglass!)
declare c3 cursor for
select DM_NAME from fb_emp_dedtype_master order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_ded_ty;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_ded_ty)
		fetch c3 into :ls_ded_ty;
	loop
	close c3;
end if
setpointer(arrow!)


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type ddlb_1 from dropdownlistbox within w_gtehrf018
integer x = 2025
integer y = 8
integer width = 379
integer height = 316
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ST-Staff","SS-Sub Staff","AT-Apprentice"}
end type

type st_5 from statictext within w_gtehrf018
integer x = 1783
integer y = 20
integer width = 238
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emp Type"
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtehrf018
integer x = 357
integer y = 16
integer width = 279
integer height = 84
integer taborder = 50
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
string mask = "yyyy-mm"
end type

type st_3 from statictext within w_gtehrf018
integer x = 37
integer y = 24
integer width = 315
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year-Month:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtehrf018
integer x = 1115
integer y = 12
integer width = 649
integer height = 608
integer taborder = 20
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

event selectionchanged;//ls_dt = left(ddlb_1.text,10)
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//setpointer(hourglass!)
//declare c2 cursor for
//select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
//where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//ddlb_3.text = 'ALL'
//setpointer(Arrow!)
end event

type st_4 from statictext within w_gtehrf018
integer x = 677
integer y = 28
integer width = 443
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deduction Type : "
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtehrf018
integer x = 2432
integer y = 20
integer width = 233
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Amount"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrf018
integer x = 2670
integer y = 8
integer width = 251
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
end type

type cb_5 from commandbutton within w_gtehrf018
integer x = 4027
integer width = 265
integer height = 100
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Report"
end type

event clicked;if isnull(em_2.text) or len(em_2.text)  = 0  then
	messagebox('Alert!','Please Select Year Month !!!')
	return 1
end if

if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0  then
	messagebox('Alert!','Please Select Emp Type !!!')
	return 1
end if


if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0  then
	messagebox('Alert!','Please Select Deduction Type !!!')
	return 1
end if

ls_ym = left(em_2.text,4) + right(em_2.text,2)

ls_ded_ty  = ddlb_3.text

ls_emptype = left(ddlb_1.text,2)


gs_opt = ls_ym
gs_opt1 = left(ddlb_1.text,2)
gs_opt2 = ddlb_3.text
opensheetwithparm(w_gtehrr026,this.tag,w_mdi,0,layered!)
end event

type cb_2 from commandbutton within w_gtehrf018
integer x = 3227
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

event clicked;
if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
	messagebox('Alert!','Please Select Employee Type !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text  = '0000-00' then
	messagebox('Alert!','Please Enter Valid Year Month !!!')
	return 1
end if

if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0 then
	messagebox('Alert!','Please Select A Deduction Type !!!')
	return 1
end if

ld_amount = double(em_1.text)
ls_ym = left(em_2.text,4) + right(em_2.text,2)

ls_ded_ty  = ddlb_3.text

ls_emptype = left(ddlb_1.text,2)

setpointer(hourglass!)


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
	dw_1.Retrieve(ls_ym,ls_emptype,ls_ded_ty)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtehrf018
integer x = 2962
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

event clicked;dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
	messagebox('Alert!','Please Select Employee Type !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text  = '0000-00' then
	messagebox('Alert!','Please Enter Valid Year Month !!!')
	return 1
end if

if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0 then
	messagebox('Alert!','Please Select A Deduction Type !!!')
	return 1
end if

dw_1.reset()

ld_amount = double(em_1.text)
ls_ym = left(em_2.text,4) + right(em_2.text,2)

ls_ded_ty  = ddlb_3.text

ls_emptype = left(ddlb_1.text,2)

setpointer(hourglass!)

if isnull(ld_amount) then ld_amount=0

declare c1 cursor for 
select distinct a.EMP_ID, c.FIELD_ID, EMP_TYPE
  from FB_EMPATTENDANCE a,fb_employee c
where  a.EMP_ID = c.EMP_ID and 
	  	to_char(a.EATTEN_DATE,'YYYYMM') = :ls_ym and (EMP_ACTIVE = '1' or EMP_INACTIVETYPE = 'Regular') and emp_type = :ls_emptype and 
		  not exists (select * from fb_empdeduction where CD_EMP_ID = a.emp_id and CD_YEARMN = :ls_ym and CD_DED_TYPE = :ls_ded_ty)
order by EMP_ID, c.FIELD_ID,EMP_TYPE;

open c1;   

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
else 
	ll_workdays = 0; setnull(ls_labid);setnull(ls_div);setnull(ls_emptype);

	fetch c1 into :ls_labid,:ls_div,:ls_emptype;
	if sqlca.sqlcode = -1 then 
		messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
		return 1
	end if;
	do while sqlca.sqlcode <> 100     

		if ll_workdays >= ll_mworkdays then
			if isnull(ld_amount) then ld_amount = 0;
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'CD_YEARMN',ls_ym)
			dw_1.setitem(dw_1.getrow(),'cd_emp_id',ls_labid)
			dw_1.setitem(dw_1.getrow(),'field_id',ls_div)
			dw_1.setitem(dw_1.getrow(),'emp_type',ls_emptype)
			dw_1.setitem(dw_1.getrow(),'cd_ded_type',ls_ded_ty)
			dw_1.setitem(dw_1.getrow(),'cd_amount',ld_amount)
			dw_1.setitem(dw_1.getrow(),'cd_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'cd_entry_dt',datetime(today()))
		end if;	

	ll_workdays = 0; setnull(ls_labid);setnull(ls_div);setnull(ls_emptype);
	fetch c1 into :ls_labid,:ls_div,:ls_emptype;
		  
  loop;
close c1;  
end if;	

dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('cd_amount')
lb_neworder = true
lb_query = false
setpointer(arrow!)
end event

type cb_3 from commandbutton within w_gtehrf018
integer x = 3493
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' or dw_1.getitemnumber(ll_ctr,'cd_amount') = 0 then
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

type cb_4 from commandbutton within w_gtehrf018
integer x = 3762
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

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtehrf018
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 27
integer y = 124
integer width = 4265
integer height = 1912
string dataobject = "dw_gtehrf018"
boolean vscrollbar = true
end type

event itemchanged;cb_3.enabled = true
end event

