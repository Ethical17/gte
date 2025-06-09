$PBExportHeader$w_gtehrr006.srw
forward
global type w_gtehrr006 from window
end type
type em_1 from editmask within w_gtehrr006
end type
type st_2 from statictext within w_gtehrr006
end type
type ddlb_1 from dropdownlistbox within w_gtehrr006
end type
type st_1 from statictext within w_gtehrr006
end type
type cb_1 from commandbutton within w_gtehrr006
end type
type cb_2 from commandbutton within w_gtehrr006
end type
type dw_1 from datawindow within w_gtehrr006
end type
end forward

global type w_gtehrr006 from window
integer width = 3735
integer height = 2252
boolean titlebar = true
string title = "(Gtehrr006) - Advance Ledger"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_2 st_2
ddlb_1 ddlb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtehrr006 w_gtehrr006

type variables
n_cst_powerfilter iu_powerfilter
long ll_yrmn
end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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

on w_gtehrr006.create
this.em_1=create em_1
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_2,&
this.ddlb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtehrr006.destroy
destroy(this.em_1)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
em_1.text = string(today(),'YYYY-MM')
end event

type em_1 from editmask within w_gtehrr006
integer x = 352
integer y = 16
integer width = 279
integer height = 88
integer taborder = 10
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

type st_2 from statictext within w_gtehrr006
integer x = 9
integer y = 24
integer width = 325
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

type ddlb_1 from dropdownlistbox within w_gtehrr006
integer x = 1129
integer y = 20
integer width = 677
integer height = 508
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL - ALL","EXE - Executive","ST  - Staff","SS  - Sub Staff"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gtehrr006
integer x = 722
integer y = 36
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtehrr006
integer x = 1851
integer y = 16
integer width = 265
integer height = 100
integer taborder = 20
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

if isnull(em_1.text) or len(em_1.text) <= 0 or trim(em_1.text) = '0000-00' then
	messagebox('Error','Please Enter Current Year Month as (YYYYMM)')
	return 1
end if

ll_yrmn = long(left(em_1.text,4)) * 100 + long(right(em_1.text,2))

if isnull(ddlb_1.text) or len(trim(ddlb_1.text)) = 0 then
	messagebox('Warning','Please Select Employee Type...!!')
	return 1
end if	

dw_1.retrieve(left(trim(ddlb_1.text),3), ll_yrmn)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
setpointer(arrow!)
end event

type cb_2 from commandbutton within w_gtehrr006
integer x = 2117
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

type dw_1 from datawindow within w_gtehrr006
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 3666
integer height = 2004
string dataobject = "dw_gtehrr006"
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

