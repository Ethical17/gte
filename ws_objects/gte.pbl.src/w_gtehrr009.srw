$PBExportHeader$w_gtehrr009.srw
forward
global type w_gtehrr009 from window
end type
type st_3 from statictext within w_gtehrr009
end type
type em_1 from editmask within w_gtehrr009
end type
type st_1 from statictext within w_gtehrr009
end type
type ddlb_1 from dropdownlistbox within w_gtehrr009
end type
type ddlb_2 from dropdownlistbox within w_gtehrr009
end type
type cb_1 from commandbutton within w_gtehrr009
end type
type cb_2 from commandbutton within w_gtehrr009
end type
type st_2 from statictext within w_gtehrr009
end type
type dw_1 from datawindow within w_gtehrr009
end type
end forward

global type w_gtehrr009 from window
integer width = 4672
integer height = 2308
boolean titlebar = true
string title = "(Gtehrr009) - Attendance Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_3 st_3
em_1 em_1
st_1 st_1
ddlb_1 ddlb_1
ddlb_2 ddlb_2
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
end type
global w_gtehrr009 w_gtehrr009

type variables
string ls_division
n_cst_powerfilter iu_powerfilter
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

on w_gtehrr009.create
this.st_3=create st_3
this.em_1=create em_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.em_1,&
this.st_1,&
this.ddlb_1,&
this.ddlb_2,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1}
end on

on w_gtehrr009.destroy
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)

ddlb_1.reset()
//ddlb_1.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if

ddlb_2.text = 'ALL - AL'
//ddlb_1.text = 'ALL'
setpointer(arrow!)
end event

type st_3 from statictext within w_gtehrr009
integer x = 1257
integer y = 32
integer width = 622
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month (YYYY-MM)"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrr009
integer x = 1888
integer y = 28
integer width = 233
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYY-MM"
end type

type st_1 from statictext within w_gtehrr009
integer x = 791
integer y = 32
integer width = 123
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Type"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrr009
integer x = 229
integer y = 20
integer width = 549
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

type ddlb_2 from dropdownlistbox within w_gtehrr009
integer x = 914
integer y = 20
integer width = 325
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
string item[] = {"ALL - AL","Staff - ST","Sub-Staff - SS"}
end type

type cb_1 from commandbutton within w_gtehrr009
integer x = 2171
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
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Select Division !!!')
	return 
end if

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Warning','Please Select Type !!!')
	return 
end if

dw_1.retrieve(left(right(ddlb_1.text,6),5),right(ddlb_2.text,2),left(em_1.text,4),right(em_1.text,2))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtehrr009
integer x = 2437
integer y = 16
integer width = 265
integer height = 100
integer taborder = 50
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

type st_2 from statictext within w_gtehrr009
integer x = 9
integer y = 32
integer width = 242
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtehrr009
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 4599
integer height = 2056
string dataobject = "dw_gtehrr009"
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

