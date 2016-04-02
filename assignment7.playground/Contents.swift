// Assignment 7 playground

import UIKit
import XCPlayground
import Foundation
// import SwiftyJSON

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true


//TODO one: Write and call a function that make a successful network connection to google.com using core networking APIs, then print out the results.


func networkConnect() {

    let targetURL = "http://google.com"

    if let url = NSURL(string: targetURL) {
        
            let urlSession = NSURLSession.sharedSession()
            
            let task = urlSession.dataTaskWithURL(url) { (data, response, error) -> Void in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    print("done!")
                    let result = NSString(data: data!, encoding:
                        NSASCIIStringEncoding)!
                    print("\(result)")
                }
            }
            task.resume()
        } else {
            print("not a valid url")
        }
    }
    

networkConnect()

//TODO two: Write and call a function that makes a failing network connection (using core networking APIs) to http://generalassemb.ly/foobar.baz, a nonexistant page. Print out the status code and body of the response.

func failedNetworkConnect () {
    
    let targetURL = "http://generalassemb.ly/foobar.baz"
    
    if let url = NSURL(string: targetURL) {
        
        let urlSession = NSURLSession.sharedSession()
        
        let task = urlSession.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let response = response as? NSHTTPURLResponse {
                print(response.statusCode)
            }
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                let result = NSString(data: data!, encoding:
                    NSASCIIStringEncoding)!
                print("\(result)")
            }
        }
        task.resume()
    } else {
        print("not a valid url")
    }
}

failedNetworkConnect()


//TODO three: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON using core networking APIs. Create a model class that corresponds to the JSON response object, populate it with the contents of that JSON using NSJSONSerialization, then print out the model.


//TODO four: Make a successful network connection to http://api.openweathermap.org/data/2.5/weather?q=New%20York,US, an API that speaks JSON. Populate a your above-defined model with the contents of that JSON using SwiftyJSON, then print out the model.

// Note replaced part 3 with part 4 since they are redundant and part 4 is the cleanier, easier to read version with SwiftyJSON

func weatherConnectSwifty () {
    
    class WeatherResponse {
        var humidity: Float = 0
        var tempMax: Float = 0
        var tempMin: Float = 0
        var temperature: Float = 0
        var wind: Float = 0
        
        init (humidity: Float, tempMax: Float, tempMin: Float, temperature: Float, wind: Float ) {
            self.humidity = humidity
            self.tempMax = tempMax
            self.tempMin = tempMin
            self.temperature = temperature
            self.wind = wind
        }
        
    }
    
    
    let targetURL = "http://api.openweathermap.org/data/2.5/weather?q=New%20York,US,&appid=21e9232688483bc3790f12c3de60b878"
    
    if let url = NSURL(string: targetURL) {
        
        let urlSession = NSURLSession.sharedSession()
        // this lets you talk to the network and reuse networking connections
        
        let task = urlSession.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
            
            if let response = response as? NSHTTPURLResponse {
                print(response.statusCode)
                // as is when you get to a more specific type
            }
            if let data = data {
                let json = JSON(data: data)
                let temp = json["main"]["temp"].float
                let min = json["main"]["temp_min"].float
                let max = json["main"]["temp_max"].float
                let humid = json["main"]["humidity"].float
                let wind = json["wind"]["speed"].float
                
                let currentWeather = WeatherResponse (humidity: humid!, tempMax: max!, tempMin: min!, temperature: temp!, wind: wind!)
                print("New York Weather --> Humidity: \(currentWeather.humidity); High (K): \(currentWeather.tempMax); Low (K): \(currentWeather.tempMin); Current temp (K): \(currentWeather.temperature); wind speed: \(currentWeather.wind)")
                
                
            } else { print("can't get data")
            }
        }
        task.resume()
    } else {
        print("not a valid url")
    }
}

weatherConnectSwifty()




