import { request } from '../utils/request'

const AMAP_KEY = '405c8e23a8d9c8d8d860f44f0a89fe56'

export function getAddressByLocation(
  longitude: number,
  latitude: number
) {

  return request(
    `/v3/geocode/regeo?location=${longitude},${latitude}&key=${AMAP_KEY}`
  )
}

export function getNearbyPoi(
  longitude: number,
  latitude: number,
  keywords: string
) {

  return request(
    `/v3/place/around?key=${AMAP_KEY}&location=${longitude},${latitude}&keywords=${keywords}&radius=1000`
  )
}