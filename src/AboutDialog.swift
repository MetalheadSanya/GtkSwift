//
//  AboutDialog.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 13.04.16.
//
//

import CGTK
import gobjectswift

public typealias AboutDialogActivateLinkCallback = (AboutDialog, String) -> Bool

public class AboutDialog: Dialog {
	internal var n_AboutDialog: UnsafeMutablePointer<GtkAboutDialog>
	
	internal init(n_AboutDialog: UnsafeMutablePointer<GtkAboutDialog>) {
		self.n_AboutDialog = n_AboutDialog
		super.init(n_Dialog: UnsafeMutablePointer<GtkDialog>(n_AboutDialog))
	}
	
	public convenience init() {
		let n_AboutDialog = UnsafeMutablePointer<GtkAboutDialog>(gtk_about_dialog_new())
		self.init(n_AboutDialog: n_AboutDialog!)
	}
	
	public var programName: String {
		get {
			return String(cString: gtk_about_dialog_get_program_name(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_program_name(n_AboutDialog, newValue)
		}
	}
	
	public var version: String {
		get {
			return String(cString: gtk_about_dialog_get_version(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_version(n_AboutDialog, newValue)
		}
	}
	
	public var copyright: String {
		get {
			return String(cString: gtk_about_dialog_get_copyright(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_copyright(n_AboutDialog, newValue)
		}
	}
	
	public var comments: String {
		get {
			return String(cString: gtk_about_dialog_get_comments(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_comments(n_AboutDialog, newValue)
		}
	}
	
	public var license: String {
		get {
			return String(cString: gtk_about_dialog_get_license(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_license(n_AboutDialog, newValue)
		}
	}
	
	public var wrapLicense: Bool {
		get {
			return gtk_about_dialog_get_wrap_license(n_AboutDialog) != 0 ? true : false
		}
		set {
			gtk_about_dialog_set_wrap_license(n_AboutDialog, newValue ? 1 : 0)
		}
	}
	
	public var licenseType: License {
		get {
			return License(rawValue: gtk_about_dialog_get_license_type(n_AboutDialog))!
		}
		set {
			gtk_about_dialog_set_license_type(n_AboutDialog, newValue.rawValue)
		}
	}
	
	public var website: String {
		get {
			return String(cString: gtk_about_dialog_get_website(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_website(n_AboutDialog, newValue)
		}
	}
	
	public var websiteLabel: String {
		get {
			return String(cString: gtk_about_dialog_get_website_label(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_website_label(n_AboutDialog, newValue)
		}
	}
	
	// TODO: set
	public var authors: [String] {
		get {
			var n_Authors = gtk_about_dialog_get_authors(n_AboutDialog)
			
			var authors = [String]()
			while n_Authors.pointee != nil {
				authors.append(String(cString: n_Authors.pointee!))
				n_Authors = n_Authors.advanced(by: 1)
			}
			
			return authors
		}
//		set {
//			let authorsCount = newValue.count
//		
//			let n_Authors = UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>(allocatingCapacity: authorsCount)
//			
//			var index = 0
//			for author in newValue {
//				n_Authors.advanced(by: index).pointee = author
//				index += 1
//			}
//			
//			n_Authors.advanced(by: index).pointee = nil
//		}
	}
	
	// TODO: set
	public var artists: [String] {
		get {
			var n_Artists = gtk_about_dialog_get_artists(n_AboutDialog)
			
			var artists = [String]()
			while n_Artists.pointee != nil {
				artists.append(String(cString: n_Artists.pointee!))
				n_Artists = n_Artists.advanced(by: 1)
			}
			
			return artists
		}
	}
	
	// TODO: set
	public var documenters: [String] {
		get {
			var n_Documenters = gtk_about_dialog_get_documenters(n_AboutDialog)
			
			var documenters = [String]()
			while n_Documenters.pointee != nil {
				documenters.append(String(cString: n_Documenters.pointee!))
				n_Documenters = n_Documenters.advanced(by: 1)
			}
			
			return documenters
		}
	}
	
	public var translatorCredits: String {
		get {
			return String(cString: gtk_about_dialog_get_translator_credits(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_translator_credits(n_AboutDialog, newValue)
		}
	}
	
	// TODO: gtk_about_dialog_get_logo and gtk_about_dialog_set_logo
	
	public var logoIconName: String {
		get {
			return String(cString: gtk_about_dialog_get_logo_icon_name(n_AboutDialog))
		}
		set {
			gtk_about_dialog_set_logo_icon_name(n_AboutDialog, newValue)
		}
	}
	
	public typealias AboutDialogActivateLinkNative = @convention(c)(UnsafeMutablePointer<GtkAboutDialog>, UnsafeMutablePointer<CChar>, gpointer) -> Void
	
	public lazy var activateLinkSignal: Signal<AboutDialogActivateLinkCallback, AboutDialog, AboutDialogActivateLinkNative>
		= Signal(obj: self, signal: "activate-link", c_handler: {
			(_, n_Uri, user_data) in
			let data = unsafeBitCast(user_data, to: SignalData<AboutDialog, AboutDialogActivateLinkCallback>.self)
			
			let widget = data.obj
			let uri = String(cString: n_Uri)
			let action = data.function
			
			action(widget, uri)
		})
}
