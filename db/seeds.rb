V0::Api::Models::GpsReading.create [
  {
    timestamp: "2018-07-14T04:15:00.000 UTC",
    latitude: "-33.9111",
    longitude: "151.111"
  },

  {
    timestamp: "2018-07-14T04:25:00.000 UTC",
    latitude: "-33.9112",
    longitude: "151.122"
  },

  {
    timestamp: "2018-07-14T04:35:00.000 UTC",
    latitude: "-33.9133",
    longitude: "151.113"
  },

  {
    timestamp: "2018-07-14T04:45:00.000 UTC",
    latitude: "-33.9114",
    longitude: "151.144"
  }
]

V0::Api::Models::Meter.create [
  {
    name: "TV",
    url: "http://192.168.2.36"
  },

  {
    name: "Oven",
    url: "http://192.168.2.37"
  },

  {
    name: "Fridge",
    url: "http://192.168.2.38"
  },


]

V0::Api::Models::MeterReading.create [
  {
    meter_id: 1,
    timestamp: "2018-06-14T04:15:00.000 UTC",
    consumption: "1.23",
  },

  {
    meter_id: 1,
    timestamp: "2018-06-14T04:16:00.000 UTC",
    consumption: "1.14",
  },

  {
    meter_id: 1,
    timestamp: "2018-06-14T04:17:00.000 UTC",
    consumption: "1.32",
  },

  {
    meter_id: 1,
    timestamp: "2018-07-14T04:15:00.000 UTC",
    consumption: "1.63",
  },

  {
    meter_id: 1,
    timestamp: "2018-07-14T04:16:00.000 UTC",
    consumption: "1.64",
  },

  {
    meter_id: 1,
    timestamp: "2018-07-14T04:17:00.000 UTC",
    consumption: "1.62",
  },


]
