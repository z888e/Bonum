//
//  Bonum_Test_Widget.swift
//  Bonum Test Widget
//
//  Created by Wilfried Roguet on 11/06/2021.
// Affiche la date et l'heure avec 3 refresh successifs toutes les 10s, relancé toutes les 3 minutes
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), refreshNb: 0, configuration: ConfigurationIntent())
        
    }

    /// To show your widget in the widget gallery, WidgetKit asks the provider for a preview snapshot.
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        let entry = SimpleEntry(date: Date(), refreshNb: 0, configuration: configuration)

        completion(entry)
    }

    /// After requesting the initial snapshot, WidgetKit calls getTimeline(in:completion:) to request a regular timeline from the provider. The timeline consists of one or more timeline entries and a reload policy that informs WidgetKit when to request a subsequent timeline.
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
 
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 4 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset*10, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, refreshNb: hourOffset, configuration: configuration)
            entries.append(entry)
        }

        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 3, to: currentDate)!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
        // Autre policy possible :
        //    .atEnd, qui recharge aussitôt la timeLine
        //    .never, qui ne recharge plus la timeLine
        
        /// Call the completion to pass the timeline to WidgetKit.
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let refreshNb: Int
//    let widgetURL: URL
    let configuration: ConfigurationIntent
}

struct Bonum_Test_WidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack{
            Image("storm")
                .resizable()
                .scaledToFill()
        
        VStack{
            Text("Nous sommes le :")
            Text(entry.date, style: .date)
                .fontWeight(.bold)
            Text("Il est :")
            Text(entry.date, style: .time)
                .fontWeight(.bold)
            Text("MàJ n° \(entry.refreshNb), il y a :")
            Text(entry.date, style: .timer)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            HStack(alignment: .top) {
                Link(destination: URL(string: "weather://hail")!) {
                    Image(systemName: "cloud.hail")
                }
                Spacer()
                Link(destination: URL(string: "weather://thunder")!) {
                    Image(systemName: "cloud.bolt.rain")
                }
                Spacer()
                Link(destination: URL(string: "weather://tropical")!) {
                    Image(systemName: "tropicalstorm")
                }
            }
            .frame(width: 100)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))

            }
        .foregroundColor(.white)
        .font(.footnote)
//        .widgetURL(entry.widgetURL)
    }
    }
}

@main
struct Bonum_Test_Widget: Widget {
    let kind: String = "Bonum_Test_Widget"

    var body: some WidgetConfiguration {
        
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Bonum_Test_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Widget Bonum")
        .description("Un exemple de widget de Wil.")
        
    }
}

struct Bonum_Test_Widget_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewEntry: Provider.Entry = SimpleEntry(date: Date(), refreshNb: 0, configuration: ConfigurationIntent())

        Group{
            Bonum_Test_WidgetEntryView(entry: previewEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))

            Bonum_Test_WidgetEntryView(entry: previewEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
        
            Bonum_Test_WidgetEntryView(entry: previewEntry)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
