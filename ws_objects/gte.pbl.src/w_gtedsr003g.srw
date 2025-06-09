$PBExportHeader$w_gtedsr003g.srw
forward
global type w_gtedsr003g from window
end type
type ddlb_1 from dropdownlistbox within w_gtedsr003g
end type
type cb_1 from commandbutton within w_gtedsr003g
end type
type cb_2 from commandbutton within w_gtedsr003g
end type
type st_2 from statictext within w_gtedsr003g
end type
type dw_1 from datawindow within w_gtedsr003g
end type
end forward

global type w_gtedsr003g from window
integer width = 3822
integer height = 2808
boolean titlebar = true
string title = "(Gtedsr003) - Tax Invoice"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
end type
global w_gtedsr003g w_gtedsr003g

type variables
string ls_invno
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

on w_gtedsr003g.create
this.ddlb_1=create ddlb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1}
end on

on w_gtedsr003g.destroy
destroy(this.ddlb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+upper(gs_co_name)+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

if gs_garden_snm = 'MK' then
	dw_1.modify("p_1.visible = 0")
	dw_1.modify("p_2.visible = 1")
else 
	dw_1.modify("p_1.visible = 1")
	dw_1.modify("p_2.visible = 0")
end if

declare c1 cursor for
select distinct SI_TAXINVNO from  fb_saleinvoice order by 1 desc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_invno;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_invno)
		fetch c1 into :ls_invno;
	loop
	close c1;
end if

end event

type ddlb_1 from dropdownlistbox within w_gtedsr003g
integer x = 320
integer y = 16
integer width = 581
integer height = 580
integer taborder = 20
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

type cb_1 from commandbutton within w_gtedsr003g
integer x = 919
integer y = 12
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

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Invoice No. !!!')
	return 1
end if

dw_1.retrieve(ddlb_1.text)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtedsr003g
integer x = 1184
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
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

type st_2 from statictext within w_gtedsr003g
integer x = 9
integer y = 28
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Invoice No."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtedsr003g
integer y = 116
integer width = 3785
integer height = 2580
string dataobject = "dw_gtedsr003g"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

