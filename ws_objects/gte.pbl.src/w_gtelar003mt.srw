$PBExportHeader$w_gtelar003mt.srw
forward
global type w_gtelar003mt from window
end type
type ddlb_2 from dropdownlistbox within w_gtelar003mt
end type
type cb_1 from commandbutton within w_gtelar003mt
end type
type cb_2 from commandbutton within w_gtelar003mt
end type
type st_2 from statictext within w_gtelar003mt
end type
type dw_1 from datawindow within w_gtelar003mt
end type
end forward

global type w_gtelar003mt from window
integer width = 3986
integer height = 2300
boolean titlebar = true
string title = "(Gtelar003) - Attendance Sheet"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_2 ddlb_2
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
end type
global w_gtelar003mt w_gtelar003mt

type variables
long ll_pbno
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

on w_gtelar003mt.create
this.ddlb_2=create ddlb_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_2,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1}
end on

on w_gtelar003mt.destroy
destroy(this.ddlb_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)

ddlb_2.reset()
//ddlb_2.additem('ALL')

declare c2 cursor for
select distinct ls_id from FB_laboursheet  where  ls_id is not null and nvl(LS_ACTIVE_IND,'N') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

//ddlb_2.text = 'ALL'
setpointer(arrow!)
end event

type ddlb_2 from dropdownlistbox within w_gtelar003mt
integer x = 361
integer y = 20
integer width = 325
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

type cb_1 from commandbutton within w_gtelar003mt
integer x = 695
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

if isnull(ddlb_2.text) or len(ddlb_2.text) = 0 then
	messagebox('Warning','Please Enter Pay Book No. !!!')
	return 
end if

dw_1.retrieve(long(ddlb_2.text))

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtelar003mt
integer x = 960
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
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type st_2 from statictext within w_gtelar003mt
integer x = 9
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

type dw_1 from datawindow within w_gtelar003mt
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 3950
integer height = 2056
string dataobject = "dw_gtelar003mt"
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

