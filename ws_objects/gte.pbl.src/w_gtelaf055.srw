$PBExportHeader$w_gtelaf055.srw
forward
global type w_gtelaf055 from window
end type
type dp_2 from datepicker within w_gtelaf055
end type
type st_2 from statictext within w_gtelaf055
end type
type dp_1 from datepicker within w_gtelaf055
end type
type cb_7 from commandbutton within w_gtelaf055
end type
type cb_6 from commandbutton within w_gtelaf055
end type
type cb_5 from commandbutton within w_gtelaf055
end type
type st_1 from statictext within w_gtelaf055
end type
type cb_3 from commandbutton within w_gtelaf055
end type
type cb_2 from commandbutton within w_gtelaf055
end type
type cb_1 from commandbutton within w_gtelaf055
end type
type dw_1 from datawindow within w_gtelaf055
end type
type cb_4 from commandbutton within w_gtelaf055
end type
end forward

global type w_gtelaf055 from window
integer width = 4759
integer height = 2280
boolean titlebar = true
string title = "(w_gtelaf055) Advance During Lockdown"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
st_2 st_2
dp_1 dp_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
cb_4 cb_4
end type
global w_gtelaf055 w_gtelaf055

type variables
long ll_ctr, ll_cnt,l_ctr,ll_st_year, ll_end_year,ll_user_level
string ls_temp,ls_tmp_id,ls_last,ls_count,ls_labour_id, ls_week, ls_ldprev_id, ls_frdt, ls_todt
boolean lb_neworder, lb_query
double ld_amount
datetime ld_dt, ld_frdt, ld_todt

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
	if (isnull(dw_1.getitemstring(fl_row,'emp_id')) or  len(dw_1.getitemstring(fl_row,'emp_id'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'emp_date')) or &
		 ((isnull(dw_1.getitemnumber(fl_row,'emp_advanceamount')) or dw_1.getitemnumber(fl_row,'emp_advanceamount')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'emp_pfadvance')) or dw_1.getitemnumber(fl_row,'emp_pfadvance')=0))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Employee ID, Date, Advance Amount / PF Advance, Please Check !!!')
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
		ls_lab_id1 = dw_1.getitemstring(fl_row,'emp_id')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'emp_date')
		
		if ls_lab_id1 = fs_lab_id and ld_dt1 = fs_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf055.create
this.dp_2=create dp_2
this.st_2=create st_2
this.dp_1=create dp_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_4=create cb_4
this.Control[]={this.dp_2,&
this.st_2,&
this.dp_1,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.cb_4}
end on

on w_gtelaf055.destroy
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.dp_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_4)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if


//select to_char(lww_startdate,'dd/mm/yyyy')||' - '|| to_char(LWW_ENDDATE,'dd/mm/yyyy') || ' (' ||lww_id ||')' into :ls_temp from fb_labourwagesweek where trunc(lww_enddate) = (select trunc(lww_startdate) - 1 from fb_labourwagesweek where '25-Mar-2020' between lww_startdate and lww_enddate);
//
//if sqlca.sqlcode = -1 then
//	messagebox('Error','Error occured while fetching payment period')
//	return 1;
//elseif sqlca.sqlcode = 100 then
//	messagebox('Warning','No payment period found')
//	return 1;
//end if
//ddlb_1.additem(ls_temp)
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

type dp_2 from datepicker within w_gtelaf055
integer x = 955
integer y = 20
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-04-10"), Time("15:25:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gtelaf055
integer x = 713
integer y = 40
integer width = 265
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelaf055
integer x = 325
integer y = 20
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-04-10"), Time("15:25:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_7 from commandbutton within w_gtelaf055
integer x = 2075
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y'  then
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

type cb_6 from commandbutton within w_gtelaf055
integer x = 2633
integer y = 12
integer width = 434
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Process Advance"
end type

event clicked;select distinct 'x' into :ls_temp from fb_lockdown_adv where nvl(la_pst_ind,'N') = 'N';
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking records'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Message','No records available for processing')
	return 1
end if

setpointer(hourglass!)
declare c2 cursor for
select EMP_ID, LA_AMOUNT,la_frdt,la_todt from fb_lockdown_adv where  nvl(la_pst_ind,'N') = 'N';

open c2;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_labour_id); ld_amount = 0; setnull(ld_frdt); setnull(ld_todt)
	fetch c2 into :ls_labour_id, :ld_amount,	:ld_frdt, :ld_todt;
	do while sqlca.sqlcode <> 100 
				
		insert into fb_labouradvance (LABOUR_ID, LA_AMOUNT, LA_AMOUNTTOPAYTODATE, LA_DATE, LA_DESC, LA_PFADVANCE, LA_PFINTEREST,LA_ENTRY_BY, LA_ENTRY_DT)
		values(:ls_labour_id, :ld_amount, 0, :ld_todt, 'LOCKDOWN ADVANCE',0, 0, :gs_user, sysdate);
		
		update fb_lockdown_adv set la_pst_ind = 'Y' where emp_id = :ls_labour_id and la_frdt = :ld_frdt and la_todt = :ld_todt;
		if sqlca.sqlcode = -1 then 
			messagebox('Error','Error occured while updating records'+sqlca.sqlerrtext);
			return 1;
		end if
		
		setnull(ls_labour_id); ld_amount = 0; setnull(ld_frdt); setnull(ld_todt)
		fetch c2 into :ls_labour_id, :ld_amount,	:ld_frdt, :ld_todt;
	loop
	close c2;
end if;

commit using sqlca;
setpointer(arrow!)
messagebox('Messagebox','Advance Processed Successfully')
dw_1.reset()




end event

type cb_5 from commandbutton within w_gtelaf055
integer x = 1344
integer y = 16
integer width = 434
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Create &Advance"
end type

event clicked;ls_frdt = dp_1.text
ls_todt = dp_2.text

if isnull(ls_frdt) or isnull(ls_todt) or ls_frdt = '00/00/0000'  or ls_todt = '00/00/0000' then 
	messagebox('Warning','Kindly enter a valid From and To date !!!')
	return 1
end if;

if date(ls_frdt) > date(ls_todt) then
	messagebox('Warning','From date cannot be greater than To date')
	return 1
end if 

select distinct 'X' into :ls_temp from dual where to_date('25/03/2020','dd/mm/yyyy') <= to_date(:ls_frdt,'dd/mm/yyyy');
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while comparing From date'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','From date should be greater than or equal to 25/03/2020')
	return 1
end if

select distinct 'X' into :ls_temp from dual where to_date(:ls_todt,'dd/mm/yyyy') < trunc(sysdate);
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while comparing To date'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','To date should be less than current date')
	return 1
end if

select distinct 'X' into :ls_temp from dual where to_date(:ls_todt,'dd/mm/yyyy') - to_date(:ls_frdt,'dd/mm/yyyy') in (6,13);
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while comparing From date and To date'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','Period should be of 7 days or 14 days')
	return 1
end if

select distinct 'x' into :ls_temp from fb_lockdown_adv where to_date(:ls_frdt,'dd/mm/yyyy') between la_frdt and la_todt or to_date(:ls_todt,'dd/mm/yyyy') between la_frdt and la_todt;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while comparing From and To date against existing From and To date'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	messagebox('Warning','From date or To date should not lie between existing From date and To date')
	return 1
end if

select distinct 'x' into :ls_temp from dual where to_date(:ls_frdt,'dd/mm/yyyy') <= (select max(la_todt) from fb_lockdown_adv);
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while comparing From date against maximum To date'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	messagebox('Warning','From date should be greater than To date of all the period for which advance has been created.')
	return 1
end if


//fetching period before lockdown
select lww_id into :ls_ldprev_id from 
fb_labourwagesweek where trunc(lww_enddate) = (select trunc(lww_startdate) - 1 from fb_labourwagesweek where '25-Mar-2020' between lww_startdate and lww_enddate);
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while fetching period before lockdown'+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No period found')
	return 1
end if


setpointer(hourglass!)

insert into fb_lockdown_adv (EMP_ID, LA_WORKDAYS, LA_SICKDAYS, LA_AMOUNT, LA_ENTRY_BY, LA_ENTRY_DT, LA_PST_IND, LA_FRDT, LA_TODT)
select labour_id ,sum(decode(trim(KAMSUB_NKAMTYPE), 'SICKALLOWANCE',0,lda_status)) no_workdays, sum(decode(trim(KAMSUB_NKAMTYPE), 'SICKALLOWANCE',lda_status,0)) no_sickdays ,
(((to_date(:ls_todt,'dd/mm/yyyy') - to_date(:ls_frdt,'dd/mm/yyyy') + 1)/7) * decode(unit_shortname,'UB',400,decode(unit_state,3,350,4,500,1,500))) ,:gs_user, sysdate ,'N' , to_date(:ls_frdt,'dd/mm/yyyy'),to_date(:ls_todt,'dd/mm/yyyy')
from fb_labourdailyattendance lda ,fb_kamsubhead kam, fb_employee, fb_labourwagesweek lww, fb_gardenmaster
WHERE lda.kamsub_id = kam.kamsub_id AND lda.labour_id = emp_id and lda.lww_id = lww.lww_id AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and nvl(UNIT_ACTIVE_IND,'N') = 'Y' and lww.lww_id = :ls_ldprev_id and 
(lda.lda_wages > 0 and trim(kamsub_nkamtype) not in ('ANNUALLEAVE','MATERNITY','HOLIDAYPAY')  ) and emp_type = 'LP' 
and labour_id not in (select distinct labour_id from fb_labourdailyattendance where lda_date between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') and nvl(lda_wages,0) > 0 )
group by labour_id,unit_shortname, unit_state;

if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while inserting records - '+sqlca.sqlerrtext)
	return 1
end if

commit using sqlca;
setpointer(hourglass!)
messagebox('Message','Advance Created Successfully')
dw_1.reset()
    
end event

type st_1 from statictext within w_gtelaf055
integer x = 14
integer y = 40
integer width = 320
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date : "
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_gtelaf055
boolean visible = false
integer x = 544
integer y = 12
integer width = 265
integer height = 108
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

event clicked;//if dw_1.accepttext() = -1 then
//	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
//	return 
//end if 
//
//IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'emp_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'emp_id'))=0) THEN
//	 dw_1.deleterow(dw_1.rowcount())
//END IF
//IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
//
//	for ll_ctr = dw_1.rowcount() to 1 step -1
//		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
//			dw_1.deleterow(ll_ctr)
//		end if
//	next	
//	
//	if lb_neworder = true then
//		select nvl(MAX(transac_id),0) into :ls_last from fb_empadvance;
//		ls_last = right(ls_last,10)
//		ll_cnt = long(ls_last)
//	end if
//	
//	if dw_1.rowcount() > 0 then
//		for ll_ctr = 1 to dw_1.rowcount( ) 
//			if lb_neworder = true then
//				ll_cnt = ll_cnt + 1
//				select lpad(:ll_cnt,10,'0') into :ls_count from dual;
//				ls_tmp_id = 'TRANSAC'+ls_count
//				dw_1.setitem(ll_ctr,'transac_id',ls_tmp_id)
//			end if
//		next	
//	end if
//
//	
//	if dw_1.update(true,false) = 1 then
//		dw_1.resetupdate();
//		commit using sqlca;
//		cb_3.enabled = false
//		dw_1.reset()
//	else
//		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1
//	end if
//else
//	return
//end if 
end event

type cb_2 from commandbutton within w_gtelaf055
integer x = 1801
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
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf055
boolean visible = false
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
boolean enabled = false
string text = "&New"
end type

event clicked;//if lb_neworder = false then
//	if dw_1.modifiedcount() > 0 then
//		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
//			return
//		end if
//	end if
//	dw_1.reset()
//end if
//
//dw_1.settransobject(sqlca)
//lb_neworder = true
//lb_query = false
//
//if dw_1.rowcount() = 0 then
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'emp_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'emp_entry_dt',datetime(today()))
//	dw_1.setcolumn('field_id')
//else
//	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
//		return 1
//	END IF
//	dw_1.scrolltorow(dw_1.insertrow(0))
//	dw_1.setfocus()
//	dw_1.setitem(dw_1.getrow(),'emp_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'emp_entry_dt',datetime(today()))
//	dw_1.setcolumn('field_id')
//end if
//
//
end event

type dw_1 from datawindow within w_gtelaf055
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 136
integer width = 3675
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf055"
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
		dw_1.setitem(newrow,'emp_entry_by',gs_user)
		dw_1.setitem(newrow,'emp_entry_dt',datetime(today()))
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

event itemchanged;cb_7.enabled = true
end event

type cb_4 from commandbutton within w_gtelaf055
integer x = 2350
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

