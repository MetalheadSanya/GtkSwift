//
//  AssistantPageType.swift
//  GTK-swift
//
//  Created by Alexander Zalutskiy on 13.04.16.
//
//

import CGTK

public enum AssistantPageType: RawRepresentable {
	case Content, Intro, Confirm, Summary, Progress, Custom
	
	public typealias RawValue = GtkAssistantPageType
	
	public var rawValue: RawValue {
		switch self {
		case .Content:
			return GTK_ASSISTANT_PAGE_CONTENT
		case .Intro:
			return GTK_ASSISTANT_PAGE_INTRO
		case .Confirm:
			return GTK_ASSISTANT_PAGE_CONFIRM
		case .Summary:
			return GTK_ASSISTANT_PAGE_SUMMARY
		case .Progress:
			return GTK_ASSISTANT_PAGE_PROGRESS
		case .Custom:
			return GTK_ASSISTANT_PAGE_CUSTOM
		}
	}
	
	public init?(rawValue: RawValue) {
		switch rawValue {
		case GTK_ASSISTANT_PAGE_CONTENT:
			self = .Content
		case GTK_ASSISTANT_PAGE_INTRO:
			self = .Intro
		case GTK_ASSISTANT_PAGE_CONFIRM:
			self = .Confirm
		case GTK_ASSISTANT_PAGE_SUMMARY:
			self = .Summary
		case GTK_ASSISTANT_PAGE_PROGRESS:
			self = .Progress
		case GTK_ASSISTANT_PAGE_CUSTOM:
			self = .Custom
		default:
			return nil
		}
	}
}
