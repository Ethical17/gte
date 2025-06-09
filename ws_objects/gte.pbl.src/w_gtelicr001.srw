$PBExportHeader$w_gtelicr001.srw
forward
global type w_gtelicr001 from window
end type
type st_4 from statictext within w_gtelicr001
end type
type rb_2 from radiobutton within w_gtelicr001
end type
type st_1 from statictext within w_gtelicr001
end type
type rb_1 from radiobutton within w_gtelicr001
end type
type st_2 from statictext within w_gtelicr001
end type
type dp_2 from datepicker within w_gtelicr001
end type
type dp_1 from datepicker within w_gtelicr001
end type
type st_3 from statictext within w_gtelicr001
end type
type cb_2 from commandbutton within w_gtelicr001
end type
type cb_4 from commandbutton within w_gtelicr001
end type
type dw_1 from datawindow within w_gtelicr001
end type
type gb_1 from groupbox within w_gtelicr001
end type
end forward

global type w_gtelicr001 from window
integer width = 4347
integer height = 2736
boolean titlebar = true
string title = "(w_gtelicr001) License and Certificate Detail"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_4 st_4
rb_2 rb_2
st_1 st_1
rb_1 rb_1
st_2 st_2
dp_2 dp_2
dp_1 dp_1
st_3 st_3
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
gb_1 gb_1
end type
global w_gtelicr001 w_gtelicr001

type variables
boolean lb_neworder, lb_query
string ls_rundt,ls_temp,ls_emp,ls_flag
n_cst_powerfilter iu_powerfilter 
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtelicr001.create
this.st_4=create st_4
this.rb_2=create rb_2
this.st_1=create st_1
this.rb_1=create rb_1
this.st_2=create st_2
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.rb_2,&
this.st_1,&
this.rb_1,&
this.st_2,&
this.dp_2,&
this.dp_1,&
this.st_3,&
this.cb_2,&
this.cb_4,&
this.dw_1,&
this.gb_1}
end on

on w_gtelicr001.destroy
destroy(this.st_4)
destroy(this.rb_2)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

rb_2.checked = true
st_3.text = "Expiry Date Range: "
ls_flag = 'E'



lb_neworder = false

setpointer(hourglass!)

setpointer(arrow!)



end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_4 from statictext within w_gtelicr001
integer x = 581
integer y = 152
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date:"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gtelicr001
integer x = 1097
integer y = 32
integer width = 338
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expiry Date"
end type

event clicked;st_3.text = "Expiry Date Range"
ls_flag = 'E'
end event

type st_1 from statictext within w_gtelicr001
integer x = 37
integer y = 32
integer width = 631
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Categorize on basis of:"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_gtelicr001
integer x = 731
integer y = 32
integer width = 302
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Issue Date"
end type

event clicked;st_3.text = "Issue Date Range"	
ls_flag = 'I'
end event

type st_2 from statictext within w_gtelicr001
integer x = 1275
integer y = 156
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gtelicr001
integer x = 1527
integer y = 140
integer width = 370
integer height = 100
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-08-21"), Time("14:20:48.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gtelicr001
integer x = 891
integer y = 140
integer width = 370
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2018-08-21"), Time("14:20:48.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_3 from statictext within w_gtelicr001
integer x = 32
integer y = 152
integer width = 535
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Expiry Date Range: "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelicr001
integer x = 1911
integer y = 140
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)


if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if


if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!',' "From Date" Should Be  Less Than Or Equal To "To Date" !!!')
	return 1
end if

setpointer(hourglass!)

dw_1.retrieve(gs_user,gs_garden_snm,dp_1.text,dp_2.text,ls_flag)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
setpointer(arrow!)
end event

type cb_4 from commandbutton within w_gtelicr001
integer x = 2181
integer y = 140
integer width = 265
integer height = 100
integer taborder = 60
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

type dw_1 from datawindow within w_gtelicr001
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 248
integer width = 4256
integer height = 1936
string dataobject = "dw_gtelicr001"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type gb_1 from groupbox within w_gtelicr001
integer x = 658
integer width = 878
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

