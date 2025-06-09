$PBExportHeader$w_gtepuf010.srw
forward
global type w_gtepuf010 from window
end type
type cbx_1 from checkbox within w_gtepuf010
end type
type em_1 from editmask within w_gtepuf010
end type
type rb_3 from radiobutton within w_gtepuf010
end type
type cb_2 from commandbutton within w_gtepuf010
end type
type cb_3 from commandbutton within w_gtepuf010
end type
type st_3 from statictext within w_gtepuf010
end type
type rb_1 from radiobutton within w_gtepuf010
end type
type cb_4 from commandbutton within w_gtepuf010
end type
type dw_1 from datawindow within w_gtepuf010
end type
type gb_1 from groupbox within w_gtepuf010
end type
type cb_1 from commandbutton within w_gtepuf010
end type
end forward

global type w_gtepuf010 from window
integer width = 3547
integer height = 2320
boolean titlebar = true
string title = "(W_gtepuf010) Indent/PO Auto Cancellation "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_1 cbx_1
em_1 em_1
rb_3 rb_3
cb_2 cb_2
cb_3 cb_3
st_3 st_3
rb_1 rb_1
cb_4 cb_4
dw_1 dw_1
gb_1 gb_1
cb_1 cb_1
end type
global w_gtepuf010 w_gtepuf010

type variables
long ll_ctr, ll_last
string ls_tmp_id,ls_indent_id,ls_spid,ls_cnclty,ls_indent_dt
double ld_cncl_qnty,ld_old_cncl_qnty,ld_cper,ld_indqnty,ld_recqnty,ld_cnclqnty
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
	case "SAVEAS"
			this.dw_1.saveas()
	case "PDF"
			this.dw_1.saveas("C:\reports\Gtebgr001.pdf",pdf!,true)
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose

end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtepuf010.create
this.cbx_1=create cbx_1
this.em_1=create em_1
this.rb_3=create rb_3
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_3=create st_3
this.rb_1=create rb_1
this.cb_4=create cb_4
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_1=create cb_1
this.Control[]={this.cbx_1,&
this.em_1,&
this.rb_3,&
this.cb_2,&
this.cb_3,&
this.st_3,&
this.rb_1,&
this.cb_4,&
this.dw_1,&
this.gb_1,&
this.cb_1}
end on

on w_gtepuf010.destroy
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.rb_3)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_3)
destroy(this.rb_1)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

lb_query = false	
lb_neworder = false

setpointer(hourglass!)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type cbx_1 from checkbox within w_gtepuf010
integer x = 3131
integer y = 32
integer width = 357
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select ALL"
end type

event clicked;for ll_ctr = 1 to dw_1.rowcount()
	if cbx_1.checked then
		dw_1.setitem(ll_ctr,'appr_flag','Y')
		cb_3.enabled = true
	else
		dw_1.setitem(ll_ctr,'appr_flag','N')
		cb_3.enabled = false
	end if;	
next;
end event

type em_1 from editmask within w_gtepuf010
integer x = 1189
integer y = 36
integer width = 206
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
string minmax = "0~~100"
end type

type rb_3 from radiobutton within w_gtepuf010
integer x = 320
integer y = 36
integer width = 210
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "PO"
end type

type cb_2 from commandbutton within w_gtepuf010
integer x = 1413
integer y = 20
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false
dw_1.reset()

if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid (%)age for Indent or PO cancellation !!!')
	return 1
end if

ld_cper = double(em_1.text)

if rb_3.checked then
	ls_cnclty = 'P'
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ld_cper,'P')
else
	ls_cnclty = 'I'
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ld_cper,'I')
end if;	


//string ls_indent_dt,ls_spname
//double ld_indqnty ,ld_recqnty ,ld_cnclqnty

//setnull(ls_indent_id);setnull(ls_indent_dt); setnull(ls_spid);setnull(ls_spname); ld_indqnty = 0; ld_recqnty = 0;ld_cnclqnty = 0;
//ls_indent_id=left(ddlb_1.text,13)
//
//declare c1 cursor for
// select a.INDENT_ID, INDENT_DATE,b.SP_ID,SP_NAME, nvl(INDDET_QUANTITY,0), nvl(INDDET_RECEIVEDQUANTITY,0),nvl(INDDET_CANCELQUANTITY,0)
//  from fb_indent a,fb_indentdetails b,fb_storeproduct c
//  where a.indent_id=b.INDENT_ID and b.SP_ID=c.SP_ID  and  (inddet_quantity > (nvl(inddet_receivedquantity,0)+nvl(inddet_cancelquantity,0))) and a.indent_id=:ls_indent_id 
//union all
//select a.LPO_ID, LPO_DATE,b.SP_ID,SP_NAME, nvl(LPO_QUANTITY,0), nvl(LPO_QUANTITYRECEIVED,0),nvl(LPO_CANCELQUANTITY,0)
//  from FB_LOCALPURCHASEORDER a,FB_LPODETAILS b,fb_storeproduct c
//  where a.LPO_ID=b.LPO_ID and b.SP_ID=c.SP_ID  and  (LPO_QUANTITY > (nvl(LPO_QUANTITYRECEIVED,0)+nvl(LPO_CANCELQUANTITY,0))) and a.LPO_ID=:ls_indent_id 
//order by 1 asc;
//
//open c1;
//
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ls_indent_id,:ls_indent_dt,:ls_spid,:ls_spname, :ld_indqnty, :ld_recqnty, :ld_cnclqnty;
//	
//	do while sqlca.sqlcode <> 100
//				
//		dw_1.scrolltorow(dw_1.insertrow(0))
//		dw_1.setitem(dw_1.getrow(),'cncl_type',ls_cnclty)
//		dw_1.setitem(dw_1.getrow(),'indent_id',ls_indent_id)
//		dw_1.setitem(dw_1.getrow(),'indent_date',date(ls_indent_dt))
//		dw_1.setitem(dw_1.getrow(),'sp_id',ls_spid)
//		dw_1.setitem(dw_1.getrow(),'sp_name',ls_spname)
//		dw_1.setitem(dw_1.getrow(),'inddet_qnty',ld_indqnty)
//		dw_1.setitem(dw_1.getrow(),'inddet_recv_qnty',ld_recqnty)
//		dw_1.setitem(dw_1.getrow(),'inddet_cancel_qnty',ld_cnclqnty)
//		dw_1.setitem(dw_1.getrow(),'indent_entry_by',gs_user)
//		dw_1.setitem(dw_1.getrow(),'indent_entry_dt',datetime(today()))
//
//		
//		setnull(ls_indent_id);setnull(ls_indent_dt); setnull(ls_spid);setnull(ls_spname); ld_indqnty = 0; ld_recqnty = 0;ld_cnclqnty = 0;
//		
//		fetch c1 into :ls_indent_id,:ls_indent_dt,:ls_spid,:ls_spname, :ld_indqnty, :ld_recqnty, :ld_cnclqnty;
//	loop
//	close c1;
	

//end if

end event

type cb_3 from commandbutton within w_gtepuf010
integer x = 1687
integer y = 20
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if lb_neworder = true then

	//New/Update  received qnty  update in indent
	ll_last=0
	for ll_ctr = 1 to dw_1.rowcount()
		if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y' then
			if ll_last=0 then
				select nvl(MAX(substr(indent_cncl_id,4,10)),0) into :ll_last from fb_indentcancel;
			end if
			ll_last = ll_last + 1
			ls_tmp_id = 'ICN'+string(ll_last,'0000000000')
			
			ls_indent_id = dw_1.getitemstring(ll_ctr,'indent_id')
			ls_indent_dt = string(dw_1.getitemdatetime(ll_ctr,'indent_date'),'dd/mm/yyyy')
			ls_spid = dw_1.getitemstring(ll_ctr,'sp_id')
			ld_indqnty = dw_1.getitemnumber(ll_ctr,'indent_qnty')
			ld_recqnty = dw_1.getitemnumber(ll_ctr,'recv_qnty')
			ld_cnclqnty = dw_1.getitemnumber(ll_ctr,'cncl_qnty')
			ld_cncl_qnty = dw_1.getitemnumber(ll_ctr,'balance_qnty')
			//ls_cnclty = dw_1.getitemstring(ll_ctr,'cncl_type')
			if rb_3.checked then
				ls_cnclty = 'P'
			else
				ls_cnclty = 'I'
			end if;	
			
			insert into fb_indentcancel (INDENT_ID, INDENT_DATE, SP_ID, INDDET_QNTY, INDDET_RECV_QNTY, INDDET_CANCEL_QNTY, NDDET_REMARKS, INDENT_ENTRY_BY, INDENT_ENTRY_DT, INDENT_CNCL_ID, INDENT_CNCL_DT, INDDET_TOBE_CANCEL_QNTY,CNCL_TYPE, AUTO_CNCL_IND)
				values(:ls_indent_id,to_date(:ls_indent_dt,'dd/mm/yyyy'),:ls_spid,:ld_indqnty,:ld_recqnty,:ld_cnclqnty,'Quantity Cancel from Auto Cancellation',:gs_user,sysdate,:ls_tmp_id,sysdate,:ld_cncl_qnty,:ls_cnclty,'Y' );
					
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error During Cancel Quantity Update in Cancellation detail : ',sqlca.sqlerrtext);
					return 1;
				end if;	
			
			if ls_cnclty='I' then								
				  update fb_indentdetails set INDDET_CANCELQUANTITY = nvl(INDDET_CANCELQUANTITY,0) + nvl(:ld_cncl_qnty,0)  where INDENT_ID= :ls_indent_id and SP_ID = :ls_spid; 
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error During Received Quantity Update in Indent detail : ',sqlca.sqlerrtext);
					return 1;
				end if;	
			elseif ls_cnclty='P' then
				  update fb_lpodetails set LPO_CANCELQUANTITY = nvl(LPO_CANCELQUANTITY,0) + nvl(:ld_cncl_qnty,0)  where LPO_ID= :ls_indent_id and SP_ID = :ls_spid; 
			
				if sqlca.sqlcode = -1 then
					messagebox('Sql Error During Received Quantity Update  in Po detail: ',sqlca.sqlerrtext);
					return 1;
				end if;		
			end if;
		end if;	
	next
     end if		
	
	commit using sqlca;
	cb_3.enabled = false
	cb_1.enabled = true
	dw_1.reset()
		
else
	return
end if 
end event

type st_3 from statictext within w_gtepuf010
integer x = 594
integer y = 44
integer width = 576
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Balance Quantity (%) : "
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_gtepuf010
integer x = 55
integer y = 36
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Indent"
end type

type cb_4 from commandbutton within w_gtepuf010
integer x = 1957
integer y = 20
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtepuf010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 27
integer y = 124
integer width = 3470
integer height = 2068
integer taborder = 30
string dataobject = "dw_gtepuf010"
boolean vscrollbar = true
end type

event itemchanged;if dwo.name = 'appr_flag' then
		if data ='Y' then		
			cb_3.enabled = true
		end if 
end if;
end event

type gb_1 from groupbox within w_gtepuf010
integer x = 41
integer width = 517
integer height = 124
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

type cb_1 from commandbutton within w_gtepuf010
boolean visible = false
integer x = 1687
integer y = 20
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_1.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	cb_3.enabled = false
  	cb_2.enabled = false
	dw_1.settaborder('inddet_tobe_cancel_qnty',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('inddet_tobe_cancel_qnty')
	cb_1.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_1.text = "&Query"
   	cb_2.enabled = true	
end if
lb_neworder = false

end event

