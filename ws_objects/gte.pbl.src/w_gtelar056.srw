$PBExportHeader$w_gtelar056.srw
forward
global type w_gtelar056 from window
end type
type st_3 from statictext within w_gtelar056
end type
type dp_1 from datepicker within w_gtelar056
end type
type st_1 from statictext within w_gtelar056
end type
type dp_2 from datepicker within w_gtelar056
end type
type cb_1 from commandbutton within w_gtelar056
end type
type cb_2 from commandbutton within w_gtelar056
end type
type st_2 from statictext within w_gtelar056
end type
type dw_1 from datawindow within w_gtelar056
end type
type ddlb_2 from dropdownlistbox within w_gtelar056
end type
end forward

global type w_gtelar056 from window
integer width = 6021
integer height = 2604
boolean titlebar = true
string title = "(Gtelar056) - Deduction Pay Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
dp_1 dp_1
st_1 st_1
dp_2 dp_2
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
ddlb_2 ddlb_2
end type
global w_gtelar056 w_gtelar056

type variables
long ll_pbno
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

on w_gtelar056.create
this.st_3=create st_3
this.dp_1=create dp_1
this.st_1=create st_1
this.dp_2=create dp_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.ddlb_2=create ddlb_2
this.Control[]={this.st_3,&
this.dp_1,&
this.st_1,&
this.dp_2,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1,&
this.ddlb_2}
end on

on w_gtelar056.destroy
destroy(this.st_3)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.dp_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.ddlb_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text = '01'+right(string(today(),'dd/mm/yyyy'),8)
setpointer(hourglass!)

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

setpointer(Arrow!)
end event

type st_3 from statictext within w_gtelar056
integer x = 23
integer y = 32
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelar056
integer x = 681
integer y = 20
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-08-28"), Time("17:57:37.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar056
integer x = 1065
integer y = 32
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelar056
integer x = 1307
integer y = 20
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2020-08-28"), Time("17:57:36.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_1 from commandbutton within w_gtelar056
integer x = 2432
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

event clicked;string ls_fr_dt, ls_to_dt
dw_1.settransobject(sqlca)

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if

ls_fr_dt = dp_1.text
ls_to_dt = dp_2.text

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy');
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting No Of Labours',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid From Date, Should Be Start Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_ENDDATE) =  to_date(:ls_to_dt,'dd/mm/yyyy');
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting No Of Labours',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid To Date, Should Be End Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

setpointer(hourglass!)

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




dw_1.retrieve(ls_fr_dt,ddlb_2.text,ls_temp,gs_garden_snm,gs_garden_state,ls_to_dt)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_gtelar056
integer x = 2697
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

type st_2 from statictext within w_gtelar056
integer x = 1746
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

type dw_1 from datawindow within w_gtelar056
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 5888
integer height = 2372
string dataobject = "dw_gtelar056"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type ddlb_2 from dropdownlistbox within w_gtelar056
integer x = 2094
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

