$PBExportHeader$w_gteflr014.srw
forward
global type w_gteflr014 from window
end type
type dw_1 from datawindow within w_gteflr014
end type
end forward

global type w_gteflr014 from window
integer width = 3762
integer height = 2328
boolean titlebar = true
string title = "(Gteflr014) - Area Distribution"
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
global w_gteflr014 w_gteflr014

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

on w_gteflr014.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_gteflr014.destroy
destroy(this.dw_1)
end on

event open;double ld_area
dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)

select sum(nvl(SECTION_AREA,0)) into :ld_area from fb_section;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Area',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if


if isnull(ld_area) then ld_area = 0

dw_1.retrieve(ld_area,gs_supid)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if
end event

type dw_1 from datawindow within w_gteflr014
event ue_leftbuttonup pbm_dwnlbuttonup
integer width = 3662
integer height = 2036
string dataobject = "dw_gteflr014"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
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

