$PBExportHeader$w_change_pass_othuser.srw
forward
global type w_change_pass_othuser from window
end type
type ddlb_1 from dropdownlistbox within w_change_pass_othuser
end type
type st_4 from statictext within w_change_pass_othuser
end type
type sle_5 from singlelineedit within w_change_pass_othuser
end type
type st_3 from statictext within w_change_pass_othuser
end type
type sle_4 from singlelineedit within w_change_pass_othuser
end type
type sle_3 from singlelineedit within w_change_pass_othuser
end type
type cb_2 from commandbutton within w_change_pass_othuser
end type
type cb_1 from commandbutton within w_change_pass_othuser
end type
type st_1 from statictext within w_change_pass_othuser
end type
end forward

global type w_change_pass_othuser from window
integer width = 1925
integer height = 924
boolean titlebar = true
string title = "Change Password Other User"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = minimized!
long backcolor = 67108864
boolean center = true
ddlb_1 ddlb_1
st_4 st_4
sle_5 sle_5
st_3 st_3
sle_4 sle_4
sle_3 sle_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_change_pass_othuser w_change_pass_othuser

type variables
string ls_pass,ls_temp,ls_lnm,ls_oldpss,ls_repss,ls_pss,ls_npsw
long ll_temp
string ls_userid,ls_username
end variables

event open;f_center(this)
cb_1.enabled = true


if isnull(gs_user_lname) then 
	ls_lnm = ' ' 
else 
	ls_lnm = gs_user_lname 
end if

ddlb_1.reset()

declare c1 cursor for

select user_id,USER_FIRST_NAME||' '||USER_last_NAME from fb_login where user_id not in ('PARIDA','ADMIN','USER');

open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_userid,:ls_username;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_userid)
		//sle_3.text=ls_username
		fetch c1 into :ls_userid,:ls_username;
	loop
	close c1;
end if


setpointer(arrow!)
end event

on w_change_pass_othuser.create
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.sle_5=create sle_5
this.st_3=create st_3
this.sle_4=create sle_4
this.sle_3=create sle_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.st_4,&
this.sle_5,&
this.st_3,&
this.sle_4,&
this.sle_3,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_change_pass_othuser.destroy
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.sle_5)
destroy(this.st_3)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

type ddlb_1 from dropdownlistbox within w_change_pass_othuser
integer x = 562
integer y = 48
integer width = 585
integer height = 376
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_user

ls_user=trim(ddlb_1.text)
declare c1 cursor for

select user_id,USER_FIRST_NAME||' '||USER_last_NAME from fb_login where user_id not in ('PARIDA','ADMIN','USER') and user_id=:ls_user;

open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_userid,:ls_username;
	
	do while sqlca.sqlcode <> 100
		sle_3.text=ls_username
		fetch c1 into :ls_userid,:ls_username;
	loop
	close c1;
end if


setpointer(arrow!)
end event

type st_4 from statictext within w_change_pass_othuser
integer x = 279
integer y = 268
integer width = 453
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "Re-enter Password"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_5 from singlelineedit within w_change_pass_othuser
integer x = 814
integer y = 256
integer width = 763
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 15793151
boolean password = true
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;ls_repss = trim(sle_5.text)
ls_pss = trim(sle_4.text)

if isnull(ls_repss) or len(ls_repss) = 0 then
	  messagebox('Error','Re-enter Password Should Not Be Blank !!!')
	  setfocus(sle_5)
	  return 1
end if
if len(ls_repss) < 6 then
	  messagebox('Error','Re-enter Password Should Of Atleast 6 Characters !!!')
	  setfocus(sle_5)
	  return 1
end if

if f_check_alphanumeric(ls_repss) = -1 then 
	setfocus(sle_5) 
	return 1
end if

if trim(ls_repss) <> trim(ls_pss) THEN
	  messagebox('Invalid Password','Re-enter Password And New Password Should Be Same, Please Check !!!')
	  setfocus(sle_5)
	  return 1
end if


end event

type st_3 from statictext within w_change_pass_othuser
integer x = 279
integer y = 176
integer width = 494
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "Enter New Password"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_4 from singlelineedit within w_change_pass_othuser
integer x = 814
integer y = 156
integer width = 763
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 15793151
boolean password = true
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;long ll_tmp
ls_npsw = trim(sle_4.text)


if isnull(ls_npsw) or len(ls_npsw) = 0 then
	messagebox('Error','New Password Should Not Be Blank !!!')
	setfocus(sle_4)
	return 1
end if

if trim(ls_oldpss) = trim(ls_npsw) THEN
	 messagebox('Invalid Password','Old And New Password Should Not Be Same, Please Check !!!')
	 setnull(ls_temp)
	 sle_4.text = ls_temp
	 setfocus (sle_4)	 
	 return 1
end if

if f_check_alphanumeric(ls_npsw) = -1 then 
	setfocus(sle_4) 
	return 1
end if

if len(ls_npsw) < 6 then
	Messagebox('Warning!','New Password Should Be Of Atleast 6 Characters !!!')
	setfocus(sle_4)
	return 1
end if

end event

type sle_3 from singlelineedit within w_change_pass_othuser
integer x = 1157
integer y = 48
integer width = 741
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
textcase textcase = upper!
integer limit = 20
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event modified;//if len(sle_2.text) > 0 then
//	cb_1.enabled = true
//else
//	cb_1.enabled = false
//end if

end event

type cb_2 from commandbutton within w_change_pass_othuser
integer x = 969
integer y = 504
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)
//close(w_main)
end event

type cb_1 from commandbutton within w_change_pass_othuser
integer x = 704
integer y = 504
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
boolean default = true
end type

event clicked;string ls_psw,ls_oldpsw

if isnull(ddlb_1.text) or len(ddlb_1.text) < 1 then
	messagebox('Warning!','Please Enter the Login ID !!!')
	setfocus(ddlb_1)
	return 1
elseif isnull(sle_4.text) or len(sle_4.text) < 1 then
	messagebox('Warning!','Please Enter the New Password !!!')
	setfocus(sle_4)
	return 1
elseif isnull(sle_5.text) or len(sle_5.text) < 1 then
	messagebox('Warning!','Please Re-Enter the New Password !!!')
	setfocus(sle_5)
	return 1
elseif trim(sle_4.text) <> trim(sle_5.text) then
	messagebox('Warning!','Re-Enterd Password Not Correct Try Again!!!')
	setnull(ls_psw)
	sle_5.text = ls_psw
	setfocus(sle_5)
	return 1
end if

ls_npsw = trim(sle_4.text)
ls_repss = trim(sle_5.text)

select USER_PASSWORD into :ls_oldpsw 
 from fb_login
 where USER_ID = trim(:ddlb_1.text);

if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	gb_validuserid = false
elseif sqlca.sqlcode = 100 then 
	messagebox("Login Error","Invalid/Wrong Password ....!",information!)
  	gb_validuserid = false
	setnull(ls_temp)	
	return
end if

if len(ls_npsw) < 6 then
	Messagebox('Warning!','New Password Should Be Of Atlest 6 Characters !!!')
	setfocus(sle_4)
	return 1
end if

if f_check_alphanumeric(ls_npsw) = -1 then 
	setfocus(sle_4)
	return 1
end if

if trim(ls_oldpsw) = trim(ls_npsw) THEN
	 messagebox('Invalid Password','Old and New Password Should Not Be Same, Please Check !!!')
	 setnull(ls_temp)
	sle_4.text = ls_temp
	setfocus (sle_4)	 
	 return 1
end if

if len(ls_repss) < 6 then
	  messagebox('Error','Re-enter Password Should Of Atlest 6 Characters !!!')
	  setfocus(sle_5)
	  return 1
end if

if f_check_alphanumeric(ls_repss) = -1 then
	setfocus(sle_5)
	return 1
end if

if trim(ls_repss) <> trim(ls_npsw) THEN
	  messagebox('Invalid Password','Re-enter Password And New Password Should Be Same, Please Check !!!')
	  setfocus(sle_5)
	  return 1
end if

update fb_login set USER_PASSWORD = trim(:sle_4.text),USER_LAST_PASS_CHANGED=sysdate
where USER_ID= trim(:ddlb_1.text);
if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	gb_validuserid = false
elseif sqlca.sqlcode = 100 then 
	messagebox("Login Error","You Are Not Authorized User ....!",information!)
	gb_validuserid = false
end if
commit using(sqlca);
messagebox('Information !','Your Password Has Been Successfully Changed !!!')

close(parent)


end event

type st_1 from statictext within w_change_pass_othuser
integer x = 279
integer y = 64
integer width = 215
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "User Id"
alignment alignment = right!
boolean focusrectangle = false
end type

