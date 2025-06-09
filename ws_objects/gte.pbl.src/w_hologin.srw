$PBExportHeader$w_hologin.srw
forward
global type w_hologin from window
end type
type pb_1 from picturebutton within w_hologin
end type
type ddlb_1 from dropdownlistbox within w_hologin
end type
type sle_2 from singlelineedit within w_hologin
end type
type p_1 from picture within w_hologin
end type
end forward

global type w_hologin from window
integer width = 1280
integer height = 1124
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
pb_1 pb_1
ddlb_1 ddlb_1
sle_2 sle_2
p_1 p_1
end type
global w_hologin w_hologin

event open;f_center(this)

gs_path="c:\reports\"

DECLARE c1 CURSOR FOR  
select distinct USER_ID from fb_login, fb_login_detail where USER_ID = LD_USER_ID  and USER_ID !='ADMIN'
order by 1;
		 
open c1;

setnull(gs_user)

if sqlca.sqlcode = 0 then
	fetch c1 into :gs_user;
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(gs_user)
	  	setnull(gs_user)
	  	fetch c1 into :gs_user;
	loop
 	close c1;
end if;
setnull(gs_user)
setfocus(ddlb_1)
end event

on w_hologin.create
this.pb_1=create pb_1
this.ddlb_1=create ddlb_1
this.sle_2=create sle_2
this.p_1=create p_1
this.Control[]={this.pb_1,&
this.ddlb_1,&
this.sle_2,&
this.p_1}
end on

on w_hologin.destroy
destroy(this.pb_1)
destroy(this.ddlb_1)
destroy(this.sle_2)
destroy(this.p_1)
end on

type pb_1 from picturebutton within w_hologin
integer x = 146
integer y = 776
integer width = 343
integer height = 124
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean default = true
string picturename = "butten.jpg"
alignment htextalign = right!
end type

event clicked;string ls_pass
long ll_cnt

if isnull(trim(ddlb_1.text)) or trim(ddlb_1.text)=" " then
	messagebox('Login Error','Please Select the Login Name First')
	return 1
end if;

gs_user = TRIM(upper(ddlb_1.text))
ls_pass = sle_2.text

select distinct USER_FIRST_NAME,USER_LAST_NAME INTO :GS_USER_fname,:gs_user_lname
from fb_login, fb_login_detail where USER_ID = LD_USER_ID and USER_ID = :gs_user and
		 upper(USER_PASSWORD) = upper(:ls_pass) ;
		 		 
CHOOSE CASE sqlca.sqlcode
	CASE 0
	   	  if f_acess_log(gs_user,'GTE','LOGIN') = -1 then
			return 1
		 end if
		  gb_validuserid = true
		  open(w_selectgarden)
		  close (w_hologin)
	case 100
		  messagebox("Login Error","You Are Not Authorized User ....!",information!)
		  gb_validuserid = false
	case -1
		  messagebox("Sql Error",sqlca.sqlerrtext,information!)
		  gb_validuserid = false
END CHOOSE

end event

type ddlb_1 from dropdownlistbox within w_hologin
integer x = 146
integer y = 352
integer width = 727
integer height = 576
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Select Login"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_hologin
integer x = 142
integer y = 556
integer width = 731
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean password = true
textcase textcase = upper!
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_hologin
integer width = 1253
integer height = 1032
boolean originalsize = true
string picturename = "login.jpg"
boolean focusrectangle = false
end type

