$PBExportHeader$w_gtegpprintdate.srw
forward
global type w_gtegpprintdate from window
end type
type st_4 from statictext within w_gtegpprintdate
end type
type st_3 from statictext within w_gtegpprintdate
end type
type em_3 from editmask within w_gtegpprintdate
end type
type em_2 from editmask within w_gtegpprintdate
end type
type sle_1 from singlelineedit within w_gtegpprintdate
end type
type st_2 from statictext within w_gtegpprintdate
end type
type cb_1 from commandbutton within w_gtegpprintdate
end type
type cb_2 from commandbutton within w_gtegpprintdate
end type
type em_1 from editmask within w_gtegpprintdate
end type
type st_1 from statictext within w_gtegpprintdate
end type
end forward

global type w_gtegpprintdate from window
integer width = 1897
integer height = 672
boolean titlebar = true
string title = "Gate Pass Date"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_3 st_3
em_3 em_3
em_2 em_2
sle_1 sle_1
st_2 st_2
cb_1 cb_1
cb_2 cb_2
em_1 em_1
st_1 st_1
end type
global w_gtegpprintdate w_gtegpprintdate

type variables
string ls_si,ls_vehicle, ls_st_dt, ls_end_dt
datetime ld_date, ld_st_dt, ld_end_dt
end variables

on w_gtegpprintdate.create
this.st_4=create st_4
this.st_3=create st_3
this.em_3=create em_3
this.em_2=create em_2
this.sle_1=create sle_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.em_1=create em_1
this.st_1=create st_1
this.Control[]={this.st_4,&
this.st_3,&
this.em_3,&
this.em_2,&
this.sle_1,&
this.st_2,&
this.cb_1,&
this.cb_2,&
this.em_1,&
this.st_1}
end on

on w_gtegpprintdate.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.em_1)
destroy(this.st_1)
end on

event open;ls_si = Message.StringParm	

em_1.text = string(today(),'dd/mm/yyyy hh mm ss')

select min(DTP_DATE) mindt,max(DTP_DATE) maxdt into :ld_st_dt, :ld_end_dt
from fb_sidetails a,(select DTP_DATE,DTPD_ID from fb_dailyteapacked b,fb_dtpdetails c where b.DTP_ID = c.DTP_ID) b
where a.DTPD_ID = b.DTPD_ID and si_id = :ls_si 
group by SI_ID order by 1 desc; 

if sqlca.sqlcode = -1 then
	messagebox('Error During getting Start & End Date',sqlca.sqlerrtext)
	return 1	
elseif sqlca.sqlcode = 0 then
	em_2.text = string(ld_st_dt,'dd/mm/yyyy')
	em_3.text = string(ld_end_dt,'dd/mm/yyyy')
end if

end event

type st_4 from statictext within w_gtegpprintdate
integer x = 46
integer y = 328
integer width = 928
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manufacturing To Date"
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtegpprintdate
integer x = 46
integer y = 228
integer width = 928
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Manufacturing From Date"
boolean focusrectangle = false
end type

type em_3 from editmask within w_gtegpprintdate
integer x = 974
integer y = 320
integer width = 347
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_2 from editmask within w_gtegpprintdate
integer x = 974
integer y = 220
integer width = 347
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type sle_1 from singlelineedit within w_gtegpprintdate
integer x = 974
integer y = 128
integer width = 530
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gtegpprintdate
integer x = 46
integer y = 132
integer width = 928
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plaese Enter The Vehicle No"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtegpprintdate
integer x = 23
integer y = 464
integer width = 329
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;CloseWithReturn(parent,'N')
end event

type cb_2 from commandbutton within w_gtegpprintdate
integer x = 1358
integer y = 464
integer width = 457
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save && close"
boolean cancel = true
end type

event clicked;ld_date = datetime(em_1.text)

if isnull(ld_date) or len(right(em_1.text,8)) = 0 or right(em_1.text,8) = '00:00:00' then
	messagebox('Date Or Time is Blank !', 'Please Enter The Date & Time !!!')
	return 1
end if

if isnull(sle_1.text) or len(sle_1.text) = 0 then
	messagebox('Date Or Time is Blank !', 'Please Enter The Vehicle No !!!')
	return 1
end if

ls_vehicle = sle_1.text

ls_st_dt = em_2.text
ls_end_dt = em_3.text

update fb_saleinvoice set SI_PRINT_DT = :ld_date, si_issue_dt = sysdate,si_vehicleno = trim(:ls_vehicle), si_st_dt = to_date(:ls_st_dt,'dd/mm/yyyy'), si_end_dt =  to_date(:ls_end_dt,'dd/mm/yyyy')  where SI_ID = :ls_si;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Updating Print Date in Invoice Table !!!',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

CloseWithReturn(parent,'Y')
end event

type em_1 from editmask within w_gtegpprintdate
integer x = 974
integer y = 44
integer width = 530
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy hh:mm:ss"
end type

type st_1 from statictext within w_gtegpprintdate
integer x = 46
integer y = 48
integer width = 928
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plaese Enter The Gate Pass Date && Time"
boolean focusrectangle = false
end type

