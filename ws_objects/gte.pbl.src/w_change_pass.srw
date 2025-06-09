$PBExportHeader$w_change_pass.srw
forward
global type w_change_pass from window
end type
type st_4 from statictext within w_change_pass
end type
type sle_5 from singlelineedit within w_change_pass
end type
type st_3 from statictext within w_change_pass
end type
type sle_4 from singlelineedit within w_change_pass
end type
type sle_3 from singlelineedit within w_change_pass
end type
type sle_1 from singlelineedit within w_change_pass
end type
type cb_2 from commandbutton within w_change_pass
end type
type cb_1 from commandbutton within w_change_pass
end type
type sle_2 from singlelineedit within w_change_pass
end type
type st_2 from statictext within w_change_pass
end type
type st_1 from statictext within w_change_pass
end type
end forward

global type w_change_pass from window
integer width = 1925
integer height = 924
boolean titlebar = true
string title = "Change Password"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_4 st_4
sle_5 sle_5
st_3 st_3
sle_4 sle_4
sle_3 sle_3
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
sle_2 sle_2
st_2 st_2
st_1 st_1
end type
global w_change_pass w_change_pass

type variables
string ls_pass,ls_temp,ls_lnm,ls_oldpss,ls_repss,ls_pss,ls_npsw,ls_userId
long ll_temp
end variables

event open;f_center(this)
cb_1.enabled = true

setfocus(sle_2)
sle_1.text = GS_USER

if isnull(gs_user_lname) then 
	ls_lnm = ' ' 
else 
	ls_lnm = gs_user_lname 
end if

sle_3.text = GS_USER_fname+' '+ls_lnm

end event

on w_change_pass.create
this.st_4=create st_4
this.sle_5=create sle_5
this.st_3=create st_3
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_2=create sle_2
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_4,&
this.sle_5,&
this.st_3,&
this.sle_4,&
this.sle_3,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.sle_2,&
this.st_2,&
this.st_1}
end on

on w_change_pass.destroy
destroy(this.st_4)
destroy(this.sle_5)
destroy(this.st_3)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.st_1)
end on

type st_4 from statictext within w_change_pass
integer x = 55
integer y = 364
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

type sle_5 from singlelineedit within w_change_pass
integer x = 521
integer y = 352
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
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event modified;ls_repss = trim(sle_5.text)
ls_pss = trim(sle_4.text)

if isnull(ls_repss) or len(ls_repss) = 0 then
	  messagebox('Error','Re-enter Password Should Not Be Blank !!!')
	  setfocus(sle_5)
	  return 1
end if
if len(ls_repss) < 8 then
	  messagebox('Error','Re-enter Password Should Of Atleast 8 Characters !!!')
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

type st_3 from statictext within w_change_pass
integer x = 14
integer y = 272
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

type sle_4 from singlelineedit within w_change_pass
integer x = 521
integer y = 252
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
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event modified;long ll_tmp
ls_npsw = trim(sle_4.text)
ls_oldpss = trim(sle_2.text)
ls_userId=trim(sle_1.text)
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

select distinct 'X' into :ls_temp from fb_login where user_id =:ls_userId and (upper(USER_LAST_PASSWORD_2)=upper(trim(:ls_npsw)) or upper(USER_LAST_PASSWORD_3) =upper(trim(:ls_npsw)));
if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	gb_validuserid = false
	
	return 1
elseif sqlca.sqlcode=0 then
	messagebox('Warning','New Password cannot be same from last 3 password')
	sle_4.text=''
	setfocus(sle_4)
	return 1
end if





if f_check_alphanumeric(ls_npsw) = -1 then 
	setfocus(sle_4) 
	return 1
end if

if len(ls_npsw) < 8 then
	Messagebox('Warning!','New Password Should Be Of Atleast 8 Characters !!!')
	setfocus(sle_4)
	return 1
end if

end event

type sle_3 from singlelineedit within w_change_pass
integer x = 818
integer y = 48
integer width = 1001
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 15793151
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

type sle_1 from singlelineedit within w_change_pass
integer x = 521
integer y = 48
integer width = 293
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 15793151
textcase textcase = upper!
integer limit = 20
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event modified;//select sl_cd  into :ll_temp
//from fa_sm_login
//where sl_cd =:sle_1.text;
//
//
//if sqlca.sqlcode = -1 then
//	messagebox('Error', 'During Checking User Id from fa_sm_login'+sqlca.sqlerrtext)
//	return -1
//elseif sqlca.sqlcode = 100 then
//	messagebox('Error', 'You Are Not Authorised Person !Please Enter Valid User id ')
//	return -1
//elseif sqlca.sqlcode = 0 then
//	select distinct pm_name  into :sle_3.text
//	from fa_party_mast
//	where pm_cd =:sle_1.text;
//
//		if sqlca.sqlcode = -1 then
//			messagebox('Error', 'During Checking User Id from fa_sm_login'+sqlca.sqlerrtext)
//			return -1
//		end if		
//end if	
end event

type cb_2 from commandbutton within w_change_pass
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

type cb_1 from commandbutton within w_change_pass
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

event clicked;string ls_psw

if isnull(sle_1.text) or len(sle_1.text) < 1 then
	messagebox('Warning!','Please Enter the Login ID !!!')
	setfocus(sle_1)
	return 1
elseif isnull(sle_2.text) or len(sle_2.text) < 1 then
	messagebox('Warning!','Please Enter the Old Password !!!')
	setfocus(sle_2)
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

ls_psw = trim(sle_2.text)
ls_npsw = trim(sle_4.text)
ls_repss = trim(sle_5.text)

select distinct 'x' into :ls_temp 
 from fb_login
 where USER_ID = :gs_user and (upper(USER_PASSWORD) = upper(trim(:ls_psw)) ) ;
 
 //or USER_LAST_PASSWORD_2 = :ls_psw or USER_LAST_PASSWORD_3 = :ls_psw

if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	gb_validuserid = false
elseif sqlca.sqlcode = 100 then 
	messagebox("Login Error","Invalid/Wrong Password ....!",information!)
  	gb_validuserid = false
	setnull(ls_temp)
	sle_2.text = ls_temp
	setfocus(sle_2)
	return
end if

if len(ls_npsw) < 8  then
	Messagebox('Warning!','New Password Should Be Of Atleast 8 Characters !!!')
	setfocus(sle_4)
	return 1
end if

if f_check_alphanumeric(ls_npsw) = -1 then 
	setfocus(sle_4)
	return 1
end if

if trim(ls_psw) = trim(ls_npsw) THEN
	 messagebox('Invalid Password','Old and New Password Should Not Be Same, Please Check !!!')
	 setnull(ls_temp)
	sle_4.text = ls_temp
	setfocus (sle_4)	 
	 return 1
end if


select distinct 'X' into :ls_temp from fb_login where user_id =:gs_user and (upper(USER_LAST_PASSWORD_2)=upper(trim(:ls_npsw)) or upper(USER_LAST_PASSWORD_3) =upper(trim(:ls_npsw)));
if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	gb_validuserid = false	
	return 1
elseif sqlca.sqlcode=0 then
	messagebox('Warning','New Password cannot be same from last 3 password')
	sle_4.text=''
	setfocus(sle_4)
	return 1
end if

if len(ls_repss) < 8 then
	  messagebox('Error','Re-enter Password Should Of Atlest 8 Characters !!!')
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

update fb_login set USER_PASSWORD = trim(:sle_4.text),USER_LAST_PASS_CHANGED=sysdate,USER_LAST_PASSWORD_2=USER_PASSWORD,USER_LAST_PASSWORD_3=USER_LAST_PASSWORD_2
where USER_ID= :gs_user;
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

type sle_2 from singlelineedit within w_change_pass
integer x = 521
integer y = 152
integer width = 763
integer height = 96
integer taborder = 10
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

event modified;string ls_psw,ls_tmp
ls_psw = sle_2.text

if isnull(ls_psw) or len(ls_psw) = 0 then
	  messagebox('Error','Old Password Should Not Be Blank !!!')
	  setfocus(sle_2)
	  return 1
end if

select distinct 'x' into :ls_temp 
 from fb_login
 where USER_ID = :gs_user and upper(USER_PASSWORD) = upper(:ls_psw) ;

if sqlca.sqlcode = -1 then 
	messagebox('SQL Error',sqlca.sqlerrtext);
	gb_validuserid = false
elseif sqlca.sqlcode = 100 then 
	messagebox("Login Error","Invalid/Wrong Password ....!",information!)
  	gb_validuserid = false
	setnull(ls_tmp)
	sle_2.text = ls_tmp
	setfocus(sle_2)
	return
end if

end event

type st_2 from statictext within w_change_pass
integer x = 174
integer y = 164
integer width = 334
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "Old Password"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_change_pass
integer x = 293
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

