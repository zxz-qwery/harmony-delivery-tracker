import geoLocationManager from '@ohos.geoLocationManager'

export interface LocationData {
  latitude: number
  longitude: number
}

export function getCurrentLocation(): Promise<LocationData> {

  return new Promise((resolve, reject) => {

    geoLocationManager.getCurrentLocation(
      (err, location) => {

        if (err) {

          reject(err)

        } else {

          resolve({
            latitude: location.latitude,
            longitude: location.longitude
          })
        }
      }
    )
  })
}