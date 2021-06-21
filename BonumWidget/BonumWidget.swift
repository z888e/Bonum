//
//  BonumWidget.swift
//  BonumWidget
//
//  Created by Wilfried Roguet on 20/06/2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct BonumWidgetEntryView : View {
    var entry: Provider.Entry

//    var userName = UserDefaults.standard.object(forKey: "userName") as? String ?? "No name"
    let dateW = UserDefaults.group.object(forKey: "dateW") as? String ?? "No date"

    var body: some View {
        HStack{
            Image("Jump")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10.0)
                .scaledToFill()
            
//Text(userName)
            VStack (alignment: .leading){
            Text("Date de dernière mise à jour de l'état de forme :")
                Text(dateW)
                    .fontWeight(.bold)
    }
        }
}
}
extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.bonum")!
}


@main
struct BonumWidget: Widget {
    let kind: String = "BonumWidget"

    var body: some WidgetConfiguration {
            
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            BonumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Bonum Widget")
        .description("Widget affichant la date de denière enregistrement de l'état de forme Bonum.")
    }
}
    


struct BonumWidget_Previews: PreviewProvider {
    static var previews: some View {
        BonumWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
