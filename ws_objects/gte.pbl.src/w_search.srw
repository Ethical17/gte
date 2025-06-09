$PBExportHeader$w_search.srw
$PBExportComments$Zoom control Window
forward
global type w_search from window
end type
type cb_6 from commandbutton within w_search
end type
type cb_5 from commandbutton within w_search
end type
type cb_4 from commandbutton within w_search
end type
type cbx_2 from checkbox within w_search
end type
type cbx_1 from checkbox within w_search
end type
type cb_3 from commandbutton within w_search
end type
type cb_2 from commandbutton within w_search
end type
type cb_1 from commandbutton within w_search
end type
type sle_1 from singlelineedit within w_search
end type
type st_percent from statictext within w_search
end type
end forward

global type w_search from window
integer x = 759
integer y = 1052
integer width = 1307
integer height = 604
boolean titlebar = true
string title = "Find Text"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
boolean center = true
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cbx_2 cbx_2
cbx_1 cbx_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
st_percent st_percent
end type
global w_search w_search

type variables
DataWindow  vi_DC           // Data Window Pointer
long ll_find, ll_end

end variables

on w_search.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_percent=create st_percent
this.Control[]={this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cbx_2,&
this.cbx_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.sle_1,&
this.st_percent}
end on

on w_search.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_percent)
end on

event open;f_center(this)
vi_dc = Message.PowerObjectParm	 
ll_end = vi_DC.RowCount() + 1
ll_find = 1

end event

type cb_6 from commandbutton within w_search
integer x = 951
integer y = 284
integer width = 283
integer height = 84
integer taborder = 42
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filter"
end type

event clicked;
if cbx_2.checked then 
	gs_filtertext = "match(vousearch,'"+sle_1.text+"')"
else
	gs_filtertext = "match(upper(vousearch),'"+upper(sle_1.text)+"')"
end if

vi_DC.setredraw(false)
vi_DC.setfilter(gs_filtertext)
vi_DC.filter()
vi_DC.groupcalc()
if vi_DC.rowcount() > 0 then;
	vi_DC.setredraw(true)
else
	Messagebox('Warning','Data Not Available In Given Criteria')
end if

end event

type cb_5 from commandbutton within w_search
integer x = 658
integer y = 284
integer width = 279
integer height = 84
integer taborder = 32
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Find &All"
end type

event clicked;long li_find,li_end

if cbx_1.checked then li_find=1

li_end = vi_DC.rowcount() + 1

if cbx_2.checked then 
	li_find = vi_DC.Find("Pos(vousearch,'"+sle_1.text+"') > 0", li_find, li_end)
else
	li_find = vi_DC.Find("Pos(upper(vousearch),'"+upper(sle_1.text)+"') > 0", li_find, li_end)
end if

if li_find = 0 then 
	messagebox('Warning','No data found as per entered search, Please re-search')
	return
else

	vi_DC.ScrollToRow(li_find)
	vi_DC.selectrow(li_find, true)
	 li_find++

	DO WHILE li_find > 0

			IF li_find > li_end THEN EXIT
	
			if cbx_2.checked then 
				li_find = vi_DC.Find("Pos(vousearch,'"+sle_1.text+"') > 0", li_find, li_end)
			else
				li_find = vi_DC.Find("Pos(upper(vousearch),'"+upper(sle_1.text)+"') > 0", li_find, li_end)
			end if

			if li_find  > 0 then
				vi_DC.ScrollToRow(li_find)
				vi_DC.selectrow(li_find, true)
				 li_find++
			end if

			if li_find =  0 then EXIT

	LOOP	
end if

end event

type cb_4 from commandbutton within w_search
integer x = 672
integer y = 404
integer width = 251
integer height = 84
integer taborder = 22
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;vi_DC.selectrow(0, FALSE)

vi_DC.setredraw(false)
vi_DC.setfilter("")
vi_DC.filter()
vi_DC.groupcalc()
vi_DC.setredraw(true)

end event

type cbx_2 from checkbox within w_search
integer x = 229
integer y = 20
integer width = 375
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Match Case"
end type

type cbx_1 from checkbox within w_search
integer x = 645
integer y = 16
integer width = 553
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Search From Begining"
boolean checked = true
end type

type cb_3 from commandbutton within w_search
integer x = 96
integer y = 284
integer width = 251
integer height = 84
integer taborder = 22
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Find"
boolean default = true
end type

event clicked;if cbx_1.checked then ll_find=1

if cbx_2.checked then 
	ll_find = vi_DC.Find("Pos(vousearch,'"+sle_1.text+"') > 0", ll_find, ll_end)
else
	ll_find = vi_DC.Find("Pos(upper(vousearch),'"+upper(sle_1.text)+"') > 0", ll_find, ll_end)
end if

if ll_find = 0 then 
	messagebox('Warning','No data found as per entered search, Please re-search')
	return
else
	cb_1.enabled = true
	vi_DC.ScrollToRow(ll_find)
	vi_DC.selectrow(ll_find, true)
end if	
end event

type cb_2 from commandbutton within w_search
integer x = 969
integer y = 404
integer width = 251
integer height = 84
integer taborder = 22
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;Close (Parent)
end event

type cb_1 from commandbutton within w_search
integer x = 361
integer y = 284
integer width = 283
integer height = 84
integer taborder = 12
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Find &Next"
end type

event clicked;if ll_find >0 then
	ll_find ++
end if

if cbx_2.checked then 
	ll_find = vi_DC.Find("Pos(vousearch,'"+sle_1.text+"') > 0", ll_find, ll_end)
else
	ll_find = vi_DC.Find("Pos(upper(vousearch),'"+upper(sle_1.text)+"') > 0", ll_find, ll_end)
end if

if ll_find = 0 then 
	if messagebox('Warning','Search Completed, Want To search from begining',question!,yesno!,1) = 2 then
		cb_1.enabled=false
		return
	else
		ll_find=1
	end if
else
	vi_DC.ScrollToRow(ll_find)
	vi_DC.selectrow(ll_find, true)
end if
end event

type sle_1 from singlelineedit within w_search
integer x = 215
integer y = 128
integer width = 974
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_percent from statictext within w_search
integer x = 82
integer y = 144
integer width = 119
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Find: "
alignment alignment = right!
boolean focusrectangle = false
end type

