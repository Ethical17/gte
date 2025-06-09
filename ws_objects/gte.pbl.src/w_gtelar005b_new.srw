$PBExportHeader$w_gtelar005b_new.srw
forward
global type w_gtelar005b_new from window
end type
type st_1 from statictext within w_gtelar005b_new
end type
type cb_1 from commandbutton within w_gtelar005b_new
end type
type cb_2 from commandbutton within w_gtelar005b_new
end type
type st_2 from statictext within w_gtelar005b_new
end type
type dw_1 from datawindow within w_gtelar005b_new
end type
type ddlb_1 from dropdownlistbox within w_gtelar005b_new
end type
type ddlb_2 from dropdownlistbox within w_gtelar005b_new
end type
end forward

global type w_gtelar005b_new from window
integer width = 3867
integer height = 2604
boolean titlebar = true
string title = "(Gtelar005n) - Wages Pay Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
ddlb_1 ddlb_1
ddlb_2 ddlb_2
end type
global w_gtelar005b_new w_gtelar005b_new

type variables
long ll_pbno,ll_user_level
string ls_temp, ls_dt,ls_labid,ls_measure,ls_measure1,ls_first_read,ls_old_labour
datetime ld_dt
n_cst_powerfilter iu_powerfilter
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
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked			
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

on w_gtelar005b_new.create
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
this.Control[]={this.st_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1,&
this.ddlb_1,&
this.ddlb_2}
end on

on w_gtelar005b_new.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)
setpointer(hourglass!)
declare c1 cursor for
select distinct to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy'),LWW_STARTDATE
  from FB_LABOURWEEKLYWAGES a, fb_LABOURWAGESWEEK b
  where a.LWW_ID=b.LWW_ID
order by LWW_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ld_dt;
	loop
	close c1;
end if

ddlb_2.additem('ALL')

declare c2 cursor for
select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b where a.LWW_ID = b.LWW_ID order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'


select pfa_permission into :ll_user_level from fb_pf_access where pfa_user_id=:gs_user and nvl(pfa_active,'N')='Y';
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Access',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning : NO access Provided',sqlca.sqlerrtext)
	return 1
end if	

setpointer(Arrow!)
end event

type st_1 from statictext within w_gtelar005b_new
integer x = 9
integer y = 32
integer width = 475
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start && End Date : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar005b_new
integer x = 2368
integer y = 16
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text)  then
	messagebox('Warning','Please Enter Week Start Date !!!')
	return 
end if

string ls_fr_dt

ls_fr_dt = left(ddlb_1.text,10)

select distinct AI_PFELIGIBLE into :ls_temp
from fb_attendanceincentive where  to_date(:ls_fr_dt,'dd/mm/yyyy') between trunc(AI_FROMDT) and nvl(AI_TODT,trunc(sysdate));

EXECUTE immediate "truncate table fb_temp_dailykgoutsider";

//EXECUTE immediate "create table fb_temp_dailykgoutsider( dk_labourid varchar2(25),  dk_measure  varchar2(100))";

setnull(ls_labid); setnull(ls_measure); setnull(ls_measure1); 
ls_first_read = 'Y'	 

declare c1 cursor for
select LABOUR_ID, to_char(LDA_DATE,'DD')||'-'||nvl(LDA_MFJ_COUNT1,0) measure from fb_labourdailyattendance a,FB_LABOURWAGESWEEK b, fb_employee 
where a.LWW_ID = b.LWW_ID and a.labour_id = emp_id and emp_type = 'LO' and trunc(b.LWW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy') and KAMSUB_ID <> 'ESUB0258' and nvl(LDA_MFJ_COUNT1,0) > 0 
order by LABOUR_ID,to_char(LDA_DATE,'DD');
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_labid,:ls_measure;
	
	do while sqlca.sqlcode <> 100
				
		if ls_first_read = 'Y'  then
			ls_old_labour = ls_labid
		     ls_first_read = 'N'
		end if
		if ls_old_labour = ls_labid then
		   if isnull(ls_measure1) or len(ls_measure1) = 0 then
				ls_measure1 = ls_measure
		   else
		   		ls_measure1 = ls_measure1 + ' '+ ls_measure
		   end if
		end if
		
		setnull(ls_labid); setnull(ls_measure); 
		
		fetch c1 into :ls_labid,:ls_measure;
		if  ls_old_labour <> ls_labid then
			insert into fb_temp_dailykgoutsider values(:ls_old_labour,:ls_measure1);
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Insert',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if	
			ls_old_labour = ls_labid
			setnull(ls_measure1)
		end if
	loop
	close c1;
	insert into fb_temp_dailykgoutsider values(:ls_labid,:ls_measure1);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Insert',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if	
	
end if
commit using sqlca;


if ll_user_level<>0 then
	dw_1.retrieve(ls_fr_dt,ddlb_2.text,ls_temp,gs_garden_snm,gs_garden_state,ll_user_level)
else
	messagebox('Information!','No Access !!!')
	return 1
end if
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar005b_new
integer x = 2633
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type st_2 from statictext within w_gtelar005b_new
integer x = 1682
integer y = 32
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar005b_new
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3826
integer height = 2372
string dataobject = "dw_gtelar005b_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type ddlb_1 from dropdownlistbox within w_gtelar005b_new
integer x = 485
integer y = 20
integer width = 1152
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

event selectionchanged;ls_dt = left(ddlb_1.text,10)
ddlb_2.reset()
ddlb_2.additem('ALL')

declare c2 cursor for
select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'
end event

type ddlb_2 from dropdownlistbox within w_gtelar005b_new
integer x = 2030
integer y = 20
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

