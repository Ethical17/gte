$PBExportHeader$w_expdmp.srw
forward
global type w_expdmp from window
end type
type st_1 from statictext within w_expdmp
end type
type sle_1 from singlelineedit within w_expdmp
end type
type cb_3 from commandbutton within w_expdmp
end type
type cb_2 from commandbutton within w_expdmp
end type
type cb_1 from commandbutton within w_expdmp
end type
end forward

global type w_expdmp from window
integer width = 1289
integer height = 1204
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_1 st_1
sle_1 sle_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_expdmp w_expdmp

type variables
string ls_path
end variables

on w_expdmp.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_expdmp.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;ChangeDirectory("c:\")
if DirectoryExists("backupdb") = false then
	CreateDirectory ("backupdb")
end if
	ChangeDirectory("backupdb")

ls_path = getcurrentdirectory()+"\"
sle_1.text=ls_path
end event

type st_1 from statictext within w_expdmp
integer x = 23
integer y = 48
integer width = 1147
integer height = 84
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "File Will Backup in Following Folder:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_expdmp
integer x = 69
integer y = 184
integer width = 978
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_expdmp
integer x = 1051
integer y = 184
integer width = 114
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "..."
end type

event clicked;integer li_result

li_result = GetFolder( "my targets", ls_path )

sle_1.text=ls_path +"\" 
ls_path = getcurrentdirectory()+"\"

end event

type cb_2 from commandbutton within w_expdmp
integer x = 361
integer y = 612
integer width = 585
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_expdmp
integer x = 361
integer y = 476
integer width = 585
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Backup Database"
end type

event clicked;long ll_fexit,ll_retun,ll_temp
string lf_fnamed,ls_snm,ls_username,ls_password,ls_filename,ls_text

if isnull(trim(sle_1.text)) or len(trim(sle_1.text))=0 then
	messagebox('Folder Not Selected','Please Select the Folder First')
	return 1
end if;

ls_path = sle_1.text

if DirectoryExists(ls_path) = false then
	CreateDirectory (ls_path)
end if
	ChangeDirectory(ls_path)
	
if upper(gs_loginuser) <> 'MCOTE' and upper(gs_loginuser) <> 'MSOTE' then
	ls_USERNAME = lower(gs_garden_snm)+"ote"
	ls_password = lower(gs_garden_snm)+"ote"
	ls_filename = ls_USERNAME+"_"+string(today(),'yyyy_mm_dd')+string(now(),"_hh_mm")+".dmp"
elseif upper(gs_loginuser) = 'MCOTE' then
	ls_USERNAME = "mcote"
	ls_password = "mcote"
	ls_filename = "mcote_"+string(today(),'yyyy_mm_dd')+string(now(),"_hh_mm")+".dmp"
elseif upper(gs_loginuser) = 'MSOTE' then
	ls_USERNAME = "msote"
	ls_password = "msote"
	ls_filename = "msote_"+string(today(),'yyyy_mm_dd')+string(now(),"_hh_mm")+".dmp"
end if	

if pos(ls_filename,ls_USERNAME) = 0 then
	if messagebox('Wrong DMP Selected','Please Make sure that we have selected the Correct DMP file, Want to Continue process',question!,yesno!,2)=2 then
		return
	end if
end if


ls_text = "exp USERID=" + ls_USERNAME + "/" + ls_PASSWORD + "@ltcdb FILE=" + ls_path+ls_filename + " Owner="+ls_USERNAME

run(ls_text)
	
ll_retun=0

for ll_retun = 1 to 1000
	sleep(30)
	select distinct sid into :ll_temp from sys.v_$session  where upper(program)='EXP.EXE' and username=:ls_USERNAME;
	if sqlca.sqlcode =100 then
		Messagebox('Confirmation','The Database file Has been Backup Successfully ....!~r'+ls_path+ls_filename)
		return
	end if
next


end event

