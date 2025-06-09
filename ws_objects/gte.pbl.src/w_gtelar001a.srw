$PBExportHeader$w_gtelar001a.srw
forward
global type w_gtelar001a from window
end type
type dw_1 from datawindow within w_gtelar001a
end type
end forward

global type w_gtelar001a from window
integer width = 3072
integer height = 2368
boolean titlebar = true
string title = "(Gtelar001a) - Sheet Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_1 dw_1
end type
global w_gtelar001a w_gtelar001a

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
	case "PDF"
			this.dw_1.saveas("C:\reports\Gtelar001.pdf",pdf!,true)
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

on w_gtelar001a.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_gtelar001a.destroy
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
Send(Handle(dw_1), 274, 61488, 0)
dw_1.retrieve()
if dw_1.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if
end event

type dw_1 from datawindow within w_gtelar001a
integer y = 4
integer width = 3031
integer height = 2260
string dataobject = "dw_gtelar001a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

