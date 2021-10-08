//
//  ComplicationController.swift
//  Watch App WatchKit Extension
//
//  Created by Paul Plant on 5/10/21.
//  Copyright © 2021 Johan Degraeve. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "xdrip", supportedFamilies: CLKComplicationFamily.allCases)
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        handler(nil)
    }

    // MARK: - Sample Templates
    
//    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
//        // This method will be called once per supported complication, and the results will be cached
//        handler(nil)
//    }
    
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = getLocalizableSampleTemplate(for: complication.family)
        handler(template)
    }

    // basic templates copied from LoopKit and updated for WatchOS 7.0
    func getLocalizableSampleTemplate(for family: CLKComplicationFamily) -> CLKComplicationTemplate? {
        let valueText = CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "120↘︎")
//        let glucoseText = CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "120")
        let minsAgoText = CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "3MIN")

        switch family {
        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackText.init(line1TextProvider: valueText, line2TextProvider: minsAgoText)
            return template
        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody.init(headerTextProvider: minsAgoText, bodyTextProvider: valueText)
            return template
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallSimpleText.init(textProvider: valueText)
            return template
        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeStackText.init(line1TextProvider: valueText, line2TextProvider: minsAgoText)
            return template
        case .utilitarianSmall, .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat.init(textProvider: valueText)
            return template
        case .utilitarianLarge:
            let eventualGlucoseText = CLKSimpleTextProvider.localizableTextProvider(withStringsFileTextKey: "75")
            let template = CLKComplicationTemplateUtilitarianLargeFlat.init(textProvider: CLKSimpleTextProvider.localizableTextProvider(withStringsFileFormatKey: "UtilitarianLargeFlat", textProviders: [valueText, eventualGlucoseText, CLKTimeTextProvider(date: Date())]))
            return template
        case .graphicCorner, .graphicCircular, .graphicBezel, .graphicRectangular, .graphicExtraLarge:
            return nil
            
        @unknown default:
            return nil
        }
    }
    
}
