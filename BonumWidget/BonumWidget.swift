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
        
        // Generate a timeline consisting of one entrie a minute apart, starting from the current date.
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 60, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, configuration: configuration)
        entries.append(entry)
        
        // let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
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
    let trueDateW = UserDefaults.group.object(forKey: "trueDateW") as? Date ?? Date()
    
    var dateS: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr")
        formatter.dateFormat = "d MMM y, HH:mm"
        return formatter.string(from: trueDateW)
    }
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        
        switch family {
        case .systemSmall:
            ZStack{
                Image("Jump")
                    .resizable()
                    .scaledToFill()
                    .overlay(RoundedRectangle(cornerRadius: 22)
                                .stroke(Color("AppColor1"), lineWidth: 10))
                    .cornerRadius(10.0)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                VStack{
                    Text(trueDateW, style: .timer)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                    Text("depuis votre denière mise à jour.")
                        .font(.system(size: 14))
                    Text("Go")
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                        .foregroundColor(Color("AppColor1"))
                        .frame(width: 30, height: 30, alignment: .center)
                        .background(Color("AppColor3"))
                        .cornerRadius(6)
                }
                .foregroundColor(Color("AppColor3"))
                .padding()
            }
            
        default:
            ZStack{
                Color("AppColor3")
                
                HStack {
                    Image("Jump")
                        .resizable()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10.0)
                        .scaledToFill()
                        .padding(.horizontal, 10)
                    
                    //Text(userName)
                    VStack (alignment: .leading) {
                        HStack (alignment: .center) {
                            Text(trueDateW, style: .timer)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                + Text(" que vous n'avez pas dit à Bonum comment vous vous sentez.\n")
                        }
                        .foregroundColor(Color("AppColor1"))
                        .padding(.trailing, 10)
                        
                        HStack{
                            Text("Voulez-vous le faire ?")
                                .foregroundColor(Color("AppColor1"))
                                .padding(.trailing, 10)
                            Text("Go")
                                .fontWeight(.bold)
                                .foregroundColor(Color("AppColor3"))
                                .frame(width: 30, height: 30, alignment: .center)
                                .background(Color("AppColor1"))
                                .cornerRadius(6)
                        }
                    }
                    .font(.system(size: 14))
                }
                
            }
            
        }
        
    }
}
extension UserDefaults {
    static let group = UserDefaults(suiteName: "group.bonum")!
}


@main
struct BonumWidget: Widget {
    let kind: String = "BonumWidget"  // Le nom qui permet de raffraichir le widget depuis l'app
    
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
        
        BonumWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
