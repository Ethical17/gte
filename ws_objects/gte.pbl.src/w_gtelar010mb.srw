$PBExportHeader$w_gtelar010mb.srw
forward
global type w_gtelar010mb from window
end type
type st_2 from statictext within w_gtelar010mb
end type
type st_1 from statictext within w_gtelar010mb
end type
type em_2 from editmask within w_gtelar010mb
end type
type em_1 from editmask within w_gtelar010mb
end type
type st_3 from statictext within w_gtelar010mb
end type
type cb_2 from commandbutton within w_gtelar010mb
end type
type cb_1 from commandbutton within w_gtelar010mb
end type
type ddlb_1 from dropdownlistbox within w_gtelar010mb
end type
type dw_1 from datawindow within w_gtelar010mb
end type
end forward

global type w_gtelar010mb from window
integer width = 3936
integer height = 2260
boolean titlebar = true
string title = "(Gtelar010) - Ration Distribution"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_2 st_2
st_1 st_1
em_2 em_2
em_1 em_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelar010mb w_gtelar010mb

type variables
string ls_LWW_ID 
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

on w_gtelar010mb.create
this.st_2=create st_2
this.st_1=create st_1
this.em_2=create em_2
this.em_1=create em_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.em_2,&
this.em_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelar010mb.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)

end event

type st_2 from statictext within w_gtelar010mb
integer x = 1687
integer y = 20
integer width = 110
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar010mb
integer x = 933
integer y = 16
integer width = 343
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_gtelar010mb
integer x = 1833
integer y = 12
integer width = 411
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_1 from editmask within w_gtelar010mb
integer x = 1285
integer y = 8
integer width = 384
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_3 from statictext within w_gtelar010mb
integer x = 23
integer y = 20
integer width = 233
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar010mb
integer x = 2528
integer y = 8
integer width = 256
integer height = 100
integer taborder = 40
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

type cb_1 from commandbutton within w_gtelar010mb
integer x = 2272
integer y = 8
integer width = 256
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;if isnull(em_1.text) or not isdate(em_1.text) then
	messagebox('Period From','Please Fill up the Period From Date')
	return 
end if
if isnull(em_2.text) or not isdate(em_2.text) then
	messagebox('Period From','Please Fill up the Period To Date')
	return 
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(left(ddlb_1.text,1),em_1.text,em_2.text)
if dw_1.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if
end event

type ddlb_1 from dropdownlistbox within w_gtelar010mb
integer x = 270
integer y = 16
integer width = 603
integer height = 344
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "Permanent"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Permanent","Temporary"}
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_gtelar010mb
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 3849
integer height = 1924
string dataobject = "dw_gtelar010mb"
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

