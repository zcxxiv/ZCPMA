//  This file was automatically generated and should not be edited.

import Apollo

public final class GetMemberQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetMember($memberId: ID!) {\n  Member(id: $memberId) {\n    __typename\n    ...MemberFragment\n  }\n}"

  public var queryDocument: String { return operationDefinition.appending(MemberFragment.fragmentDefinition).appending(StudentFragment.fragmentDefinition) }

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
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(member: Member? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Member": member.flatMap { (value: Member) -> ResultMap in value.resultMap }])
    }

    public var member: Member? {
      get {
        return (resultMap["Member"] as? ResultMap).flatMap { Member(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Member")
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