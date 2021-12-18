// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct HistoryResponse: Codable {
    let success: String
    let data: [HistoryData]
    let message: String
}

// MARK: - WelcomeDatum
struct HistoryData: Codable {
    let ordersID: Int
    let totalTax: String
    let customersID: Int
    let deliveryID: JSONNull?
    let customersName: String
    let customersCompany: JSONNull?
    let customersStreetAddress, customersSuburb, customersCity, customersPostcode: String
    let customersState, customersCountry, customersTelephone, email: String
    let customersAddressFormatID: JSONNull?
    let deliveryName: String
    let deliveryCompany: JSONNull?
    let deliveryStreetAddress, deliverySuburb, deliveryCity, deliveryPostcode: String
    let deliveryState, deliveryCountry: String
    let deliveryAddressFormatID: JSONNull?
    let billingName: String
    let billingCompany: JSONNull?
    let billingStreetAddress, billingSuburb, billingCity, billingPostcode: String
    let billingState, billingCountry: String
    let billingAddressFormatID: Int
    let paymentMethod: String
    let ccType, ccOwner, ccNumber, ccExpires: JSONNull?
    let lastModified, datePurchased: String
    let ordersDateFinished: JSONNull?
    let currency, currencyValue, orderPrice, shippingCost: String
    let shippingMethod: String
    let shippingDuration: JSONNull?
    let orderInformation: String
    let isSeen: Int
    let couponAmount: String
    let excludeProductIDS, productCategories, excludedProductCategories: [JSONAny]
    let freeShipping: Int
    let productIDS: [JSONAny]
    let orderedSource: Int
    let deliveryPhone, billingPhone: String
    let transactionID, createdAt, updatedAt: JSONNull?
    let discountType, amount, usageLimit, coupons: [JSONAny]
    let ordersStatusID: Int
    let ordersStatus: String
    let customerComments: JSONNull?
    let adminComments: String
    let data: [DatumDatum]

    enum CodingKeys: String, CodingKey {
        case ordersID = "orders_id"
        case totalTax = "total_tax"
        case customersID = "customers_id"
        case deliveryID = "delivery_id"
        case customersName = "customers_name"
        case customersCompany = "customers_company"
        case customersStreetAddress = "customers_street_address"
        case customersSuburb = "customers_suburb"
        case customersCity = "customers_city"
        case customersPostcode = "customers_postcode"
        case customersState = "customers_state"
        case customersCountry = "customers_country"
        case customersTelephone = "customers_telephone"
        case email
        case customersAddressFormatID = "customers_address_format_id"
        case deliveryName = "delivery_name"
        case deliveryCompany = "delivery_company"
        case deliveryStreetAddress = "delivery_street_address"
        case deliverySuburb = "delivery_suburb"
        case deliveryCity = "delivery_city"
        case deliveryPostcode = "delivery_postcode"
        case deliveryState = "delivery_state"
        case deliveryCountry = "delivery_country"
        case deliveryAddressFormatID = "delivery_address_format_id"
        case billingName = "billing_name"
        case billingCompany = "billing_company"
        case billingStreetAddress = "billing_street_address"
        case billingSuburb = "billing_suburb"
        case billingCity = "billing_city"
        case billingPostcode = "billing_postcode"
        case billingState = "billing_state"
        case billingCountry = "billing_country"
        case billingAddressFormatID = "billing_address_format_id"
        case paymentMethod = "payment_method"
        case ccType = "cc_type"
        case ccOwner = "cc_owner"
        case ccNumber = "cc_number"
        case ccExpires = "cc_expires"
        case lastModified = "last_modified"
        case datePurchased = "date_purchased"
        case ordersDateFinished = "orders_date_finished"
        case currency
        case currencyValue = "currency_value"
        case orderPrice = "order_price"
        case shippingCost = "shipping_cost"
        case shippingMethod = "shipping_method"
        case shippingDuration = "shipping_duration"
        case orderInformation = "order_information"
        case isSeen = "is_seen"
        case couponAmount = "coupon_amount"
        case excludeProductIDS = "exclude_product_ids"
        case productCategories = "product_categories"
        case excludedProductCategories = "excluded_product_categories"
        case freeShipping = "free_shipping"
        case productIDS = "product_ids"
        case orderedSource = "ordered_source"
        case deliveryPhone = "delivery_phone"
        case billingPhone = "billing_phone"
        case transactionID = "transaction_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case discountType = "discount_type"
        case amount
        case usageLimit = "usage_limit"
        case coupons
        case ordersStatusID = "orders_status_id"
        case ordersStatus = "orders_status"
        case customerComments = "customer_comments"
        case adminComments = "admin_comments"
        case data
    }
}

// MARK: - DatumDatum
struct DatumDatum: Codable {
    let ordersProductsID, ordersID, productsID: Int
    let productsModel: JSONNull?
    let productsName, productsPrice, finalPrice, productsTax: String
    let productsQuantity: Int
    let image: String
    let categories: [Category]
    let attributes: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case ordersProductsID = "orders_products_id"
        case ordersID = "orders_id"
        case productsID = "products_id"
        case productsModel = "products_model"
        case productsName = "products_name"
        case productsPrice = "products_price"
        case finalPrice = "final_price"
        case productsTax = "products_tax"
        case productsQuantity = "products_quantity"
        case image, categories, attributes
    }
}

// MARK: - Category
struct Category: Codable {
    let categoriesID: Int
    let categoriesName, categoriesImage, categoriesIcon: String
    let parentID: Int

    enum CodingKeys: String, CodingKey {
        case categoriesID = "categories_id"
        case categoriesName = "categories_name"
        case categoriesImage = "categories_image"
        case categoriesIcon = "categories_icon"
        case parentID = "parent_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
