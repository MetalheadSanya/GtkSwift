//
//  Adjustment.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 16.04.16.
//
//

import CGTK
import gobjectswift

/// The `Adjustment` object represents a value which has an associated lower and
/// upper bound, together with step and page increments, and a page size. It is
/// used within several GTK+ widgets, including `SpinButton`, `Viewport`, and
/// `Range` (which is a base class for `Scrollbar` and `Scale`).
///
/// The `Adjustment` object does not update the value itself. Instead it is left
/// up to the owner of the `Adjustment` to control the value.
public class Adjustment: Object {
	internal var n_Adjustment: UnsafeMutablePointer<GtkAdjustment>
	
	internal init(n_Adjustment: UnsafeMutablePointer<GtkAdjustment>) {
		self.n_Adjustment = n_Adjustment
		super.init(n_Object: UnsafeMutablePointer<GObject>(n_Adjustment))
	}
	
	/// Creates a new `Adjustment`.
	///
	/// - Parameter value: the initial value
	/// - Parameter lower: the minimum value
	/// - Parameter upper: the maximum value
	/// - Parameter stepIncrement: the step increment
	/// - Parameter pageIncrement: pageIncrement
	/// - Parameter pageSize: the page size
	public convenience init(value: Double, lower: Double, upper: Double,
	                        stepIncrement: Double, pageIncrement: Double,
	                        pageSize: Double) {
		self.init(n_Adjustment: UnsafeMutablePointer<GtkAdjustment>(
			gtk_adjustment_new(gdouble(value), gdouble(lower), gdouble(upper),
			                   gdouble(stepIncrement), gdouble(pageIncrement),
			                   gdouble(pageSize))))
	}
	
	/// The value of the adjustment.
	public var value: Double {
		set {
			gtk_adjustment_set_value(n_Adjustment, gdouble(newValue))
		}
		get {
			return Double(gtk_adjustment_get_value(n_Adjustment))
		}
	}
	
	/// Updates the `value` property to ensure that the range between `lower` and
	/// `upper` is in the current page (i.e. between `value` and `value` +
	/// `pageSize`). If the range is larger than the page size, then only the
	/// start of it will be in the current page.
	///
	/// A `valueChangedSignal` will be emitted if the value is changed.
	///
	/// - Parameter lower: the lower value
	/// - Parameter upper: the upper value
	public func clampPage(lower: Double, upper: Double) {
		gtk_adjustment_clamp_page(n_Adjustment, gdouble(lower), gdouble(upper))
	}
	
	/// Sets all properties of the adjustment at once.
	///
	/// Use this function to avoid multiple emissions of the `changedSignal`. See
	/// `lower` property for an alternative way of compressing multiple emissions
	/// of `changedSignal` into one.
	///
	/// - Parameter value: the new value
	/// - Parameter lower: the new minimum value
	/// - Parameter upper: the new maximum value
	/// - Parameter stepIncrement: the new step increment
	/// - Parameter pageIncrement: the new page increment
	/// - Parameter pageSize: the new page size
	public func configure(value: Double, lower: Double, upper: Double,
	                      stepIncrement: Double, pageIncrement: Double,
	                      pageSize: Double) {
		gtk_adjustment_configure(n_Adjustment, gdouble(value), gdouble(lower),
		                         gdouble(upper), gdouble(stepIncrement),
		                         gdouble(pageIncrement), gdouble(pageSize))
	}
	
	/// The minimum value of the adjustment.
	public var lower: Double {
		set {
			gtk_adjustment_set_lower(n_Adjustment, gdouble(newValue))
		}
		get {
			return Double(gtk_adjustment_get_lower(n_Adjustment))
		}
	}
	
	/// The page increment of the adjustment.
	public var pageIncrement: Double {
		set {
			gtk_adjustment_set_page_increment(n_Adjustment, gdouble(newValue))
		}
		get {
			return Double(gtk_adjustment_get_page_increment(n_Adjustment))
		}
	}
	
	/// The page size of the adjustment. Note that the page-size is irrelevant and
	/// should be set to zero if the adjustment is used for a simple scalar value,
	/// e.g. in a `SpinButton`.
	public var pageSize: Double {
		set {
			gtk_adjustment_set_page_size(n_Adjustment, gdouble(newValue))
		}
		get {
			return Double(gtk_adjustment_get_page_size(n_Adjustment))
		}
	}
	
	/// The step increment of the adjustment.
	public var stepIncrement: Double {
		set {
			gtk_adjustment_set_step_increment(n_Adjustment, gdouble(newValue))
		}
		get {
			return Double(gtk_adjustment_get_step_increment(n_Adjustment))
		}
	}
	
	/// The maximum value of the adjustment. Note that values will be restricted 
	/// by `upper - pageSize` if the page-size property is nonzero.
	public var upper: Double {
		set {
			gtk_adjustment_set_upper(n_Adjustment, gdouble(newValue))
		}
		get {
			return Double(gtk_adjustment_get_upper(n_Adjustment))
		}
	}
	
	/// The smaller of step increment and page increment.
	public var minimumIncrement: Double {
		return Double(gtk_adjustment_get_minimum_increment(n_Adjustment))
	}
	
	// MARK: - Signals
	
	/// - Parameter box: the object which received the signal
	public typealias ChangedCallback = (
		adjustment: Adjustment)
		-> Void
	public typealias ChangedNative = (
		UnsafeMutablePointer<GtkAdjustment>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// Emitted when one or more of the `Adjustment` properties have been changed,
	/// other than the `value` property.
	public lazy var changedSignal:
		Signal<ChangedCallback, Adjustment, ChangedNative> =
		Signal(obj: self, signal: "changed", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<Adjustment,
																ChangedCallback>.self)
			
			let adjustment = data.obj
			let action = data.function
			
			action(adjustment: adjustment)
		})
	
	/// - Parameter box: the object which received the signal
	public typealias ValueChangedCallback = (
		adjustment: Adjustment)
		-> Void
	public typealias ValueChangedNative = (
		UnsafeMutablePointer<GtkAdjustment>,
		UnsafeMutablePointer<gpointer>)
		-> Void
	
	/// Emitted when the `value` property has been changed.
	public lazy var valueChangedSignal:
		Signal<ValueChangedCallback, Adjustment, ValueChangedNative> =
		Signal(obj: self, signal: "value-changed", c_handler: {
			_, user_data in
			let data = unsafeBitCast(user_data,
			                         to: SignalData<Adjustment,
																ValueChangedCallback>.self)
			
			let adjustment = data.obj
			let action = data.function
			
			action(adjustment: adjustment)
		})

}
