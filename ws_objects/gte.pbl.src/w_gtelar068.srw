$PBExportHeader$w_gtelar068.srw
forward
global type w_gtelar068 from window
end type
type dw_2 from datawindow within w_gtelar068
end type
type cb_3 from commandbutton within w_gtelar068
end type
type em_1 from editmask within w_gtelar068
end type
type st_4 from statictext within w_gtelar068
end type
type st_2 from statictext within w_gtelar068
end type
type dp_2 from datepicker within w_gtelar068
end type
type st_1 from statictext within w_gtelar068
end type
type dp_1 from datepicker within w_gtelar068
end type
type st_3 from statictext within w_gtelar068
end type
type cb_2 from commandbutton within w_gtelar068
end type
type cb_1 from commandbutton within w_gtelar068
end type
type dw_1 from datawindow within w_gtelar068
end type
end forward

global type w_gtelar068 from window
integer width = 7095
integer height = 2700
boolean titlebar = true
string title = "(Gtelar068) - PF Form 5"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_2 dw_2
cb_3 cb_3
em_1 em_1
st_4 st_4
st_2 st_2
dp_2 dp_2
st_1 st_1
dp_1 dp_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelar068 w_gtelar068

type variables
long ll_yrmn, ll_ctr, ll_pfno, ll_year_mon
string ls_temp,ls_gpf,ls_division, ls_emp_id, ls_empname, ls_pf_type, ls_emp_name, ls_emp_type, ls_remarks, ls_settlement_status, ls_year
double ld_slno, ld_years_bf, ld_incoming, ld_contribution, ld_interest, ld_advance_refund, ld_advance_made, ld_carried_over, ld_settlement, ld_outgoing_transfer, ld_lapsed_amount, ld_carried_forward
n_cst_powerfilter iu_powerfilter
datetime ld_frdt, ld_todt, ld_settlement_dt
double ll_ctot_pf, ll_adv_made, ll_adv_ref, ll_adv_int
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

on w_gtelar068.create
this.dw_2=create dw_2
this.cb_3=create cb_3
this.em_1=create em_1
this.st_4=create st_4
this.st_2=create st_2
this.dp_2=create dp_2
this.st_1=create st_1
this.dp_1=create dp_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.cb_3,&
this.em_1,&
this.st_4,&
this.st_2,&
this.dp_2,&
this.st_1,&
this.dp_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelar068.destroy
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.em_1)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_heading
select nvl(UNIT_PFACCD,'x') into :ls_gpf from fb_gardenmaster where UNIT_SHORTNAME = :gs_garden_snm; 
if sqlca.sqlcode = -1 then
	messagebox('Error', 'Error occured while selecting PF Code')
	return 1
end if

ls_heading = gs_garden_nm + ' ( P.F. Code - '+ls_gpf+' )'

dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+ls_heading+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

end event

type dw_2 from datawindow within w_gtelar068
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 144
integer width = 5563
integer height = 2408
integer taborder = 50
string dataobject = "dw_gtelar068_forinsert"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type cb_3 from commandbutton within w_gtelar068
integer x = 2633
integer y = 20
integer width = 535
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Confirm and Save"
end type

event clicked;string ls_gapf
long ll_yr

dw_2.settransobject(sqlca)

setpointer(hourglass!)

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

if isnull(em_1.text) or em_1.text = '0000' or len(em_1.text) = 0 then
	messagebox('Alert!','Please Enter Valid Year !!!')
	return 1
end if


ld_frdt = dp_1.value
ld_todt = dp_2.value

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_STARTDATE) = trunc(:ld_frdt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Fetching Payment Period',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid From Date, Should Be Start Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_ENDDATE) = trunc(:ld_todt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Fetching Payment Period',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid To Date, Should Be End Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

dw_2.retrieve(dp_1.text,dp_2.text,long(em_1.text))

if dw_2.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)

select distinct 'x' into :ls_temp  from fb_pfform5 where trunc(:ld_frdt) between  trunc(frdt) and trunc(todt) or trunc(:ld_todt) between  trunc(frdt) and trunc(todt);
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking saved records : '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	messagebox('Warning','Data already exists for period between these from and to date')
	return 1
end if


ll_yr = long(em_1.text)
select distinct 'x' into :ls_temp  from fb_pfform5 where year = :ll_yr ;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking saved records : '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0  then
	messagebox('Warning','Data already exists for this Year ')
	return 1
end if


IF MessageBox("Alert", 'Are you sure that this data has been approved and you want to save this?' ,Exclamation!, YesNo!, 2) = 1 THEN
		for ll_ctr = 1 to dw_2.rowcount()
			ls_pf_type  = dw_2.getitemstring(ll_ctr,'pf_type')
			ld_slno = dw_2.getitemnumber(ll_ctr,'slno')
			ls_emp_name = dw_2.getitemstring(ll_ctr,'emp_name')
			ls_emp_type = dw_2.getitemstring(ll_ctr,'emp_type')
			ll_pfno = dw_2.getitemnumber(ll_ctr,'pf_no')
			ld_years_bf = dw_2.getitemnumber(ll_ctr,'years_bf')
			ld_incoming = dw_2.getitemnumber(ll_ctr,'incoming_transfer')
			ld_contribution = dw_2.getitemnumber(ll_ctr,'contribution')
			ld_interest = dw_2.getitemnumber(ll_ctr,'interest')
			ld_advance_refund = dw_2.getitemnumber(ll_ctr,'advance_refund')
			ld_advance_made = dw_2.getitemnumber(ll_ctr,'advance_made')
			ld_carried_over = dw_2.getitemnumber(ll_ctr,'carried_over')
			ld_settlement = dw_2.getitemnumber(ll_ctr,'settlement')
			ld_outgoing_transfer = dw_2.getitemnumber(ll_ctr,'outgoing_transfer')
			ld_lapsed_amount = dw_2.getitemnumber(ll_ctr,'lapsed_amount')
			ld_carried_forward = dw_2.getitemnumber(ll_ctr,'carried_forward')
			ls_remarks = dw_2.getitemstring(ll_ctr,'remarks')
			ls_settlement_status = dw_2.getitemstring(ll_ctr,'settlement_status')
			ld_settlement_dt = dw_2.getitemdatetime(ll_ctr,'settlement_dt')
			ls_year = dw_2.getitemstring(ll_ctr,'year')

	
			insert into  fb_pfform5 (EMP_TYPE, SL_NO, EMP_NAME, PF_NO, YEARS_BF, INCOMING_TRANSFER, CONT_THIS_YR, INTEREST, ADVANCE_REFUNDED, ADVANCE_MADE, CARRIED_OVER, SETTLEMENT_AMT, OUTGOING_TRANSFER, LAPSED_AMT, CARRIED_FORWARD, REMARKS, SETTLEMENT_STATUS, SETTLEMENT_DATE, YEAR, TYPE, ENTRY_BY, ENTRY_DT, FRDT, TODT)
			values(upper(:ls_pf_type), :ld_slno, :ls_emp_name, :ll_pfno, :ld_years_bf, :ld_incoming, :ld_contribution, :ld_interest, :ld_advance_refund, :ld_advance_made, :ld_carried_over, :ld_settlement, :ld_outgoing_transfer, :ld_lapsed_amount, :ld_carried_forward, :ls_remarks, :ls_settlement_status, :ld_settlement_dt, :ls_year, :ls_emp_type, :gs_user, sysdate, trunc(:ld_frdt), trunc(:ld_todt));
			
			if sqlca.sqlcode = -1 then
				messagebox('Error','Error occured while inserting records : '+sqlca.sqlerrtext)
				rollback;
				return 1
			end if 
		next
		messagebox('Message','Records saved successfully')
		commit using sqlca;
else
	return 1
end if
	


setpointer(arrow!)




end event

type em_1 from editmask within w_gtelar068
integer x = 1865
integer y = 24
integer width = 215
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "0000"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
end type

type st_4 from statictext within w_gtelar068
integer x = 1701
integer y = 36
integer width = 192
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year : "
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtelar068
boolean visible = false
integer x = 1696
integer y = 32
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Emp Status"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelar068
integer x = 1307
integer y = 20
integer width = 370
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-05-09"), Time("15:29:02.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar068
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

type dp_1 from datepicker within w_gtelar068
integer x = 681
integer y = 20
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-05-09"), Time("15:29:02.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelar068
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

type cb_2 from commandbutton within w_gtelar068
integer x = 2368
integer y = 20
integer width = 265
integer height = 100
integer taborder = 70
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

type cb_1 from commandbutton within w_gtelar068
integer x = 2103
integer y = 20
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;string ls_gapf

dw_1.settransobject(sqlca)

setpointer(hourglass!)

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

if isnull(em_1.text) or em_1.text = '0000' or len(em_1.text) = 0 then
	messagebox('Alert!','Please Enter Year !!!')
	return 1
end if


ld_frdt = dp_1.value
ld_todt = dp_2.value

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_STARTDATE) = trunc(:ld_frdt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Fetching Payment Period',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid From Date, Should Be Start Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

select distinct 'x' into :ls_temp from FB_LABOURWAGESWEEK where trunc(LWW_ENDDATE) = trunc(:ld_todt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Fetching Payment Period',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning !','Invalid To Date, Should Be End Date of Week / Fortnight, Please Check !!!')
	return 1
end if	

dw_1.retrieve(dp_1.text,dp_2.text,long(em_1.text))
//dw_1.setfilter(" years_bf > 0 or  incoming_transfer > 0 or  contribution > 0 or  interest > 0 or  advance_refund > 0 or  advance_made > 0 or  carried_over > 0 or   settlement > 0 or outgoing_transfer  > 0 or  lapsed_amount > 0 or  carried_forward  > 0 ")
dw_1.insertrow(0)


if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)


end event

type dw_1 from datawindow within w_gtelar068
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 5563
integer height = 2408
string dataobject = "dw_gtelar068"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

