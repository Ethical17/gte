$PBExportHeader$w_gtelaf045.srw
forward
global type w_gtelaf045 from window
end type
type cbx_2 from checkbox within w_gtelaf045
end type
type cbx_1 from checkbox within w_gtelaf045
end type
type ddlb_3 from dropdownlistbox within w_gtelaf045
end type
type st_4 from statictext within w_gtelaf045
end type
type st_1 from statictext within w_gtelaf045
end type
type em_1 from editmask within w_gtelaf045
end type
type ddlb_2 from dropdownlistbox within w_gtelaf045
end type
type st_2 from statictext within w_gtelaf045
end type
type st_3 from statictext within w_gtelaf045
end type
type ddlb_1 from dropdownlistbox within w_gtelaf045
end type
type cb_5 from commandbutton within w_gtelaf045
end type
type cb_2 from commandbutton within w_gtelaf045
end type
type cb_1 from commandbutton within w_gtelaf045
end type
type cb_3 from commandbutton within w_gtelaf045
end type
type cb_4 from commandbutton within w_gtelaf045
end type
type dw_1 from datawindow within w_gtelaf045
end type
end forward

global type w_gtelaf045 from window
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
cbx_2 cbx_2
cbx_1 cbx_1
ddlb_3 ddlb_3
st_4 st_4
st_1 st_1
em_1 em_1
ddlb_2 ddlb_2
st_2 st_2
st_3 st_3
ddlb_1 ddlb_1
cb_5 cb_5
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
cb_4 cb_4
dw_1 dw_1
end type
global w_gtelaf045 w_gtelaf045

type variables
boolean lb_neworder, lb_query
string ls_temp,ls_yrmn,ls_labid,ls_div,ls_dt, ls_lwawid, ls_emptype, ls_ded_ty
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

on w_gtelaf045.create
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.ddlb_3=create ddlb_3
this.st_4=create st_4
this.st_1=create st_1
this.em_1=create em_1
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.cb_5=create cb_5
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.cbx_2,&
this.cbx_1,&
this.ddlb_3,&
this.st_4,&
this.st_1,&
this.em_1,&
this.ddlb_2,&
this.st_2,&
this.st_3,&
this.ddlb_1,&
this.cb_5,&
this.cb_2,&
this.cb_1,&
this.cb_3,&
this.cb_4,&
this.dw_1}
end on

on w_gtelaf045.destroy
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.ddlb_3)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.ddlb_1)
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

//if gs_garden_snm = 'SP' then
//	cbx_1.visible = false
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

setpointer(hourglass!)
declare c1 cursor for
select distinct to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy')||'-'||LWW_ID,LWW_ID
  from fb_LABOURWAGESWEEK b
  where lww_paidflag='0'
order by LWW_ID desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ls_lwawid;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ls_lwawid;
	loop
	close c1;
end if
setpointer(arrow!)


ddlb_2.reset()
ddlb_2.additem('0')

declare c2 cursor for
select distinct ls_id  from FB_EMPLOYEE a where emp_type in ('LP','LT','LO') order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = '0'

setpointer(hourglass!)

declare c3 cursor for
select DM_NAME from fb_dedtype_master order by 1;

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

type cbx_2 from checkbox within w_gtelaf045
integer x = 2062
integer y = 132
integer width = 873
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fill Amount from Deduction Master"
end type

event clicked;if cbx_2.checked = true then
	cbx_1.checked = false
	em_1.enabled = false
elseif cbx_2.checked = false then
	em_1.enabled = true
end if
end event

type cbx_1 from checkbox within w_gtelaf045
integer x = 1207
integer y = 132
integer width = 818
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fill Amount from previous period"
end type

event clicked;if cbx_1.checked = true then
	cbx_2.checked = false
	em_1.enabled = false
elseif cbx_1.checked = false then
	em_1.enabled = true
end if

end event

type ddlb_3 from dropdownlistbox within w_gtelaf045
integer x = 2126
integer y = 8
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

type st_4 from statictext within w_gtelaf045
integer x = 1687
integer y = 24
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

type st_1 from statictext within w_gtelaf045
integer x = 3749
integer y = 24
integer width = 279
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

type em_1 from editmask within w_gtelaf045
integer x = 4037
integer y = 12
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

type ddlb_2 from dropdownlistbox within w_gtelaf045
integer x = 3410
integer y = 12
integer width = 325
integer height = 608
integer taborder = 30
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

type st_2 from statictext within w_gtelaf045
integer x = 2816
integer y = 24
integer width = 562
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No. (0-ALL)"
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtelaf045
integer x = 32
integer y = 32
integer width = 439
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Payment Period : "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtelaf045
integer x = 471
integer y = 16
integer width = 1152
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

type cb_5 from commandbutton within w_gtelaf045
integer x = 4027
integer y = 112
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

event clicked;if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0  then
	messagebox('Alert!','Please Select A Period !!!')
	return 1
end if

gs_opt = ls_lwawid
gs_opt1 = string(ll_lsid)
gs_opt2 = ddlb_3.text
opensheetwithparm(w_gtelar055,this.tag,w_mdi,0,layered!)
end event

type cb_2 from commandbutton within w_gtelaf045
integer x = 3227
integer y = 112
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

event clicked;if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
	messagebox('Alert!','Please Select A Period !!!')
	return 1
end if

if isnull(ddlb_2.text) or len(ddlb_2.text)  = 0 then
	messagebox('Alert!','Please Select A Paybook !!!')
	return 1
end if

if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0 then
	messagebox('Alert!','Please Select A Deduction Type !!!')
	return 1
end if

ld_dtfr = date(left(trim(ddlb_1.text),10))
ld_dtto = date(mid(trim(ddlb_1.text),12,10))
ls_lwawid = right(trim(ddlb_1.text),13)
ls_ded_ty  = ddlb_3.text


ll_lsid = long(ddlb_2.text)

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
	dw_1.Retrieve(ls_lwawid,ll_lsid,ls_ded_ty)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf045
integer x = 2962
integer y = 112
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
	messagebox('Alert!','Please Select A Period !!!')
	return 1
end if

if isnull(ddlb_2.text) or len(ddlb_2.text)  = 0 then
	messagebox('Alert!','Please Select A Paybook !!!')
	return 1
end if

if isnull(ddlb_3.text) or len(ddlb_3.text)  = 0 then
	messagebox('Alert!','Please Select A Deduction Type !!!')
	return 1
end if



dw_1.reset()

ld_dtfr = date(left(trim(ddlb_1.text),10))
ld_dtto = date(mid(trim(ddlb_1.text),12,10))
ls_lwawid = right(trim(ddlb_1.text),13)
ll_lsid = long(ddlb_2.text)
ld_amount = double(em_1.text)
ls_ded_ty  = ddlb_3.text

if gs_garden_snm = 'SP' and ls_ded_ty = 'BPUJA2' then
	messagebox('Warning','This deduction type is reserved for Mandir Fund')
	return 1;
end if

setpointer(hourglass!)

if isnull(ld_amount) then ld_amount=0

if cbx_1.checked=true then
	declare c1 cursor for 
		  select d.LABOUR_ID,d.LS_ID, d.FIELD_ID, d.EMP_TYPE,e.CD_AMOUNT from (select LABOUR_ID,LS_ID, FIELD_ID, EMP_TYPE
		  from FB_LABOURDAILYATTENDANCE a,fb_employee c
		  where  a.LABOUR_ID = c.EMP_ID and nvl(LDA_WAGES,0) > 0 and 
		  trunc(a.LDA_DATE) between trunc(:ld_dtfr) and trunc(:ld_dtto) and (EMP_ACTIVE = '1' or EMP_INACTIVETYPE = 'Regular') and ls_id = decode(nvl(:ll_lsid,0),0,LS_ID,:ll_lsid) and 
		  not exists (select * from fb_labcopdeduction where CD_EMP_ID = labour_id and LWW_ID = a.lww_id and CD_DED_TYPE = :ls_ded_ty)
		  group by LABOUR_ID,LS_ID, FIELD_ID,EMP_TYPE
		  order by LS_ID, LABOUR_ID, FIELD_ID,EMP_TYPE)d, fb_labcopdeduction e where e.CD_EMP_ID (+)= d.LABOUR_ID  and e.CD_DED_TYPE = :ls_ded_ty  
		  and e.lww_id = ( select lww_id from fb_LABOURWAGESWEEK where  lww_enddate = :ld_dtfr - 1) 
		  group by LABOUR_ID,LS_ID, FIELD_ID,EMP_TYPE,CD_AMOUNT 
		  order by LS_ID, LABOUR_ID, FIELD_ID,EMP_TYPE;
     open c1;
		
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	else
		ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);ld_amount=0;
		fetch c1 into :ls_labid,:ll_lsid,:ls_div,:ls_emptype,:ld_amount;
		
		if sqlca.sqlcode = -1 then 
		messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
		return 1
		end if;
		do while sqlca.sqlcode <> 100     

		if ll_workdays >= ll_mworkdays then
			if isnull(ld_amount) then ld_amount = 0;
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwawid)
			dw_1.setitem(dw_1.getrow(),'cd_emp_id',ls_labid)
			dw_1.setitem(dw_1.getrow(),'field_id',ls_div)
			dw_1.setitem(dw_1.getrow(),'ls_id',ll_lsid)
			dw_1.setitem(dw_1.getrow(),'emp_type',ls_emptype)
			dw_1.setitem(dw_1.getrow(),'cd_ded_type',ls_ded_ty)
			dw_1.setitem(dw_1.getrow(),'cd_amount',ld_amount)
			dw_1.setitem(dw_1.getrow(),'cd_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'cd_entry_dt',datetime(today()))
		end if;	

		ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);ld_amount=0;
		fetch c1 into :ls_labid,:ll_lsid,:ls_div,:ls_emptype,:ld_amount;
		  
  		loop;
		close c1;  
	end if;
	
elseif cbx_2.checked=true then
	declare c3 cursor for 
          select d.LABOUR_ID,d.LS_ID, d.FIELD_ID, d.EMP_TYPE,e.LD_AMOUNT from (select distinct LABOUR_ID,LS_ID, FIELD_ID, EMP_TYPE
          from FB_LABOURDAILYATTENDANCE a,fb_employee c
          where  a.LABOUR_ID = c.EMP_ID and nvl(LDA_WAGES,0) > 0 and 
          trunc(a.LDA_DATE) between trunc(:ld_dtfr) and trunc(:ld_dtto) and (EMP_ACTIVE = '1' or EMP_INACTIVETYPE = 'Regular') and ls_id = decode(nvl(:ll_lsid,0),0,LS_ID,:ll_lsid) and 
          not exists (select * from fb_labcopdeduction where CD_EMP_ID = labour_id and LWW_ID = a.lww_id and CD_DED_TYPE = :ls_ded_ty)
          group by LABOUR_ID,LS_ID, FIELD_ID,EMP_TYPE
          order by LS_ID, LABOUR_ID, FIELD_ID,EMP_TYPE)d, fb_labdeduction_master e where e.LABOUR_ID = d.LABOUR_ID  and e.LD_TYPE = :ls_ded_ty  
          group by d.LABOUR_ID,LS_ID, FIELD_ID,EMP_TYPE,LD_AMOUNT 
          order by LS_ID, LABOUR_ID, FIELD_ID,EMP_TYPE;
     open c3;
		
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Opening Cursor c3 : ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	else
		ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);ld_amount=0;
		fetch c3 into :ls_labid,:ll_lsid,:ls_div,:ls_emptype,:ld_amount;
		
		if sqlca.sqlcode = -1 then 
		messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
		return 1
		end if;
		do while sqlca.sqlcode <> 100     

		if ll_workdays >= ll_mworkdays then
			if isnull(ld_amount) then ld_amount = 0;
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwawid)
			dw_1.setitem(dw_1.getrow(),'cd_emp_id',ls_labid)
			dw_1.setitem(dw_1.getrow(),'field_id',ls_div)
			dw_1.setitem(dw_1.getrow(),'ls_id',ll_lsid)
			dw_1.setitem(dw_1.getrow(),'emp_type',ls_emptype)
			dw_1.setitem(dw_1.getrow(),'cd_ded_type',ls_ded_ty)
			dw_1.setitem(dw_1.getrow(),'cd_amount',ld_amount)
			dw_1.setitem(dw_1.getrow(),'cd_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'cd_entry_dt',datetime(today()))
		end if;	

		ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);ld_amount=0;
		fetch c3 into :ls_labid,:ll_lsid,:ls_div,:ls_emptype,:ld_amount;
		  
  		loop;
		close c3;  
	end if;	
	
else
	//select * from fb_labcopdeduction where LWW_ID = 'LWW0000000114' and CD_DED_TYPE = 'COOPRATIVE'
		
	declare c2 cursor for 
		select LABOUR_ID,LS_ID, FIELD_ID, EMP_TYPE
		  from FB_LABOURDAILYATTENDANCE a,fb_employee c
		where  a.LABOUR_ID = c.EMP_ID and nvl(LDA_WAGES,0) > 0 and 
		trunc(a.LDA_DATE) between trunc(:ld_dtfr) and trunc(:ld_dtto) and (EMP_ACTIVE = '1' or EMP_INACTIVETYPE = 'Regular') and ls_id = decode(nvl(:ll_lsid,0),0,LS_ID,:ll_lsid) and 
		  not exists (select * from fb_labcopdeduction where CD_EMP_ID = labour_id and LWW_ID = a.lww_id and CD_DED_TYPE = :ls_ded_ty)
		group by LABOUR_ID,LS_ID, FIELD_ID,EMP_TYPE
		order by LS_ID, LABOUR_ID, FIELD_ID,EMP_TYPE;
	open c2;
		
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	else
		ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);
		fetch c2 into :ls_labid,:ll_lsid,:ls_div,:ls_emptype;
		
		if sqlca.sqlcode = -1 then 
			messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
			rollback using sqlca; 
			return 1
		end if;
		do while sqlca.sqlcode <> 100     

		if ll_workdays >= ll_mworkdays then
			if isnull(ld_amount) then ld_amount = 0;
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'lww_id',ls_lwawid)
			dw_1.setitem(dw_1.getrow(),'cd_emp_id',ls_labid)
			dw_1.setitem(dw_1.getrow(),'field_id',ls_div)
			dw_1.setitem(dw_1.getrow(),'ls_id',ll_lsid)
			dw_1.setitem(dw_1.getrow(),'emp_type',ls_emptype)
			dw_1.setitem(dw_1.getrow(),'cd_ded_type',ls_ded_ty)
			dw_1.setitem(dw_1.getrow(),'cd_amount',ld_amount)
			dw_1.setitem(dw_1.getrow(),'cd_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'cd_entry_dt',datetime(today()))
		end if;	

		ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);
		fetch c2 into :ls_labid,:ll_lsid,:ls_div,:ls_emptype;
		  
  		loop;
		close c2;  
	end if;	
end if;

dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('cd_amount')
lb_neworder = true
lb_query = false
setpointer(arrow!)
end event

type cb_3 from commandbutton within w_gtelaf045
integer x = 3493
integer y = 112
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

type cb_4 from commandbutton within w_gtelaf045
integer x = 3762
integer y = 112
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

type dw_1 from datawindow within w_gtelaf045
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 27
integer y = 220
integer width = 4265
integer height = 1816
string dataobject = "dw_gtelaf045"
boolean vscrollbar = true
end type

event itemchanged;cb_3.enabled = true
end event

