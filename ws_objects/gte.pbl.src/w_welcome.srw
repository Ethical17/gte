$PBExportHeader$w_welcome.srw
forward
global type w_welcome from window
end type
type st_2 from statictext within w_welcome
end type
type phl_1 from picturehyperlink within w_welcome
end type
type st_1 from statictext within w_welcome
end type
end forward

global type w_welcome from window
integer width = 3296
integer height = 1836
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
phl_1 phl_1
st_1 st_1
end type
global w_welcome w_welcome

type variables
long ll_ctr
end variables

on w_welcome.create
this.st_2=create st_2
this.phl_1=create phl_1
this.st_1=create st_1
this.Control[]={this.st_2,&
this.phl_1,&
this.st_1}
end on

on w_welcome.destroy
destroy(this.st_2)
destroy(this.phl_1)
destroy(this.st_1)
end on

event timer;ll_ctr = ll_ctr + 1;

choose case mod(ll_ctr,4)
	case 0
		phl_1.PictureName = "home_pics.jpg"
	case 1
		phl_1.PictureName = "pic1.jpg"
	case 2
		phl_1.PictureName = "pic2.jpg"
	case 3
		phl_1.PictureName = "pic3.jpg"
//	case else
//		close(w_welcome)
//		open(w_login)
end choose


end event

event open;connect using sqlca;


setnull(gs_unit);setnull(gs_garden_nm);setnull(gs_garden_snm);setnull(gs_garden_nameadd);setnull(gs_CO_ID);setnull(gs_CO_name);
setnull(gs_supid);setnull(gs_storeid);setnull(gs_garden_state);setnull(gs_gstn_stcd);setnull(gs_gstnno);setnull(gs_garden_add);
setnull(gs_garden_mail);setnull(gs_panno)


select UNIT_ID,UNIT_NAME,UNIT_SHORTNAME,UNIT_NAME||' '||UNIT_ADD,UNIT_CO_CD, UNIT_COMPNAME,UNIT_SUPID,UNIT_MAIN_STORE,UNIT_STATE, UNIT_GSTN_STCD,UNIT_GSTNNO,UNIT_ADD, UNIT_EMAIL, UNIT_PANNO
  into :gs_unit,:gs_garden_nm,:gs_garden_snm,:gs_garden_nameadd,:gs_CO_ID,:gs_CO_name,:gs_supid,:gs_storeid,:gs_garden_state, :gs_gstn_stcd,:gs_gstnno,:gs_garden_add, :gs_garden_mail, :gs_panno
from fb_gardenmaster
where UNIT_ACTIVE_IND ='Y';

if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During Getting Garden Details : ',sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then 
	messagebox('Warning','Please Enter Then Garden Information First')
	return 1
else
	st_1.text = 'Welcome In '+gs_garden_nm
end if;	

timer(2)	

end event

event key;IF KeyDown(KeyEscape!) THEN
	close(w_welcome)
end if
end event

type st_2 from statictext within w_welcome
integer x = 2958
integer y = 1592
integer width = 325
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 16777215
long backcolor = 32768
string text = "Please sign in"
boolean focusrectangle = false
end type

event clicked;close(parent)
open(w_login)
end event

type phl_1 from picturehyperlink within w_welcome
integer x = 5
integer y = 8
integer width = 3273
integer height = 1576
string pointer = "HyperLink!"
string picturename = "home_pics.jpg"
boolean border = true
boolean focusrectangle = false
boolean map3dcolors = true
end type

event clicked;close(parent)
open(w_login)
end event

type st_1 from statictext within w_welcome
integer x = 5
integer y = 1588
integer width = 3278
integer height = 236
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = script!
string facename = "Monotype Corsiva"
boolean italic = true
long textcolor = 33554432
long backcolor = 32768
alignment alignment = center!
boolean focusrectangle = false
end type

