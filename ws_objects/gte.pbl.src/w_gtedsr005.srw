$PBExportHeader$w_gtedsr005.srw
forward
global type w_gtedsr005 from window
end type
type ddlb_1 from dropdownlistbox within w_gtedsr005
end type
type cb_1 from commandbutton within w_gtedsr005
end type
type cb_2 from commandbutton within w_gtedsr005
end type
type st_2 from statictext within w_gtedsr005
end type
type dw_1 from datawindow within w_gtedsr005
end type
end forward

global type w_gtedsr005 from window
integer width = 3621
integer height = 2548
boolean titlebar = true
string title = "(Gtedsr005) - Transporter Letter"
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
global w_gtedsr005 w_gtedsr005

type variables
string ls_invno, ls_dt, ls_gpno
datetime ld_siid
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

on w_gtedsr005.create
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

on w_gtedsr005.destroy
destroy(this.ddlb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

declare c1 cursor for
select distinct SI_CENTRALEXCISENO||' ('||to_char(SI_DATE,'dd/mm/yyyy')||')',SI_DATE from  fb_saleinvoice where to_char(SI_DATE,'YYYY') = to_char(sysdate,'YYYY') order by SI_DATE desc;
//select distinct SI_CENTRALEXCISENO from  fb_saleinvoice where to_char(SI_DATE,'YYYY') = to_char(sysdate,'YYYY') order by to_number(SI_CENTRALEXCISENO) desc ;
//order by to_number(SI_CENTRALEXCISENO) desc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_invno, :ld_siid;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_invno))
		fetch c1 into :ls_invno, :ld_siid;
	loop
	close c1;
end if

end event

type ddlb_1 from dropdownlistbox within w_gtedsr005
integer x = 389
integer y = 16
integer width = 887
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

type cb_1 from commandbutton within w_gtedsr005
integer x = 1353
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

if isnull(ddlb_1.text) then
	messagebox('Warning!','Please Select A Invoice No. !!!')
	return 1
end if

ls_dt = left(right(ddlb_1.text,11),10)
ls_gpno = mid(ddlb_1.text,1,(len(ddlb_1.text) - 12))
dw_1.retrieve(ls_gpno,ls_dt,gs_garden_snm)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtedsr005
integer x = 1618
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

type st_2 from statictext within w_gtedsr005
integer x = 9
integer y = 28
integer width = 357
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Gate Pass No."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtedsr005
integer y = 120
integer width = 3570
integer height = 2308
string dataobject = "dw_gtedsr005"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

