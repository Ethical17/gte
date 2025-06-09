$PBExportHeader$w_registered_garden.srw
forward
global type w_registered_garden from window
end type
type st_2 from statictext within w_registered_garden
end type
type st_1 from statictext within w_registered_garden
end type
type ddlb_1 from dropdownlistbox within w_registered_garden
end type
type cb_2 from commandbutton within w_registered_garden
end type
type cb_1 from commandbutton within w_registered_garden
end type
end forward

global type w_registered_garden from window
integer width = 2158
integer height = 740
boolean titlebar = true
string title = "Select Garden"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
boolean center = true
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_registered_garden w_registered_garden

on w_registered_garden.create
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.st_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1}
end on

on w_registered_garden.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;disconnect using sqlca;

end event

type st_2 from statictext within w_registered_garden
integer x = 261
integer y = 156
integer width = 1344
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Please select your garden and click Register Button"
boolean focusrectangle = false
end type

type st_1 from statictext within w_registered_garden
integer x = 507
integer y = 84
integer width = 850
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Your machine is not registered. "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_registered_garden
integer x = 146
integer y = 244
integer width = 1573
integer height = 748
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Urrunabund Tea Estate","Narayanpur Tea Estate","Shyamguri Tea Estate","Manobag Tea Estate","Manmohinipur Tea Estate","Kenduguri Tea Estate","Fulbari Tea Estate","Attabarie Tea Estate","Moran Tea Estate","Lepetkatta Tea Estate","Sepon Tea Estate","Bhuyankhat Tea Estate","Addabarie Tea Estate","Mahakali Tea Estate","Dirai Tea Estate","Makaibari Tea Estate"}
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_registered_garden
integer x = 1769
integer y = 136
integer width = 343
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Register"
boolean default = true
end type

event clicked;choose case ddlb_1.text
	case "Urrunabund Tea Estate"
			gs_db_id="ubote";gs_db_pass="ubote"
	case "Narayanpur Tea Estate"
		gs_db_id="npote";gs_db_pass="npote"
	case "Shyamguri Tea Estate"
		gs_db_id="shote";gs_db_pass="shote"
	case "Manobag Tea Estate"
		gs_db_id="mbote";gs_db_pass="mbote"
	case "Manmohinipur Tea Estate"
		gs_db_id="meote";gs_db_pass="meote"
	case "Kenduguri Tea Estate"
		gs_db_id="kgote";gs_db_pass="kgote"
	case "Fulbari Tea Estate"
		gs_db_id="fbote";gs_db_pass="fbote"
	case "Attabarie Tea Estate"
		gs_db_id="abote";gs_db_pass="abote"
	case "Moran Tea Estate"
		gs_db_id="mrote";gs_db_pass="mrote"
	case "Lepetkatta Tea Estate"
		gs_db_id="lpote";gs_db_pass="lpote"
	case "Sepon Tea Estate"
		gs_db_id="spote";gs_db_pass="spote"
	case "Bhuyankhat Tea Estate"
		gs_db_id="beote";gs_db_pass="beote"
	case "Addabarie Tea Estate"
		gs_db_id="adote";gs_db_pass="adote"
	case "Mahakali Tea Estate"
		gs_db_id="mhote";gs_db_pass="mhote"
	case "Dirai Tea Estate"
		gs_db_id="drote";gs_db_pass="drote"	
	case "Makaibari Tea Estate"
		gs_db_id="mkote";gs_db_pass="mkote"	
end choose

if len(gs_db_id) > 0 then
	RegistrySet("HKEY_LOCAL_MACHINE\Software\GTE", "id", RegString!,gs_db_id )
	RegistrySet("HKEY_LOCAL_MACHINE\Software\GTE", "pass", RegString!, gs_db_pass)
end if

close(parent)
end event

type cb_1 from commandbutton within w_registered_garden
integer x = 1769
integer y = 320
integer width = 343
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
end type

event clicked;setnull(gs_db_id);setnull(gs_db_pass)
Close(parent)
end event

