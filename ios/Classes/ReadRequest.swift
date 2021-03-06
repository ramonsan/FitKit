//
// Created by Martin Anderson on 2019-03-10.
//

import HealthKit

class ReadRequest {
    let type: String
    let sampleType: HKSampleType
    let unit: HKUnit

    let dateFrom: Date
    let dateTo: Date

    private init(type: String, sampleType: HKSampleType, unit: HKUnit, dateFrom: Date, dateTo: Date) {
        self.type = type;
        self.sampleType = sampleType
        self.unit = unit
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }

    static func fromCall(call: FlutterMethodCall) throws -> ReadRequest {
        guard let arguments = call.arguments as? Dictionary<String, Any>,
              let type = arguments["type"] as? String,
              let dateFromEpoch = arguments["date_from"] as? NSNumber,
              let dateToEpoch = arguments["date_to"] as? NSNumber else {
            throw "invalid call arguments \(call.arguments)";
        }

        let sampleType = try HKSampleType.fromDartType(type: type)
        let unit = try HKUnit.fromDartType(type: type)
        let dateFrom = Date(timeIntervalSince1970: dateFromEpoch.doubleValue / 1000)
        let dateTo = Date(timeIntervalSince1970: dateToEpoch.doubleValue / 1000)

        return ReadRequest(type: type, sampleType: sampleType, unit: unit, dateFrom: dateFrom, dateTo: dateTo)
    }
}
