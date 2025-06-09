$PBExportHeader$w_gtehrr008.srw
forward
global type w_gtehrr008 from window
end type
type dw_1 from datawindow within w_gtehrr008
end type
end forward

global type w_gtehrr008 from window
integer width = 4389
integer height = 1992
boolean titlebar = true
string title = "(W_pr_p2) Promotion Letter"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_1 dw_1
end type
global w_gtehrr008 w_gtehrr008

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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

event open;send(handle(dw_1),274,61488,0)
dw_1.settransobject( sqlca)
dw_1.retrieve(gs_emp_id,gs_inc_dt)
end event

on w_gtehrr008.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_gtehrr008.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_gtehrr008
integer x = 18
integer width = 4242
integer height = 1876
integer taborder = 10
string title = "none"
string dataobject = "dw_gtehrr008"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

