$PBExportHeader$w_gtelar080.srw
forward
global type w_gtelar080 from window
end type
type st_1 from statictext within w_gtelar080
end type
type em_2 from editmask within w_gtelar080
end type
type em_1 from editmask within w_gtelar080
end type
type st_3 from statictext within w_gtelar080
end type
type cb_2 from commandbutton within w_gtelar080
end type
type cb_1 from commandbutton within w_gtelar080
end type
type dw_1 from datawindow within w_gtelar080
end type
end forward

global type w_gtelar080 from window
integer width = 2693
integer height = 2240
boolean titlebar = true
string title = "(w_gtelar080) - Mobile Attendance Status"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_2 em_2
em_1 em_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelar080 w_gtelar080

type variables
long ll_yrmn
string ls_temp
n_cst_powerfilter iu_powerfilter
datetime ld_frdt, ld_todt
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

on w_gtelar080.create
this.st_1=create st_1
this.em_2=create em_2
this.em_1=create em_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_2,&
this.em_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelar080.destroy
destroy(this.st_1)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")




end event

type st_1 from statictext within w_gtelar080
integer x = 672
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
string text = "To Date : "
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtelar080
integer x = 901
integer y = 28
integer width = 357
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
boolean dropdowncalendar = true
end type

type em_1 from editmask within w_gtelar080
integer x = 311
integer y = 28
integer width = 357
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
boolean dropdowncalendar = true
end type

type st_3 from statictext within w_gtelar080
integer x = 23
integer y = 32
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date : "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar080
integer x = 1765
integer y = 20
integer width = 265
integer height = 100
integer taborder = 20
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

type cb_1 from commandbutton within w_gtelar080
integer x = 1499
integer y = 20
integer width = 265
integer height = 100
integer taborder = 10
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

string ls_frdt,ls_todt
if isnull(em_1.text) or em_1.text='00/00/0000' then
	messagebox('Warning','Please Enter Attendance Date')
	return 
end if

if isnull(em_2.text) or em_2.text='00/00/0000' then
	messagebox('Warning','Please Enter Attendance Date')
	return 
end if

if Date(em_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','Attendance Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(em_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','Attendance Date Should Be <= Current Date  !!!')
	return 1
end if

ls_frdt=em_1.text
ls_todt=em_2.text
declare p2 procedure for up_mobile_status(:gs_unit,:ls_frdt,:ls_todt);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_mobile_status',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of vw_mobile_status',sqlca.sqlerrtext)
			return 1
		end if	


dw_1.retrieve()

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)



end event

type dw_1 from datawindow within w_gtelar080
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 2642
integer height = 1988
string dataobject = "dw_gtelar080"
boolean hscrollbar = true
boolean vscrollbar = true
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

