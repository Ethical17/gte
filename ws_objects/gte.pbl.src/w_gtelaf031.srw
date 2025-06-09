$PBExportHeader$w_gtelaf031.srw
forward
global type w_gtelaf031 from window
end type
type st_3 from statictext within w_gtelaf031
end type
type cb_5 from commandbutton within w_gtelaf031
end type
type cb_2 from commandbutton within w_gtelaf031
end type
type cb_1 from commandbutton within w_gtelaf031
end type
type cb_3 from commandbutton within w_gtelaf031
end type
type cb_4 from commandbutton within w_gtelaf031
end type
type dw_1 from datawindow within w_gtelaf031
end type
type ddlb_1 from dropdownlistbox within w_gtelaf031
end type
end forward

global type w_gtelaf031 from window
integer width = 3685
integer height = 2152
boolean titlebar = true
string title = "(w_gtelaf031) Fortnight Advance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
cb_5 cb_5
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
cb_4 cb_4
dw_1 dw_1
ddlb_1 ddlb_1
end type
global w_gtelaf031 w_gtelaf031

type variables
boolean lb_neworder, lb_query
string ls_temp,ls_yrmn,ls_labid,ls_div,ls_dt, ls_lwawid, ls_emptype
long ll_ctr,ll_workdays,ll_mworkdays, ll_lsid
double ld_advamt, ld_amount
date ld_dtfr, ld_dtto
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

on w_gtelaf031.create
this.st_3=create st_3
this.cb_5=create cb_5
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.Control[]={this.st_3,&
this.cb_5,&
this.cb_2,&
this.cb_1,&
this.cb_3,&
this.cb_4,&
this.dw_1,&
this.ddlb_1}
end on

on w_gtelaf031.destroy
destroy(this.st_3)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.ddlb_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

lb_query = false	
lb_neworder = false

setpointer(hourglass!)
declare c1 cursor for
select distinct to_char(LWAW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWAW_ENDDATE,'dd/mm/yyyy')||'-'||LWAW_ID,LWAW_ID
  from fb_labourwagadvweek b
  where LWAW_PAIDFLAG = '0'
order by LWAW_ID desc;

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
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_3 from statictext within w_gtelaf031
integer x = 41
integer y = 28
integer width = 457
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " Advance Period : "
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_gtelaf031
integer x = 2638
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
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
opensheetwithparm(w_gtelar031,this.tag,w_mdi,0,layered!)
end event

type cb_2 from commandbutton within w_gtelaf031
integer x = 1838
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
string text = "&Query"
end type

event clicked;//if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
//	messagebox('Alert!','Please Select A Period !!!')
//	return 1
//end if

//ld_dtfr = date(left(trim(ddlb_1.text),10))
//ld_dtto = date(right(trim(ddlb_1.text),10))


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
	dw_1.Retrieve()
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf031
integer x = 1573
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
string text = "&New"
end type

event clicked;dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if isnull(ddlb_1.text) or len(ddlb_1.text)  = 0 then
	messagebox('Alert!','Please Select A Period !!!')
	return 1
end if

ld_dtfr = date(left(trim(ddlb_1.text),10))
ld_dtto = date(mid(trim(ddlb_1.text),12,10))
ls_lwawid = right(trim(ddlb_1.text),9)

setpointer(hourglass!)

//select distinct 'x' into :ls_temp from FB_FORTNIGHTADVANCE where FA_YRMN = :ls_yrmn;
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Sql Error : During checking the Fortnight Advance Calculation ',sqlca.sqlerrtext); 
//	rollback using sqlca; 
//	return 1; 
//elseif sqlca.sqlcode = 0 then
//	if messagebox('Fortnighly Advance Warning ','Fortnighly Advance Already Calculated, Do You want to re-calculate Again ...!',question!,yesno!,1) = 1 then
//		delete from FB_FORTNIGHTADVANCE where FA_YRMN = :ls_yrmn;
//		
//		if sqlca.sqlcode = -1 then 
//			messagebox('Sql Error : During Deleting Fortnight Advance ',sqlca.sqlerrtext); 
//			rollback using sqlca; 
//			return 1; 
//		end if
//		commit using sqlca;
//	else
//		return 1
//	end if
//end if

select sum(decode(pd_doc_type,'FNIGHTADV',nvl(PD_VALUE,0),0)),sum(decode(pd_doc_type,'FNWORKDAYS',nvl(PD_VALUE,0),0))
	into :ld_advamt,:ll_mworkdays
	from fb_param_detail
 where PD_DOC_TYPE in ('FNIGHTADV','FNWORKDAYS') and trunc(:ld_dtfr) between trunc(PD_PERIOD_FROM) and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Getting Advance Amount : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
elseif sqlca.sqlcode = 100 then
	messagebox('Warning !','Advance Amount & Minimum Works Days For Fortnight For Selected Year Month Is Not Present, Please Enter In Tools -> Parameter Master !!!')
	return 1
end if

if isnull(ld_advamt) then ld_advamt=0
if isnull(ll_mworkdays) then ll_mworkdays=0

declare c1 cursor for 
select count(LDA_DATE) workdays,LABOUR_ID,LS_ID, FIELD_ID, EMP_TYPE
  from FB_LABOURDAILYATTENDANCE a,FB_KAMSUBHEAD b,fb_employee c
where a.KAMSUB_ID = b.KAMSUB_ID and nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and a.LABOUR_ID = c.EMP_ID and emp_fortnightadv = 'Y' and 
		 nvl(LDA_WAGES,0) > 0 and b.kamsub_nkamtype NOT IN ('SICKNOWAGES', 'SICKALLOWANCE', 'MATERNITY') and
	  	trunc(a.LDA_DATE) between trunc(:ld_dtfr) and trunc(:ld_dtto)
group by LABOUR_ID,LS_ID, FIELD_ID,EMP_TYPE;

open c1;   

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return 1; 
else 
	ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);

	fetch c1 into :ll_workdays,:ls_labid,:ll_lsid,:ls_div,:ls_emptype;
	if sqlca.sqlcode = -1 then 
		messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
		return 1
	end if;
	do while sqlca.sqlcode <> 100     

		if ll_workdays >= ll_mworkdays then
			if isnull(ld_advamt) then ld_advamt = 0;
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'lwaw_id',ls_lwawid)
			dw_1.setitem(dw_1.getrow(),'labour_id',ls_labid)
			dw_1.setitem(dw_1.getrow(),'field_id',ls_div)
			dw_1.setitem(dw_1.getrow(),'ls_id',ll_lsid)
			dw_1.setitem(dw_1.getrow(),'lwaw_emptype',ls_emptype)
			dw_1.setitem(dw_1.getrow(),'lwaw_workdays',ll_workdays)
			dw_1.setitem(dw_1.getrow(),'lwaw_advance',ld_advamt)
			dw_1.setitem(dw_1.getrow(),'lwaw_entry_by',gs_user)
			dw_1.setitem(dw_1.getrow(),'lwaw_entry_dt',datetime(today()))
		end if;	

	ll_workdays = 0; setnull(ls_labid);setnull(ls_div);ll_lsid = 0;setnull(ls_emptype);
	fetch c1 into :ll_workdays,:ls_labid,:ll_lsid,:ls_div,:ls_emptype;
		  
  loop;
close c1;  
end if;	
if dw_1.rowcount() = 0 then
	messagebox('Warning!','None Of The Labours Have Worked Upto Minimum Working Days ('+string(ll_mworkdays) +'), Please Check !!!')
	return 1
end if
dw_1.setfocus()
dw_1.scrolltorow(1)
dw_1.setcolumn('lwaw_advance')
lb_neworder = true
lb_query = false
setpointer(arrow!)
end event

type cb_3 from commandbutton within w_gtelaf031
integer x = 2103
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
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
			dw_1.deleterow(ll_ctr)
		end if
	next
	ld_dtfr = date(left(trim(ddlb_1.text),10))
	ld_dtto = date(mid(trim(ddlb_1.text),12,10))

	update fb_labourwagadvweek set lwaw_paidflag = '1' where lwaw_startdate = :ld_dtfr and lwaw_enddate = :ld_dtto;
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error : During Paid Flag Updation ',sqlca.sqlerrtext); 
		rollback using sqlca; 
		return 1; 
	end if
	
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

type cb_4 from commandbutton within w_gtelaf031
integer x = 2373
integer y = 12
integer width = 265
integer height = 100
integer taborder = 70
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

type dw_1 from datawindow within w_gtelaf031
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 27
integer y = 120
integer width = 3611
integer height = 1916
string dataobject = "dw_gtelaf031"
boolean vscrollbar = true
end type

event itemchanged;cb_3.enabled = true
end event

type ddlb_1 from dropdownlistbox within w_gtelaf031
integer x = 480
integer y = 16
integer width = 1088
integer height = 608
integer taborder = 20
boolean bringtotop = true
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

