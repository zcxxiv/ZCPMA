//
//  VerticalCalendarController.swift
//  VACalendar
//
//  Created by Anton Vodolazkyi on 20.02.18.
//  Copyright © 2018 Vodolazkyi. All rights reserved.
//

import UIKit
import VACalendar

final class ExcludingDaysViewController: UIViewController {
  
  @IBOutlet weak var weekDaysView: VAWeekDaysView! {
    didSet {
      let appereance = VAWeekDaysViewAppearance(symbolsType: .short, calendar: defaultCalendar)
      weekDaysView.appearance = appereance
    }
  }
  
  let defaultCalendar: Calendar = {
    var calendar = Calendar.current
    calendar.firstWeekday = 1
    calendar.timeZone = TimeZone.current
    return calendar
  }()
  
  var calendarView: VACalendarView!
  
  @IBAction func done(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    let startDate = formatter.date(from: "2018-06-24")!
    let endDate = formatter.date(from: "2018-11-30")!
    
    let selectedDays = [
      formatter.date(from: "2018-07-25")!,
      formatter.date(from: "2018-07-26")!,
      formatter.date(from: "2018-07-27")!,
      formatter.date(from: "2018-07-28")!,
      formatter.date(from: "2018-07-29")!,
      ]
    
    let calendar = VACalendar(
      startDate: startDate,
      endDate: endDate,
      calendar: defaultCalendar
    )
    calendarView = VACalendarView(frame: .zero, calendar: calendar)
    calendarView.setAvailableDates(DaysAvailability.some(selectedDays))
    calendarView.showDaysOut = false
    calendarView.selectionStyle = .multi
    calendarView.dayViewAppearanceDelegate = self
    calendarView.monthViewAppearanceDelegate = self
    calendarView.calendarDelegate = self
    calendarView.scrollDirection = .vertical
    calendarView.selectDates(selectedDays)
    view.addSubview(calendarView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if calendarView.frame == .zero {
      calendarView.frame = CGRect(
        x: 0,
        y: weekDaysView.frame.maxY,
        width: view.frame.width,
        height: view.frame.height - weekDaysView.frame.maxY
      )
      calendarView.setup()
    }
  }
  
}

extension ExcludingDaysViewController: VAMonthViewAppearanceDelegate {
  
  func leftInset() -> CGFloat {
    return 10.0
  }
  
  func rightInset() -> CGFloat {
    return 10.0
  }
  
  func verticalMonthTitleFont() -> UIFont {
    return UIFont.systemFont(ofSize: 16, weight: .semibold)
  }
  
  func verticalMonthTitleColor() -> UIColor {
    return .black
  }
  
  func verticalCurrentMonthTitleColor() -> UIColor {
    return .red
  }
  
}

extension ExcludingDaysViewController: VADayViewAppearanceDelegate {
  
  func textColor(for state: VADayState) -> UIColor {
    switch state {
    case .out:
      return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
    case .selected:
      return .white
    case .unavailable:
      return .lightGray
    default:
      return .black
    }
  }
  
  func textBackgroundColor(for state: VADayState) -> UIColor {
    switch state {
    case .selected:
      return UIColor(red: 58 / 255, green: 174 / 255, blue: 228 / 255, alpha: 1.0)
    default:
      return .clear
    }
  }
  
  func shape() -> VADayShape {
    return .circle
  }
  
  func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
    switch state {
    case .selected:
      return 2
    default:
      return -7
    }
  }
  
}

extension ExcludingDaysViewController: VACalendarViewDelegate {
  
  func selectedDate(_ date: Date) {
    print(date)
  }
  
}
