$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type pb_1 from picturebutton within w_login
end type
type ddlb_1 from dropdownlistbox within w_login
end type
type sle_2 from singlelineedit within w_login
end type
type p_1 from picture within w_login
end type
end forward

global type w_login from window
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
global w_login w_login

event open;f_center(this)

gs_path="c:\reports\"

DECLARE c1 CURSOR FOR  
select distinct USER_ID from fb_login, fb_login_detail where USER_ID = LD_USER_ID and LD_APPS = 'GTE' and USER_ID !='ADMIN' and  nvl(USER_ACTIVE_IND,'Y')='Y'
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

on w_login.create
this.pb_1=create pb_1
this.ddlb_1=create ddlb_1
this.sle_2=create sle_2
this.p_1=create p_1
this.Control[]={this.pb_1,&
this.ddlb_1,&
this.sle_2,&
this.p_1}
end on

on w_login.destroy
destroy(this.pb_1)
destroy(this.ddlb_1)
destroy(this.sle_2)
destroy(this.p_1)
end on

type pb_1 from picturebutton within w_login
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

event clicked;string ls_pass,indchangepass
datetime ld_lspasschng
long ll_cnt,ll_passexpireday

if isnull(trim(ddlb_1.text)) or trim(ddlb_1.text)=" " then
	messagebox('Login Error','Please Select the Login Name First')
	return 1
end if;

gs_user = TRIM(upper(ddlb_1.text))
ls_pass = sle_2.text

select sysdate into :gd_dt from dual; 

//messagebox('DBdate','DBdate : '+string(gd_dt)+'  Sysdate : '+string(Today()) ) 

if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if



//pasword expire check
select (case when (sysdate - USER_LAST_PASS_CHANGED)>30 then 'Y' else 'N' end), USER_LAST_PASS_CHANGED,trunc((sysdate - USER_LAST_PASS_CHANGED)) into :indchangepass,:ld_lspasschng,:ll_passexpireday from fb_login where upper(USER_ID) = upper(:gs_user) and
         upper(USER_PASSWORD) = upper(:ls_pass) ;
			
if sqlca.sqlcode =  -1 then
	 messagebox("Sql Error",sqlca.sqlerrtext,information!)
	 return 1
elseif sqlca.sqlcode = 100 then
	messagebox("Login Error","You Are Not Authorized User ....!",information!)
	return 1
else


if(indchangepass='Y' and gs_user<>'ADMIN' and not isnull(ld_lspasschng)) then 
	messagebox('Warning !!!','Your Password Has been expire,Kindly Change')
	open(w_change_pass)
	messagebox('Message', 'You can now login with your new password')
	sle_2.text=''
	return 1	
elseif 	(indchangepass='N' or  gs_user='ADMIN' or isnull(ld_lspasschng)) then
	if  isnull(ld_lspasschng) then
		update fb_login set USER_LAST_PASS_CHANGED=sysdate where USER_ID = :gs_user;	
		if sqlca.sqlcode= -1 then
			messagebox('Error', 'Error occured whil updating last password: '+sqlca.sqlerrtext)
			return 1
		end if
	end if
	
	if ll_passexpireday>=27 and gs_user<>'ADMIN' then
		messagebox('Warning', 'Your password will expire in : '+string(30-ll_passexpireday)+ ' Days')
	end if
	
	select distinct USER_FIRST_NAME,USER_LAST_NAME INTO :GS_USER_fname,:gs_user_lname
	from fb_login, fb_login_detail where upper(USER_ID) = upper(LD_USER_ID) and upper(USER_ID) = upper(:gs_user) and
			 upper(USER_PASSWORD) = upper(:ls_pass) and LD_APPS = 'GTE' and nvl(USER_ACTIVE_IND,'Y')='Y';
				 
		CHOOSE CASE sqlca.sqlcode
			CASE 0
					  if f_acess_log(gs_user,'GTE','LOGIN') = -1 then
					return 1
				 end if
				  gb_validuserid = true
				  open(w_mdi)
				  w_login.visible = false
				  //close (w_login)
			case 100
				  messagebox("Login Error","You Are Not Authorized User ....!",information!)
				  gb_validuserid = false
			case -1
				  messagebox("Sql Error",sqlca.sqlerrtext,information!)
				  gb_validuserid = false
		END CHOOSE
	
	end if
end if
end event

type ddlb_1 from dropdownlistbox within w_login
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

type sle_2 from singlelineedit within w_login
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

type p_1 from picture within w_login
integer width = 1253
integer height = 1032
boolean originalsize = true
string picturename = "login.jpg"
boolean focusrectangle = false
end type

