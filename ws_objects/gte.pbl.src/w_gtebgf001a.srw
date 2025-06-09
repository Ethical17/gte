$PBExportHeader$w_gtebgf001a.srw
forward
global type w_gtebgf001a from window
end type
type cb_4 from commandbutton within w_gtebgf001a
end type
type cb_3 from commandbutton within w_gtebgf001a
end type
type cb_2 from commandbutton within w_gtebgf001a
end type
type cb_1 from commandbutton within w_gtebgf001a
end type
type dw_1 from datawindow within w_gtebgf001a
end type
end forward

global type w_gtebgf001a from window
integer width = 3205
integer height = 2180
boolean titlebar = true
string title = "(w_gtebgf001a) Tea Made Details"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtebgf001a w_gtebgf001a

type variables
long ll_ctr,ll_year,ll_month
string ls_ind,ls_temp
//string ls_estate,ls_temp,ls_del_ind,ls_storecat,ls_tmp_id,ls_count,ls_last,ls_id,ls_mm
boolean lb_neworder, lb_query
//
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_stc, long fl_year, long fs_month)
public function integer wf_upd_budget (long fl_year, long fl_month, double fl_val_own_of, double fl_val_of_own, string fs_old_ind)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if ( isnull(dw_1.getitemstring(fl_row,'mtmbd_estate')) or  len(dw_1.getitemstring(fl_row,'mtmbd_estate'))=0 or &
		isnull(dw_1.getitemnumber(fl_row,'mtmbd_month')) or  dw_1.getitemnumber(fl_row,'mtmbd_month')=0 or &
		isnull(dw_1.getitemnumber(fl_row,'mtmbd_year')) or  dw_1.getitemnumber(fl_row,'mtmbd_year')=0 ) then
	    	messagebox('Warning: One Of The Following Fields Are Blank','Estate,Year,Month. Please Check !!!')
		 return -1
	end if
	
	double ld_own,ld_of
	
	ld_own = dw_1.getitemnumber(fl_row,'mtmbd_tmown_of')
	ld_of	  = dw_1.getitemnumber(fl_row,'mtmbd_tmof_own')
	
	if isnull(ld_own) then ld_own=0
	if isnull(ld_of) then ld_of=0
	
	if (ld_own + ld_of) =0 then
	    	messagebox('Warning: One Of The Following Fields Are Blank','Either "Own Crop Other Factory" OR "Other Crop at Own Factory" should be filled. Please Check !!!')
		 return -1
	end if
	
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fl_stc, long fl_year, long fs_month);long fl_row

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		if dw_1.getitemstring(fl_row,'mtmbd_estate') = fl_stc  and dw_1.getitemnumber(fl_row,'mtmbd_year') = fl_year and dw_1.getitemnumber(fl_row,'mtmbd_month') = fs_month then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1



end function

public function integer wf_upd_budget (long fl_year, long fl_month, double fl_val_own_of, double fl_val_of_own, string fs_old_ind);
if fs_old_ind = 'Y' then
	update FB_MONTHLYTEAMADEBUDGET
		set  	MTMB_JANTMOWN_OF = (nvl(MTMB_JANTMOWN_OF,0) - decode(:fl_month,1,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_FEBTMOWN_OF = (nvl(MTMB_FEBTMOWN_OF,0) - decode(:fl_month,2,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_MARTMOWN_OF = (nvl(MTMB_MARTMOWN_OF,0) - decode(:fl_month,3,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_APRTMOWN_OF = (nvl(MTMB_APRTMOWN_OF,0) - decode(:fl_month,4,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_MAYTMOWN_OF = (nvl(MTMB_MAYTMOWN_OF,0) - decode(:fl_month,5,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_JUNTMOWN_OF = (nvl(MTMB_JUNTMOWN_OF,0) - decode(:fl_month,6,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_JULTMOWN_OF = (nvl(MTMB_JULTMOWN_OF,0) - decode(:fl_month,7,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_AUGTMOWN_OF = (nvl(MTMB_AUGTMOWN_OF,0) - decode(:fl_month,8,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_SEPTMOWN_OF = (nvl(MTMB_SEPTMOWN_OF,0) - decode(:fl_month,9,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_OCTTMOWN_OF = (nvl(MTMB_OCTTMOWN_OF,0) - decode(:fl_month,10,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_NOVTMOWN_OF = (nvl(MTMB_NOVTMOWN_OF,0) - decode(:fl_month,11,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_DECTMOWN_OF = (nvl(MTMB_DECTMOWN_OF,0) - decode(:fl_month,12,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_JANTMOF_OWN = (nvl(MTMB_JANTMOF_OWN,0) - decode(:fl_month,1,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_FEBTMOF_OWN = (nvl(MTMB_FEBTMOF_OWN,0) - decode(:fl_month,2,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_MARTMOF_OWN = (nvl(MTMB_MARTMOF_OWN,0) - decode(:fl_month,3,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_APRTMOF_OWN = (nvl(MTMB_APRTMOF_OWN,0) - decode(:fl_month,4,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_MAYTMOF_OWN = (nvl(MTMB_MAYTMOF_OWN,0) - decode(:fl_month,5,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_JUNTMOF_OWN = (nvl(MTMB_JUNTMOF_OWN,0) - decode(:fl_month,6,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_JULTMOF_OWN = (nvl(MTMB_JULTMOF_OWN,0) - decode(:fl_month,7,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_AUGTMOF_OWN = (nvl(MTMB_AUGTMOF_OWN,0) - decode(:fl_month,8,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_SEPTMOF_OWN = (nvl(MTMB_SEPTMOF_OWN,0) - decode(:fl_month,9,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_OCTTMOF_OWN = (nvl(MTMB_OCTTMOF_OWN,0) - decode(:fl_month,10,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_NOVTMOF_OWN = (nvl(MTMB_NOVTMOF_OWN,0) - decode(:fl_month,11,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_DECTMOF_OWN = (nvl(MTMB_DECTMOF_OWN,0) - decode(:fl_month,12,nvl(:fl_val_of_own,0),0) ) 
		where MTMB_YEAR = :fl_year;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Errror During Projection Update',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
		end if
else
	select distinct 'x' into :ls_temp from FB_MONTHLYTEAMADEBUDGET where MTMB_YEAR = :fl_year;	
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL Errror During Projection select',sqlca.sqlerrtext)
		rollback using sqlca;
		return -1
	elseif sqlca.sqlcode = 0 then
		
	update FB_MONTHLYTEAMADEBUDGET
		set  	MTMB_JANTMOWN_OF = (nvl(MTMB_JANTMOWN_OF,0) + decode(:fl_month,1,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_FEBTMOWN_OF = (nvl(MTMB_FEBTMOWN_OF,0) + decode(:fl_month,2,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_MARTMOWN_OF = (nvl(MTMB_MARTMOWN_OF,0) + decode(:fl_month,3,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_APRTMOWN_OF = (nvl(MTMB_APRTMOWN_OF,0) + decode(:fl_month,4,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_MAYTMOWN_OF = (nvl(MTMB_MAYTMOWN_OF,0) + decode(:fl_month,5,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_JUNTMOWN_OF = (nvl(MTMB_JUNTMOWN_OF,0) + decode(:fl_month,6,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_JULTMOWN_OF = (nvl(MTMB_JULTMOWN_OF,0) + decode(:fl_month,7,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_AUGTMOWN_OF = (nvl(MTMB_AUGTMOWN_OF,0) + decode(:fl_month,8,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_SEPTMOWN_OF = (nvl(MTMB_SEPTMOWN_OF,0) + decode(:fl_month,9,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_OCTTMOWN_OF = (nvl(MTMB_OCTTMOWN_OF,0) + decode(:fl_month,10,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_NOVTMOWN_OF = (nvl(MTMB_NOVTMOWN_OF,0) + decode(:fl_month,11,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_DECTMOWN_OF = (nvl(MTMB_DECTMOWN_OF,0) + decode(:fl_month,12,nvl(:fl_val_own_of,0),0) ) , 
				MTMB_JANTMOF_OWN = (nvl(MTMB_JANTMOF_OWN,0) + decode(:fl_month,1,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_FEBTMOF_OWN = (nvl(MTMB_FEBTMOF_OWN,0) + decode(:fl_month,2,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_MARTMOF_OWN = (nvl(MTMB_MARTMOF_OWN,0) + decode(:fl_month,3,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_APRTMOF_OWN = (nvl(MTMB_APRTMOF_OWN,0) + decode(:fl_month,4,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_MAYTMOF_OWN = (nvl(MTMB_MAYTMOF_OWN,0) + decode(:fl_month,5,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_JUNTMOF_OWN = (nvl(MTMB_JUNTMOF_OWN,0) + decode(:fl_month,6,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_JULTMOF_OWN = (nvl(MTMB_JULTMOF_OWN,0) + decode(:fl_month,7,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_AUGTMOF_OWN = (nvl(MTMB_AUGTMOF_OWN,0) + decode(:fl_month,8,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_SEPTMOF_OWN = (nvl(MTMB_SEPTMOF_OWN,0) + decode(:fl_month,9,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_OCTTMOF_OWN = (nvl(MTMB_OCTTMOF_OWN,0) + decode(:fl_month,10,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_NOVTMOF_OWN = (nvl(MTMB_NOVTMOF_OWN,0) + decode(:fl_month,11,nvl(:fl_val_of_own,0),0) ) , 
				MTMB_DECTMOF_OWN = (nvl(MTMB_DECTMOF_OWN,0) + decode(:fl_month,12,nvl(:fl_val_of_own,0),0) ) 
		where MTMB_YEAR = :fl_year;	
		
		if sqlca.sqlcode = -1 then
			messagebox('SQL Errror During Projection Update',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
		end if
	elseif sqlca.sqlcode = 100 then	
		
		insert into  FB_MONTHLYTEAMADEBUDGET( MTMB_YEAR, MTMB_JANTMOWN_OF, MTMB_FEBTMOWN_OF, MTMB_MARTMOWN_OF, MTMB_APRTMOWN_OF, MTMB_MAYTMOWN_OF, MTMB_JUNTMOWN_OF, MTMB_JULTMOWN_OF, MTMB_AUGTMOWN_OF, MTMB_SEPTMOWN_OF, MTMB_OCTTMOWN_OF, MTMB_NOVTMOWN_OF, MTMB_DECTMOWN_OF,
		                                                             MTMB_JANTMOF_OWN, MTMB_FEBTMOF_OWN, MTMB_MARTMOF_OWN, MTMB_APRTMOF_OWN, MTMB_MAYTMOF_OWN, MTMB_JUNTMOF_OWN, MTMB_JULTMOF_OWN, MTMB_AUGTMOF_OWN, MTMB_SEPTMOF_OWN, MTMB_OCTTMOF_OWN, MTMB_NOVTMOF_OWN, MTMB_DECTMOF_OWN, MTMB_ENTRY_BY, MTMB_ENTRY_DT,
																						 MTMB_JANTEAMADEOWN, MTMB_FEBTEAMADEOWN, MTMB_MARTEAMADEOWN, MTMB_APRTEAMADEOWN, MTMB_MAYTEAMADEOWN, MTMB_JUNTEAMADEOWN, MTMB_JULTEAMADEOWN, MTMB_AUGTEAMADEOWN, MTMB_SEPTEAMADEOWN, MTMB_OCTTEAMADEOWN, MTMB_NOVTEAMADEOWN, MTMB_DECTEAMADEOWN, MTMB_JANTEAMADEPUR, MTMB_FEBTEAMADEPUR, MTMB_MARTEAMADEPUR, MTMB_APRTEAMADEPUR, MTMB_MAYTEAMADEPUR, MTMB_JUNTEAMADEPUR, MTMB_JULTEAMADEPUR, MTMB_AUGTEAMADEPUR, MTMB_SEPTEAMADEPUR, MTMB_OCTTEAMADEPUR, MTMB_NOVTEAMADEPUR, MTMB_DECTEAMADEPUR)
		values (:fl_year,decode(:fl_month,1,nvl(:fl_val_own_of,0),0),decode(:fl_month,2,nvl(:fl_val_own_of,0),0),decode(:fl_month,3,nvl(:fl_val_own_of,0),0),decode(:fl_month,4,nvl(:fl_val_own_of,0),0),decode(:fl_month,5,nvl(:fl_val_own_of,0),0),decode(:fl_month,6,nvl(:fl_val_own_of,0),0),decode(:fl_month,7,nvl(:fl_val_own_of,0),0),decode(:fl_month,8,nvl(:fl_val_own_of,0),0),decode(:fl_month,9,nvl(:fl_val_own_of,0),0),decode(:fl_month,10,nvl(:fl_val_own_of,0),0),decode(:fl_month,11,nvl(:fl_val_own_of,0),0),decode(:fl_month,12,nvl(:fl_val_own_of,0),0),
		           decode(:fl_month,1,nvl(:fl_val_of_own,0),0),decode(:fl_month,2,nvl(:fl_val_of_own,0),0),decode(:fl_month,3,nvl(:fl_val_of_own,0),0),decode(:fl_month,4,nvl(:fl_val_of_own,0),0),decode(:fl_month,5,nvl(:fl_val_of_own,0),0),decode(:fl_month,6,nvl(:fl_val_of_own,0),0),decode(:fl_month,7,nvl(:fl_val_of_own,0),0),decode(:fl_month,8,nvl(:fl_val_of_own,0),0),decode(:fl_month,9,nvl(:fl_val_of_own,0),0),decode(:fl_month,10,nvl(:fl_val_of_own,0),0),decode(:fl_month,11,nvl(:fl_val_of_own,0),0),decode(:fl_month,12,nvl(:fl_val_of_own,0),0),:gs_user,trunc(sysdate),
					  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	
        if sqlca.sqlcode = -1 then
			messagebox('SQL Errror During Projection Insert',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
		end if
end if	
end if
	if sqlca.sqlcode = -1 then
		messagebox('SQL Errror During Projection Update',sqlca.sqlerrtext)
		rollback using sqlca;
		return -1
	end if
return 1
end function

on w_gtebgf001a.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtebgf001a.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.settransobject(sqlca)

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

lb_query = false	
lb_neworder = false

ls_temp = Message.StringParm

ll_year = long(left(ls_temp,4))
ll_month = long(left(right(ls_temp,3),2))
ls_ind=right(ls_temp,1)
cb_1.postevent(clicked!)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if

end event

type cb_4 from commandbutton within w_gtebgf001a
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)	
end if


end event

type cb_3 from commandbutton within w_gtebgf001a
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'mtmbd_estate')) or len(dw_1.getitemstring(dw_1.rowcount(),'mtmbd_estate'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y'  then
			//old
			if wf_upd_budget(dw_1.getitemnumber(ll_ctr,'mtmbd_year'),dw_1.getitemnumber(ll_ctr,'mtmbd_month'),dw_1.getitemnumber(ll_ctr,'old_own_of'),dw_1.getitemnumber(ll_ctr,'old_of_own'),'Y') = -1 then 
				rollback using sqlca;
				return 1
			end if;
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
			
	        	if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then
				//new
				if wf_upd_budget(dw_1.getitemnumber(ll_ctr,'mtmbd_year'),dw_1.getitemnumber(ll_ctr,'mtmbd_month'),dw_1.getitemnumber(ll_ctr,'mtmbd_tmown_of'),dw_1.getitemnumber(ll_ctr,'mtmbd_tmof_own'),'N') = -1 then 
					rollback using sqlca;
					return 1
				end if;
			elseif dw_1.getitemstatus(ll_ctr,0,primary!) = DataModified! then
				//OLD
				if wf_upd_budget(dw_1.getitemnumber(ll_ctr,'mtmbd_year'),dw_1.getitemnumber(ll_ctr,'mtmbd_month'),dw_1.getitemnumber(ll_ctr,'old_own_of'),dw_1.getitemnumber(ll_ctr,'old_of_own'),'Y') = -1 then 
					rollback using sqlca;
					return 1
				end if;
				//new
				if wf_upd_budget(dw_1.getitemnumber(ll_ctr,'mtmbd_year'),dw_1.getitemnumber(ll_ctr,'mtmbd_month'),dw_1.getitemnumber(ll_ctr,'mtmbd_tmown_of'),dw_1.getitemnumber(ll_ctr,'mtmbd_tmof_own'),'N') = -1 then 
					rollback using sqlca;
					return 1
				end if;	
			end if
		next
	end if
	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtebgf001a
integer x = 279
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('mtmbd_estate')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ll_year,ll_month,ls_ind)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtebgf001a
integer x = 14
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
end if

dw_1.settransobject(sqlca) 
lb_neworder = true
lb_query = false

if ls_ind='Y' then
	dw_1.modify("mtmbd_tmown_of.visible=True")
	dw_1.modify("mtmbd_tmown_of_tot.visible=True")
	dw_1.modify("mtmbd_tmof_own.visible=False")
	dw_1.modify("mtmbd_tmof_own_tot.visible=False")
else
	dw_1.modify("mtmbd_tmown_of.visible=False")
	dw_1.modify("mtmbd_tmown_of_tot.visible=False")
	dw_1.modify("mtmbd_tmof_own.visible=True")
	dw_1.modify("mtmbd_tmof_own_tot.visible=True")
end if;	

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'mtmbd_year',ll_year)
	dw_1.setitem(dw_1.getrow(),'mtmbd_month',ll_month)
	dw_1.setitem(dw_1.getrow(),'mtmbd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'mtmbd_entry_dt',datetime(today()))
	dw_1.setcolumn('mtmbd_estate')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'mtmbd_year',ll_year)
	dw_1.setitem(dw_1.getrow(),'mtmbd_month',ll_month)
	dw_1.setitem(dw_1.getrow(),'mtmbd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'mtmbd_entry_dt',datetime(today()))
	dw_1.setcolumn('mtmbd_estate')
end if

end event

type dw_1 from datawindow within w_gtebgf001a
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 3173
integer height = 1956
integer taborder = 30
string dataobject = "dw_gtebgf005a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'mtmbd_year',dw_1.getitemnumber(currentrow,'mtmbd_year'))
		dw_1.setitem(newrow,'mtmbd_month',dw_1.getitemnumber(currentrow,'mtmbd_month'))
		dw_1.setitem(newrow,'mtmbd_entry_by',dw_1.getitemstring(currentrow,'mtmbd_entry_by'))
		dw_1.setitem(newrow,'mtmbd_entry_dt',dw_1.getitemdatetime(currentrow,'mtmbd_entry_dt'))
		dw_1.setcolumn('mtmbd_estate')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'mtmbd_estate'  then
//		if  wf_check_duplicate_rec(data,dw_1.getitemnumber(row,'mtmbd_year'),dw_1.getitemnumber(row,'mtmbd_month')) = -1 then return 1  
	end if
	cb_3.enabled = true
end if	

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

