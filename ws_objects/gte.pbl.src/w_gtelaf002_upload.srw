$PBExportHeader$w_gtelaf002_upload.srw
forward
global type w_gtelaf002_upload from window
end type
type sle_2 from singlelineedit within w_gtelaf002_upload
end type
type shl_1 from statichyperlink within w_gtelaf002_upload
end type
type cb_2 from commandbutton within w_gtelaf002_upload
end type
type cb_1 from commandbutton within w_gtelaf002_upload
end type
type sle_1 from singlelineedit within w_gtelaf002_upload
end type
type st_2 from statictext within w_gtelaf002_upload
end type
type st_1 from statictext within w_gtelaf002_upload
end type
end forward

global type w_gtelaf002_upload from window
integer width = 3351
integer height = 1384
boolean titlebar = true
string title = "Upload Worker Photo"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_2 sle_2
shl_1 shl_1
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
st_2 st_2
st_1 st_1
end type
global w_gtelaf002_upload w_gtelaf002_upload

type variables
string  ls_fullname,ls_filename,ls_finalpath, ls_ref, ls_path, ls_emp_cd, ls_text, ls_file
long ls_len,ls_check, ll_last, li_FileNum
end variables

on w_gtelaf002_upload.create
this.sle_2=create sle_2
this.shl_1=create shl_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.sle_2,&
this.shl_1,&
this.cb_2,&
this.cb_1,&
this.sle_1,&
this.st_2,&
this.st_1}
end on

on w_gtelaf002_upload.destroy
destroy(this.sle_2)
destroy(this.shl_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
end on

type sle_2 from singlelineedit within w_gtelaf002_upload
integer x = 1029
integer y = 576
integer width = 891
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type shl_1 from statichyperlink within w_gtelaf002_upload
integer x = 1893
integer y = 468
integer width = 311
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Open"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;ls_emp_cd = trim(sle_1.text)

select emp_photo into :ls_file from fb_employee where emp_id = :ls_emp_cd;
if sqlca.sqlcode = -1 then
	messagebox('Sql Error : During File Name Select :',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
shl_1.url = "\\192.168.1.91\upload\"+gs_garden_snm+"\"+ls_file
end event

type cb_2 from commandbutton within w_gtelaf002_upload
integer x = 2199
integer y = 452
integer width = 315
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Upload"
end type

event clicked;		long ll_rtn,li_FileNum1
		string ls_file_name,ls_newfile,ls_return,ls_newpath
		boolean ls_rename
		ls_file_name = sle_2.text
		if len(ls_file_name) > 0 and isnull(ls_file_name) = false then
			ls_ref = trim(sle_1.text)
			ls_newfile = ls_ref+lower(right(ls_file_name,(len(ls_file_name)-pos(ls_file_name,'.'))+1 ))

			ls_newpath =  "c:\voucher\"+ls_newfile
			ls_path = '\\192.168.1.91\upload\'+gs_garden_snm+"'"
//			ls_path = '\\192.168.1.91\test'
			li_FileNum = FileMove (ls_file_name,ls_newpath )
			if li_FileNum = -1 then
				messagebox('File Upload1','File Read Error !!!')
				return
			elseif li_FileNum = -2 then
				messagebox('File Upload2','File Write Error !!!')
				return
			end if				
			sle_2.text = ls_newfile
            
            ls_finalpath = ls_path+"\"+ls_newfile
            li_FileNum1 =  FileCopy (ls_newpath,ls_finalpath, FALSE)
			if li_FileNum1 = -1 then
				messagebox('File Upload3','File Read Error !!!')
				return
			elseif li_FileNum1 = -2 then
				messagebox('File Upload4','File Write Error !!!')
				return
			elseif li_FileNum1 = 1 then
				update fb_employee set EMP_PHOTO = :ls_newfile where EMP_ID = :ls_ref;
				
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error : During File Name Update :',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				else
					commit using sqlca;
				end if
				
				messagebox('File Upload','File Successfully !!!')
			end if
		end if	
		
////=============
//			
////			ls_finalpath = ls_path+"\"+ls_newfile
////			li_FileNum1 =  FileCopy (ls_newpath,ls_finalpath, FALSE)
////			if li_FileNum1 = -1 then
////				messagebox('File Upload3','File Read Error !!!')
////				return
////			elseif li_FileNum1 = -2 then
////				messagebox('File Upload4','File Write Error !!!')
////				return
////			elseif li_FileNum1 = 1 then
////				messagebox('File Upload','File Successfully !!!')
////			end if
////		end if				
////
end event

type cb_1 from commandbutton within w_gtelaf002_upload
integer x = 1586
integer y = 452
integer width = 315
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Browse"
end type

event clicked;//if GetFileOpenName ("Open", ls_fullname, ls_filename,"PDF", "PDF Files (*.pdf),*.pdf,Word Document Files (*.doc), *.doc, Excel12(*.xlsx) With Header, *.xlsx", "C:\temp", 512) < 1 then return
if GetFileOpenName ("Open", ls_fullname, ls_filename,"JPG", "Graphic Files (*.bmp;*.gif;*.jpg;*.jpeg),*.bmp;*.gif;*.jpg;*.jpeg","C:\temp", 512) < 1 then return
sle_2.text = ls_fullname
cb_2.enabled = true
end event

type sle_1 from singlelineedit within w_gtelaf002_upload
integer x = 1029
integer y = 464
integer width = 517
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;ls_emp_cd = trim(sle_1.text)

select distinct 'x' into :ls_text from fb_employee where EMP_ID = :ls_emp_cd;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Worker Details.',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning !!!','Entered Worker Code is Invalid / Nor In Master !!!')
	return 1
end if
end event

type st_2 from statictext within w_gtelaf002_upload
integer x = 411
integer y = 476
integer width = 603
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Enter Worker Code :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelaf002_upload
integer x = 763
integer y = 96
integer width = 1481
integer height = 104
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Upload Worker Photo"
alignment alignment = center!
boolean focusrectangle = false
end type

