$PBExportHeader$w_gtedsr002.srw
forward
global type w_gtedsr002 from window
end type
type cb_4 from commandbutton within w_gtedsr002
end type
type cb_3 from commandbutton within w_gtedsr002
end type
type rb_2 from radiobutton within w_gtedsr002
end type
type rb_1 from radiobutton within w_gtedsr002
end type
type ddlb_1 from dropdownlistbox within w_gtedsr002
end type
type st_1 from statictext within w_gtedsr002
end type
type cb_1 from commandbutton within w_gtedsr002
end type
type cb_2 from commandbutton within w_gtedsr002
end type
type gb_1 from groupbox within w_gtedsr002
end type
type dw_1 from datawindow within w_gtedsr002
end type
type dw_2 from datawindow within w_gtedsr002
end type
end forward

global type w_gtedsr002 from window
integer width = 4695
integer height = 2508
boolean titlebar = true
string title = "(Gtedsr002) - Gate Pass"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_3 cb_3
rb_2 rb_2
rb_1 rb_1
ddlb_1 ddlb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gtedsr002 w_gtedsr002

type variables
string ls_si
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

on w_gtedsr002.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_4,&
this.cb_3,&
this.rb_2,&
this.rb_1,&
this.ddlb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gtedsr002.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)
ddlb_1.reset()

dw_1.settransobject(sqlca)

declare c1 cursor for
select distinct SI_ID from fb_saleinvoice where SI_PRINT_DT is null order by SI_ID desc;

open c1;

if sqlca.sqlcode = -1 then
	messagebox('Error During Open Cursor C1',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	setnull(ls_si);
	fetch c1 into :ls_si ;
	
	do while sqlca.sqlcode <> 100
		
		ddlb_1.additem(ls_si)	
		setnull(ls_si);
		
		fetch c1 into:ls_si;
	loop
	close c1;
end if
setpointer(arrow!)
end event

type cb_4 from commandbutton within w_gtedsr002
integer x = 2267
integer y = 32
integer width = 297
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "IIIrd Copy"
boolean default = true
end type

event clicked;dw_1.modify("t_cc.text = 'TRIPLICATE FOR ASSESSEE'")
cb_1.enabled = true
this.enabled = false
end event

type cb_3 from commandbutton within w_gtedsr002
integer x = 1970
integer y = 32
integer width = 293
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "IInd Copy"
boolean default = true
end type

event clicked;dw_1.modify("t_cc.text = 'DUPLICATE FOR TRANSPORTER'")
cb_4.enabled = true
this.enabled = false

end event

type rb_2 from radiobutton within w_gtedsr002
integer x = 329
integer y = 52
integer width = 215
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "New"
boolean checked = true
end type

event clicked;ddlb_1.reset()

dw_1.settransobject(sqlca)

declare c1 cursor for
select distinct SI_ID from fb_saleinvoice where SI_PRINT_DT is null order by SI_ID desc;

open c1;

if sqlca.sqlcode = -1 then
	messagebox('Error During Open Cursor C1',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	setnull(ls_si);
	fetch c1 into :ls_si ;
	
	do while sqlca.sqlcode <> 100
		
		ddlb_1.additem(ls_si)	
		setnull(ls_si);
		
		fetch c1 into:ls_si;
	loop
	close c1;
end if
setpointer(arrow!)
end event

type rb_1 from radiobutton within w_gtedsr002
integer x = 64
integer y = 52
integer width = 215
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Old"
end type

event clicked;ddlb_1.reset()

dw_1.settransobject(sqlca)

declare c1 cursor for
select distinct SI_ID from fb_saleinvoice where SI_PRINT_DT is not null order by SI_ID desc;

open c1;

if sqlca.sqlcode = -1 then
	messagebox('Error During Open Cursor C1',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then
	setnull(ls_si);
	fetch c1 into :ls_si ;
	
	do while sqlca.sqlcode <> 100
		
		ddlb_1.additem(ls_si)	
		setnull(ls_si);
		
		fetch c1 into:ls_si;
	loop
	close c1;
end if
setpointer(arrow!)
end event

type ddlb_1 from dropdownlistbox within w_gtedsr002
integer x = 1042
integer y = 36
integer width = 640
integer height = 924
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

type st_1 from statictext within w_gtedsr002
integer x = 590
integer y = 48
integer width = 448
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Invoice Serial No:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtedsr002
integer x = 1701
integer y = 32
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Ist Copy"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)
string ls_ind
setpointer(hourglass!)

if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning','Please Enter Invoice Serial No !!!')
	return 
end if

if rb_2.checked then
	ls_ind = 'N'
	openwithparm(w_gtegpprintdate,ddlb_1.text)
else
	ls_ind = 'O'
end if

if rb_1.checked or Message.StringParm= 'Y' then
	dw_1.retrieve(ddlb_1.text,ls_ind)
end if
dw_1.modify("t_cc.text = 'ORIGINAL FOR BUYER'")


if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found !!!')
	return 1
end if
cb_3.enabled = true
this.enabled = false
end event

type cb_2 from commandbutton within w_gtedsr002
integer x = 2574
integer y = 32
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

type gb_1 from groupbox within w_gtedsr002
integer x = 23
integer width = 544
integer height = 140
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Invoice No."
end type

type dw_1 from datawindow within w_gtedsr002
integer y = 140
integer width = 4631
integer height = 2236
string dataobject = "dw_gtedsr002"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_gtedsr002
integer y = 144
integer width = 4613
integer height = 2036
integer taborder = 40
string dataobject = "dw_gtedsr002a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

