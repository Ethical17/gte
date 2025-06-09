$PBExportHeader$w_gtelar022.srw
forward
global type w_gtelar022 from window
end type
type ddlb_1 from dropdownlistbox within w_gtelar022
end type
type cb_1 from commandbutton within w_gtelar022
end type
type cb_2 from commandbutton within w_gtelar022
end type
type st_4 from statictext within w_gtelar022
end type
type st_2 from statictext within w_gtelar022
end type
type sle_2 from singlelineedit within w_gtelar022
end type
type dw_1 from datawindow within w_gtelar022
end type
end forward

global type w_gtelar022 from window
integer width = 4622
integer height = 2580
boolean titlebar = true
string title = "(Gtelar022) - Form 6A - Detail"
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
st_4 st_4
st_2 st_2
sle_2 sle_2
dw_1 dw_1
end type
global w_gtelar022 w_gtelar022

type variables
long ll_year
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

event open;dw_1.settransobject(sqlca)
//dw_1.retrieve(long(gs_as_on_dt),long(left(gs_rep_ty,1)),gs_emp_opt)

declare c1 cursor for
select distinct nvl(LPW_YEAR,0)  lyear from FB_LABOURPFWEEK order by 1 desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ll_year;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ll_year))
		fetch c1 into :ll_year;
	loop
	close c1;
end if

end event

on w_gtelar022.create
this.ddlb_1=create ddlb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_4=create st_4
this.st_2=create st_2
this.sle_2=create sle_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.cb_1,&
this.cb_2,&
this.st_4,&
this.st_2,&
this.sle_2,&
this.dw_1}
end on

on w_gtelar022.destroy
destroy(this.ddlb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.dw_1)
end on

type ddlb_1 from dropdownlistbox within w_gtelar022
integer x = 654
integer y = 28
integer width = 384
integer height = 968
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
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_gtelar022
integer x = 1330
integer y = 20
integer width = 279
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_gtelar022
integer x = 1047
integer y = 20
integer width = 279
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.show()
setpointer(hourglass!)
if isnull(ddlb_1.text) or len(ddlb_1.text) <=0 then
	messagebox('Error','Please Enter Current Year as (YYYY)')
	return 1
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(long(trim(ddlb_1.text)))
setpointer(Arrow!)
end event

type st_4 from statictext within w_gtelar022
integer x = 37
integer y = 68
integer width = 603
integer height = 60
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "(2008 Means Mar-07 to Feb-08)"
boolean focusrectangle = false
end type

type st_2 from statictext within w_gtelar022
integer x = 133
integer y = 20
integer width = 347
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year(YYYY)"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_gtelar022
integer x = 654
integer y = 28
integer width = 251
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_gtelar022
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 32
integer y = 128
integer width = 4549
integer height = 2344
integer taborder = 10
string title = "none"
string dataobject = "dw_gtelar022"
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

