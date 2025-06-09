$PBExportHeader$w_gtehrr020.srw
forward
global type w_gtehrr020 from window
end type
type st_3 from statictext within w_gtehrr020
end type
type cb_2 from commandbutton within w_gtehrr020
end type
type cb_1 from commandbutton within w_gtehrr020
end type
type ddlb_1 from dropdownlistbox within w_gtehrr020
end type
type dw_1 from datawindow within w_gtehrr020
end type
end forward

global type w_gtehrr020 from window
integer width = 3790
integer height = 3404
boolean titlebar = true
string title = "(w_gtehrr020) - Ration Entitlement Statement"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtehrr020 w_gtehrr020

type variables
string ls_LWW_ID, ls_division, ls_emp_type 
long ll_si,ll_pbno
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
//	case "SFILTER"
//			iu_powerfilter.checked = NOT iu_powerfilter.checked
//			iu_powerfilter.event ue_clicked()
//			m_main.m_file.m_filter.checked = iu_powerfilter.checked			
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

on w_gtehrr020.create
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtehrr020.destroy
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)



setpointer(hourglass!)
string ls_dt, ls_period

ddlb_1.reset()

declare c1 cursor for
select distinct (to_char(RPFW_STARTDATE,'dd/mm/yyyy')||' ('||RPFW_ID||')') lww_id,RPFW_STARTDATE
  from fb_rationperiodforweek where RPFW_CALFLAG = '1'  and RPFW_EMP_TYPE= 'LP'
 order by RPFW_STARTDATE desc;

//select RPFW_ID,to_char(RPFW_ENDDATE,'dd/mm/yyyy') into :ls_lrw_id,:ls_to_dt
//   from fb_rationperiodforweek   where trunc(RPFW_STARTDATE) = to_date(:ls_fr_dt,'dd/mm/yyyy');
// order by rpfw_startdate desc

open c1;
IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_period,:ls_dt;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_period)
		setnull(ls_period);setnull(ls_dt)
		fetch c1 into :ls_period,:ls_dt;
	loop
close c1;
end if



setpointer(arrow!)
end event

type st_3 from statictext within w_gtehrr020
integer x = 18
integer y = 28
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ration Period"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtehrr020
integer x = 3305
integer y = 12
integer width = 256
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gtehrr020
integer x = 3049
integer y = 12
integer width = 256
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;
if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select Ration Period !!!')
	return 
end if

dw_1.settransobject(sqlca)
dw_1.reset()
dw_1.retrieve(left(right(ddlb_1.text,15),14))

if dw_1.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if	

end event

type ddlb_1 from dropdownlistbox within w_gtehrr020
integer x = 366
integer y = 16
integer width = 773
integer height = 1104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_gtehrr020
integer x = 5
integer y = 120
integer width = 3552
integer height = 1924
string dataobject = "dw_gtehrr020"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

