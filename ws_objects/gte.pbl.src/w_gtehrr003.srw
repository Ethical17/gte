$PBExportHeader$w_gtehrr003.srw
forward
global type w_gtehrr003 from window
end type
type st_1 from statictext within w_gtehrr003
end type
type st_3 from statictext within w_gtehrr003
end type
type em_1 from editmask within w_gtehrr003
end type
type cb_1 from commandbutton within w_gtehrr003
end type
type cb_2 from commandbutton within w_gtehrr003
end type
type dw_1 from datawindow within w_gtehrr003
end type
type ddlb_1 from dropdownlistbox within w_gtehrr003
end type
end forward

global type w_gtehrr003 from window
integer width = 2971
integer height = 2300
boolean titlebar = true
string title = "(Gtehrr003) - Ration Distribution"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
st_3 st_3
em_1 em_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
ddlb_1 ddlb_1
end type
global w_gtehrr003 w_gtehrr003

type variables
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

on w_gtehrr003.create
this.st_1=create st_1
this.st_3=create st_3
this.em_1=create em_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.Control[]={this.st_1,&
this.st_3,&
this.em_1,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.ddlb_1}
end on

on w_gtehrr003.destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.ddlb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

ddlb_1.text = '999'
end event

type st_1 from statictext within w_gtehrr003
integer x = 937
integer y = 32
integer width = 521
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division (999 - All) : "
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtehrr003
integer x = 9
integer y = 32
integer width = 649
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year-Month (YYYYMM) : "
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrr003
integer x = 663
integer y = 20
integer width = 242
integer height = 92
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

event modified;long ll_yrmn
string ls_field

ll_yrmn = long(em_1.text)

ddlb_1.reset()
ddlb_1.additem('999')

declare c2 cursor for
 select distinct FIELD_ID
 from FB_EMPLOYEE a, FB_EMPPAYMENT B
 where (a.EMP_ID=b.EMP_ID) and (nvl(EP_YEAR,0) * 100 + nvl(EP_MONTH,0)) =:ll_yrmn order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_field;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_field)
		fetch c2 into:ls_field;
	loop
	close c2;
end if

ddlb_1.text = '999'
end event

type cb_1 from commandbutton within w_gtehrr003
integer x = 1920
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

if em_1.text = "" or em_1.text = " " or em_1.text = '000000' then
	messagebox('Alert','Year Month Must Be Entered !!!')
	return 1
end if

if isnull(ddlb_1.text) or len(trim(ddlb_1.text)) = 0 then
	messagebox('Warning','Division Id Must Be Entered...!!')
	return 1
end if	

dw_1.retrieve(em_1.text,ddlb_1.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtehrr003
integer x = 2185
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

type dw_1 from datawindow within w_gtehrr003
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 2907
integer height = 2056
string dataobject = "dw_gtehrr003"
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

type ddlb_1 from dropdownlistbox within w_gtehrr003
integer x = 1463
integer y = 20
integer width = 411
integer height = 564
integer taborder = 30
integer textsize = -10
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

