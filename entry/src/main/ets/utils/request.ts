import http from '@ohos.net.http'

const BASE_URL = 'https://restapi.amap.com'

interface ApiResponse {
  regeocode: {
    formatted_address: string;
  };
}

export function request(url: string): Promise<ApiResponse> {
  return new Promise((resolve, reject) => {

    const httpRequest = http.createHttp()

    httpRequest.request(
      BASE_URL + url,
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      },
      (err, data) => {

        if (!err) {

          try {
            const result = JSON.parse(data.result as string)
            resolve(result)
          } catch (e) {
            reject(e)
          }

        } else {
          reject(err)
        }

        httpRequest.destroy()
      }
    )
  })
}