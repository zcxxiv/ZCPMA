//  This file was automatically generated and should not be edited.

import Apollo

public enum LOCATION_TYPE: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case nonFacilities
  case nonPartnerFacilities
  case partnerFacilities
  case vehicle
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Non_Facilities": self = .nonFacilities
      case "Non_Partner_Facilities": self = .nonPartnerFacilities
      case "Partner_Facilities": self = .partnerFacilities
      case "Vehicle": self = .vehicle
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .nonFacilities: return "Non_Facilities"
      case .nonPartnerFacilities: return "Non_Partner_Facilities"
      case .partnerFacilities: return "Partner_Facilities"
      case .vehicle: return "Vehicle"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: LOCATION_TYPE, rhs: LOCATION_TYPE) -> Bool {
    switch (lhs, rhs) {
      case (.nonFacilities, .nonFacilities): return true
      case (.nonPartnerFacilities, .nonPartnerFacilities): return true
      case (.partnerFacilities, .partnerFacilities): return true
      case (.vehicle, .vehicle): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class GetLocationByPlaceIdsQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetLocationByPlaceIds($placeIds: [String!], $memberId: ID!) {\n  locations: allLocations(filter: {AND: [{places_some: {placeId_in: $placeIds}}, {OR: [{type: Partner_Facilities}, {type: Non_Partner_Facilities}, {AND: [{type: Non_Facilities}, {owners_some: {id: $memberId}}]}]}]}) {\n    __typename\n    ...LocationFragment\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(LocationFragment.fragmentDefinition) }

  public var placeIds: [String]?
  public var memberId: GraphQLID

  public init(placeIds: [String]?, memberId: GraphQLID) {
    self.placeIds = placeIds
    self.memberId = memberId
  }

  public var variables: GraphQLMap? {
    return ["placeIds": placeIds, "memberId": memberId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allLocations", alias: "locations", arguments: ["filter": ["AND": [["places_some": ["placeId_in": GraphQLVariable("placeIds")]], ["OR": [["type": "Partner_Facilities"], ["type": "Non_Partner_Facilities"], ["AND": [["type": "Non_Facilities"], ["owners_some": ["id": GraphQLVariable("memberId")]]]]]]]]], type: .nonNull(.list(.nonNull(.object(Location.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(locations: [Location]) {
      self.init(unsafeResultMap: ["__typename": "Query", "locations": locations.map { (value: Location) -> ResultMap in value.resultMap }])
    }

    public var locations: [Location] {
      get {
        return (resultMap["locations"] as! [ResultMap]).map { (value: ResultMap) -> Location in Location(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Location) -> ResultMap in value.resultMap }, forKey: "locations")
      }
    }

    public struct Location: GraphQLSelectionSet {
      public static let possibleTypes = ["Location"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("formattedAddress", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("placeId", type: .nonNull(.scalar(String.self))),
        GraphQLField("places", type: .list(.nonNull(.object(Place.selections)))),
        GraphQLField("type", type: .nonNull(.scalar(LOCATION_TYPE.self))),
        GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lng", type: .nonNull(.scalar(Double.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, formattedAddress: String, title: String, placeId: String, places: [Place]? = nil, type: LOCATION_TYPE, lat: Double, lng: Double) {
        self.init(unsafeResultMap: ["__typename": "Location", "id": id, "formattedAddress": formattedAddress, "title": title, "placeId": placeId, "places": places.flatMap { (value: [Place]) -> [ResultMap] in value.map { (value: Place) -> ResultMap in value.resultMap } }, "type": type, "lat": lat, "lng": lng])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var formattedAddress: String {
        get {
          return resultMap["formattedAddress"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "formattedAddress")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var placeId: String {
        get {
          return resultMap["placeId"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "placeId")
        }
      }

      public var places: [Place]? {
        get {
          return (resultMap["places"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Place] in value.map { (value: ResultMap) -> Place in Place(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Place]) -> [ResultMap] in value.map { (value: Place) -> ResultMap in value.resultMap } }, forKey: "places")
        }
      }

      public var type: LOCATION_TYPE {
        get {
          return resultMap["type"]! as! LOCATION_TYPE
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var lat: Double {
        get {
          return resultMap["lat"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      public var lng: Double {
        get {
          return resultMap["lng"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lng")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var locationFragment: LocationFragment {
          get {
            return LocationFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Place: GraphQLSelectionSet {
        public static let possibleTypes = ["Place"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("placeId", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, placeId: String) {
          self.init(unsafeResultMap: ["__typename": "Place", "id": id, "placeId": placeId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var placeId: String {
          get {
            return resultMap["placeId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeId")
          }
        }
      }
    }
  }
}

public final class GetMemberQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetMember($memberId: ID!) {\n  Member(id: $memberId) {\n    __typename\n    ...MemberFragment\n  }\n  memberLocations: allLocations(filter: {OR: [{pickupRides_some: {member: {id: $memberId}}}, {dropOffRides_some: {member: {id: $memberId}}}]}) {\n    __typename\n    ...LocationFragment\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(MemberFragment.fragmentDefinition).appending(StudentFragment.fragmentDefinition).appending(LocationFragment.fragmentDefinition) }

  public var memberId: GraphQLID

  public init(memberId: GraphQLID) {
    self.memberId = memberId
  }

  public var variables: GraphQLMap? {
    return ["memberId": memberId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Member", arguments: ["id": GraphQLVariable("memberId")], type: .object(Member.selections)),
      GraphQLField("allLocations", alias: "memberLocations", arguments: ["filter": ["OR": [["pickupRides_some": ["member": ["id": GraphQLVariable("memberId")]]], ["dropOffRides_some": ["member": ["id": GraphQLVariable("memberId")]]]]]], type: .nonNull(.list(.nonNull(.object(MemberLocation.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(member: Member? = nil, memberLocations: [MemberLocation]) {
      self.init(unsafeResultMap: ["__typename": "Query", "Member": member.flatMap { (value: Member) -> ResultMap in value.resultMap }, "memberLocations": memberLocations.map { (value: MemberLocation) -> ResultMap in value.resultMap }])
    }

    public var member: Member? {
      get {
        return (resultMap["Member"] as? ResultMap).flatMap { Member(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Member")
      }
    }

    public var memberLocations: [MemberLocation] {
      get {
        return (resultMap["memberLocations"] as! [ResultMap]).map { (value: ResultMap) -> MemberLocation in MemberLocation(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: MemberLocation) -> ResultMap in value.resultMap }, forKey: "memberLocations")
      }
    }

    public struct Member: GraphQLSelectionSet {
      public static let possibleTypes = ["Member"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("firstName", type: .scalar(String.self)),
        GraphQLField("lastName", type: .scalar(String.self)),
        GraphQLField("email", type: .scalar(String.self)),
        GraphQLField("students", type: .list(.nonNull(.object(Student.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, email: String? = nil, students: [Student]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Member", "id": id, "firstName": firstName, "lastName": lastName, "email": email, "students": students.flatMap { (value: [Student]) -> [ResultMap] in value.map { (value: Student) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var firstName: String? {
        get {
          return resultMap["firstName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String? {
        get {
          return resultMap["lastName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var email: String? {
        get {
          return resultMap["email"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "email")
        }
      }

      public var students: [Student]? {
        get {
          return (resultMap["students"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Student] in value.map { (value: ResultMap) -> Student in Student(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Student]) -> [ResultMap] in value.map { (value: Student) -> ResultMap in value.resultMap } }, forKey: "students")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var memberFragment: MemberFragment {
          get {
            return MemberFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Student: GraphQLSelectionSet {
        public static let possibleTypes = ["Student"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("firstName", type: .scalar(String.self)),
          GraphQLField("lastName", type: .scalar(String.self)),
          GraphQLField("dob", type: .scalar(String.self)),
          GraphQLField("boosterSeat", type: .scalar(Bool.self)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, dob: String? = nil, boosterSeat: Bool? = nil) {
          self.init(unsafeResultMap: ["__typename": "Student", "id": id, "firstName": firstName, "lastName": lastName, "dob": dob, "boosterSeat": boosterSeat])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var firstName: String? {
          get {
            return resultMap["firstName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String? {
          get {
            return resultMap["lastName"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var dob: String? {
          get {
            return resultMap["dob"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "dob")
          }
        }

        public var boosterSeat: Bool? {
          get {
            return resultMap["boosterSeat"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "boosterSeat")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var studentFragment: StudentFragment {
            get {
              return StudentFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }
      }
    }

    public struct MemberLocation: GraphQLSelectionSet {
      public static let possibleTypes = ["Location"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("formattedAddress", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("placeId", type: .nonNull(.scalar(String.self))),
        GraphQLField("places", type: .list(.nonNull(.object(Place.selections)))),
        GraphQLField("type", type: .nonNull(.scalar(LOCATION_TYPE.self))),
        GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lng", type: .nonNull(.scalar(Double.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, formattedAddress: String, title: String, placeId: String, places: [Place]? = nil, type: LOCATION_TYPE, lat: Double, lng: Double) {
        self.init(unsafeResultMap: ["__typename": "Location", "id": id, "formattedAddress": formattedAddress, "title": title, "placeId": placeId, "places": places.flatMap { (value: [Place]) -> [ResultMap] in value.map { (value: Place) -> ResultMap in value.resultMap } }, "type": type, "lat": lat, "lng": lng])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var formattedAddress: String {
        get {
          return resultMap["formattedAddress"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "formattedAddress")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var placeId: String {
        get {
          return resultMap["placeId"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "placeId")
        }
      }

      public var places: [Place]? {
        get {
          return (resultMap["places"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Place] in value.map { (value: ResultMap) -> Place in Place(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Place]) -> [ResultMap] in value.map { (value: Place) -> ResultMap in value.resultMap } }, forKey: "places")
        }
      }

      public var type: LOCATION_TYPE {
        get {
          return resultMap["type"]! as! LOCATION_TYPE
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var lat: Double {
        get {
          return resultMap["lat"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lat")
        }
      }

      public var lng: Double {
        get {
          return resultMap["lng"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "lng")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var locationFragment: LocationFragment {
          get {
            return LocationFragment(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }

      public struct Place: GraphQLSelectionSet {
        public static let possibleTypes = ["Place"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("placeId", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, placeId: String) {
          self.init(unsafeResultMap: ["__typename": "Place", "id": id, "placeId": placeId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var placeId: String {
          get {
            return resultMap["placeId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "placeId")
          }
        }
      }
    }
  }
}

public struct LocationFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment LocationFragment on Location {\n  __typename\n  id\n  formattedAddress\n  title\n  placeId\n  places {\n    __typename\n    id\n    placeId\n  }\n  type\n  lat\n  lng\n}"

  public static let possibleTypes = ["Location"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("formattedAddress", type: .nonNull(.scalar(String.self))),
    GraphQLField("title", type: .nonNull(.scalar(String.self))),
    GraphQLField("placeId", type: .nonNull(.scalar(String.self))),
    GraphQLField("places", type: .list(.nonNull(.object(Place.selections)))),
    GraphQLField("type", type: .nonNull(.scalar(LOCATION_TYPE.self))),
    GraphQLField("lat", type: .nonNull(.scalar(Double.self))),
    GraphQLField("lng", type: .nonNull(.scalar(Double.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, formattedAddress: String, title: String, placeId: String, places: [Place]? = nil, type: LOCATION_TYPE, lat: Double, lng: Double) {
    self.init(unsafeResultMap: ["__typename": "Location", "id": id, "formattedAddress": formattedAddress, "title": title, "placeId": placeId, "places": places.flatMap { (value: [Place]) -> [ResultMap] in value.map { (value: Place) -> ResultMap in value.resultMap } }, "type": type, "lat": lat, "lng": lng])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var formattedAddress: String {
    get {
      return resultMap["formattedAddress"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "formattedAddress")
    }
  }

  public var title: String {
    get {
      return resultMap["title"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "title")
    }
  }

  public var placeId: String {
    get {
      return resultMap["placeId"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "placeId")
    }
  }

  public var places: [Place]? {
    get {
      return (resultMap["places"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Place] in value.map { (value: ResultMap) -> Place in Place(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Place]) -> [ResultMap] in value.map { (value: Place) -> ResultMap in value.resultMap } }, forKey: "places")
    }
  }

  public var type: LOCATION_TYPE {
    get {
      return resultMap["type"]! as! LOCATION_TYPE
    }
    set {
      resultMap.updateValue(newValue, forKey: "type")
    }
  }

  public var lat: Double {
    get {
      return resultMap["lat"]! as! Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "lat")
    }
  }

  public var lng: Double {
    get {
      return resultMap["lng"]! as! Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "lng")
    }
  }

  public struct Place: GraphQLSelectionSet {
    public static let possibleTypes = ["Place"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("placeId", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, placeId: String) {
      self.init(unsafeResultMap: ["__typename": "Place", "id": id, "placeId": placeId])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var placeId: String {
      get {
        return resultMap["placeId"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "placeId")
      }
    }
  }
}

public struct StudentFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment StudentFragment on Student {\n  __typename\n  id\n  firstName\n  lastName\n  dob\n  boosterSeat\n}"

  public static let possibleTypes = ["Student"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("firstName", type: .scalar(String.self)),
    GraphQLField("lastName", type: .scalar(String.self)),
    GraphQLField("dob", type: .scalar(String.self)),
    GraphQLField("boosterSeat", type: .scalar(Bool.self)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, dob: String? = nil, boosterSeat: Bool? = nil) {
    self.init(unsafeResultMap: ["__typename": "Student", "id": id, "firstName": firstName, "lastName": lastName, "dob": dob, "boosterSeat": boosterSeat])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var firstName: String? {
    get {
      return resultMap["firstName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var dob: String? {
    get {
      return resultMap["dob"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "dob")
    }
  }

  public var boosterSeat: Bool? {
    get {
      return resultMap["boosterSeat"] as? Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "boosterSeat")
    }
  }
}

public struct MemberFragment: GraphQLFragment {
  public static let fragmentDefinition =
    "fragment MemberFragment on Member {\n  __typename\n  id\n  firstName\n  lastName\n  email\n  students {\n    __typename\n    ...StudentFragment\n  }\n}"

  public static let possibleTypes = ["Member"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("firstName", type: .scalar(String.self)),
    GraphQLField("lastName", type: .scalar(String.self)),
    GraphQLField("email", type: .scalar(String.self)),
    GraphQLField("students", type: .list(.nonNull(.object(Student.selections)))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, email: String? = nil, students: [Student]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Member", "id": id, "firstName": firstName, "lastName": lastName, "email": email, "students": students.flatMap { (value: [Student]) -> [ResultMap] in value.map { (value: Student) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  public var firstName: String? {
    get {
      return resultMap["firstName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "firstName")
    }
  }

  public var lastName: String? {
    get {
      return resultMap["lastName"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "lastName")
    }
  }

  public var email: String? {
    get {
      return resultMap["email"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "email")
    }
  }

  public var students: [Student]? {
    get {
      return (resultMap["students"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Student] in value.map { (value: ResultMap) -> Student in Student(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Student]) -> [ResultMap] in value.map { (value: Student) -> ResultMap in value.resultMap } }, forKey: "students")
    }
  }

  public struct Student: GraphQLSelectionSet {
    public static let possibleTypes = ["Student"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("firstName", type: .scalar(String.self)),
      GraphQLField("lastName", type: .scalar(String.self)),
      GraphQLField("dob", type: .scalar(String.self)),
      GraphQLField("boosterSeat", type: .scalar(Bool.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, firstName: String? = nil, lastName: String? = nil, dob: String? = nil, boosterSeat: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Student", "id": id, "firstName": firstName, "lastName": lastName, "dob": dob, "boosterSeat": boosterSeat])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var firstName: String? {
      get {
        return resultMap["firstName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "firstName")
      }
    }

    public var lastName: String? {
      get {
        return resultMap["lastName"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "lastName")
      }
    }

    public var dob: String? {
      get {
        return resultMap["dob"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "dob")
      }
    }

    public var boosterSeat: Bool? {
      get {
        return resultMap["boosterSeat"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "boosterSeat")
      }
    }

    public var fragments: Fragments {
      get {
        return Fragments(unsafeResultMap: resultMap)
      }
      set {
        resultMap += newValue.resultMap
      }
    }

    public struct Fragments {
      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var studentFragment: StudentFragment {
        get {
          return StudentFragment(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }
    }
  }
}