def locations [] {
    [
        [location city_column state_column country_column lat_column lon_column];
        ["http://ip-api.com/json/" city region countryCode lat lon]
        ["https://ipapi.co/json/" city region_code country_code latitude longitude]
        # ["https://freegeoip.app/json/" city region_code country_code latitude longitude] # doesn't appear to be free any longer
        ["https://ipwhois.app/json/" city region country_code  latitude longitude]
    ]
}

def get_my_location [index: int] {
    let loc_json = (http get (locations | select $index).0.location)
    let city_column = (locations | select $index).0.city_column
    let state_column = (locations | select $index).0.state_column
    let country_column = (locations | select $index).0.country_column
    let lat_column = (locations | select $index).0.lat_column
    let lon_column = (locations | select $index).0.lon_column

    # echo $loc_json
    if ($city_column | str length) > 1 {
        if ($state_column | str length) > 1 {
            if ($country_column | str length) > 1 {
                let lookup_state = ($loc_json | get ($state_column))
                if ($lookup_state | str length) > 2 {
                    let state = (state_abbrev_lookup $lookup_state)
                    $"($loc_json | get ($city_column)),($state),($loc_json | get ($country_column))"
                } else {
                    $"($loc_json | get ($city_column)),($loc_json | get ($state_column)),($loc_json | get ($country_column))"
                }
            } else {
                $"($loc_json | get ($city_column)),($loc_json | get ($state_column))"
            }
        } else {
            $"($loc_json | get ($city_column))"
        }
    } else {
        "No City Found"
    }
}

def get_location_by_ip [locIdx: int, token: string] {
    let URL_QUERY_LOCATION = "https://api.openweathermap.org/geo/1.0/direct"
    let location = (get_my_location $locIdx)
    let url = $"($URL_QUERY_LOCATION)?q=($location)&limit=5&appid=($token)"
    http get $url
}

def show-error [msg label err] {
    let span = (metadata $err).span;
    error make {msg: $msg, label: {text: $label, start: $span.start, end: $span.end } }
}

def get_weather_by_ip [locIdx: int, units: string, token: string] {
    # units
    # f = imperial aka Fahrenheit
    # c = metric aka Celcius
    let URL_WEATHER = "https://api.openweathermap.org/data/2.5/weather"
    let URL_FORECAST = "http://api.openweathermap.org/data/2.5/forecast/daily"
    let coords = (get_location_by_ip $locIdx $token)
    if ($coords | length) > 1 {
        show-error "Error getting location" "There were more than one locations found" $coords
    }

    if $units == "f" {
        let units = "imperial"
        let url = $"($URL_WEATHER)?lat=($coords.lat.0)&lon=($coords.lon.0)&units=($units)&appid=($token)"
        let url_forecast = $"($URL_FORECAST)?lat=($coords.lat.0)&lon=($coords.lon.0)&units=($units)&appid=($token)"
        let weather = (http get $url)
        let forecast_data = (http get $url_forecast)
        let forecast = ($forecast_data.list | each {|day|
                    {
                        id: ($day.weather.0.id)
                        dt: ($day.dt * 1_000_000_000 | into string | into datetime -z local | format date '%a, %b %e') #'%Y-%m-%d')
                        high: ($day.temp.max)
                        low: ($day.temp.min)
                    }
                })
        let day1 = $"($forecast | get 0.dt) (get_emoji_by_id ($forecast | get 0.id | into string)) high: ($forecast | get 0.high | into string -d 1) low: ($forecast | get 0.low | into string -d 1)"
        let day2 = $"($forecast | get 1.dt) (get_emoji_by_id ($forecast | get 1.id | into string)) high: ($forecast | get 1.high | into string -d 1) low: ($forecast | get 1.low | into string -d 1)"
        let day3 = $"($forecast | get 2.dt) (get_emoji_by_id ($forecast | get 2.id | into string)) high: ($forecast | get 2.high | into string -d 1) low: ($forecast | get 2.low | into string -d 1)"
        let day4 = $"($forecast | get 3.dt) (get_emoji_by_id ($forecast | get 3.id | into string)) high: ($forecast | get 3.high | into string -d 1) low: ($forecast | get 3.low | into string -d 1)"
        let day5 = $"($forecast | get 4.dt) (get_emoji_by_id ($forecast | get 4.id | into string)) high: ($forecast | get 4.high | into string -d 1) low: ($forecast | get 4.low | into string -d 1)"
        let day6 = $"($forecast | get 5.dt) (get_emoji_by_id ($forecast | get 5.id | into string)) high: ($forecast | get 5.high | into string -d 1) low: ($forecast | get 5.low | into string -d 1)"
        let day7 = $"($forecast | get 6.dt) (get_emoji_by_id ($forecast | get 6.id | into string)) high: ($forecast | get 6.high | into string -d 1) low: ($forecast | get 6.low | into string -d 1)"
        {
            'Weather Location': $"($weather.name), ($weather.sys.country)"
            Longitude: $weather.coord.lon
            Latitude: $weather.coord.lat
            Temperature: $"($weather.main.temp | into string -d 1) °F"
            'Feels Like': $"($weather.main.feels_like | into string -d 1) °F"
            Humidity: $weather.main.humidity
            Pressure: $weather.main.pressure
            Emoji: (get_icon_from_table $weather.weather.main.0)
            'Forecast Day 1': $day1
            'Forecast Day 2': $day2
            'Forecast Day 3': $day3
            'Forecast Day 4': $day4
            'Forecast Day 5': $day5
            'Forecast Day 6': $day6
            'Forecast Day 7': $day7
        }
    } else {
        let units = "metric"
        let url = $"($URL_WEATHER)?lat=($coords.lat.0)&lon=($coords.lon.0)&units=($units)&appid=($token)"
        let url_forecast = $"($URL_FORECAST)?lat=($coords.lat.0)&lon=($coords.lon.0)&units=($units)&appid=($token)"
        let weather = (http get $url)
        let forecast_data = (http get $url_forecast)
        let forecast = ($forecast_data.list | each {|day|
                    {
                        id: ($day.weather.0.id)
                        dt: ($day.dt * 1_000_000_000 | into string | into datetime -z local | format date '%a, %b %e') #'%Y-%m-%d')
                        high: ($day.temp.max)
                        low: ($day.temp.min)
                    }
                })
        let day1 = $"($forecast | get 0.dt) (get_emoji_by_id ($forecast | get 0.id | into string)) high: ($forecast | get 0.high | into string -d 1) low: ($forecast | get 0.low | into string -d 1)"
        let day2 = $"($forecast | get 1.dt) (get_emoji_by_id ($forecast | get 1.id | into string)) high: ($forecast | get 1.high | into string -d 1) low: ($forecast | get 1.low | into string -d 1)"
        let day3 = $"($forecast | get 2.dt) (get_emoji_by_id ($forecast | get 2.id | into string)) high: ($forecast | get 2.high | into string -d 1) low: ($forecast | get 2.low | into string -d 1)"
        let day4 = $"($forecast | get 3.dt) (get_emoji_by_id ($forecast | get 3.id | into string)) high: ($forecast | get 3.high | into string -d 1) low: ($forecast | get 3.low | into string -d 1)"
        let day5 = $"($forecast | get 4.dt) (get_emoji_by_id ($forecast | get 4.id | into string)) high: ($forecast | get 4.high | into string -d 1) low: ($forecast | get 4.low | into string -d 1)"
        let day6 = $"($forecast | get 5.dt) (get_emoji_by_id ($forecast | get 5.id | into string)) high: ($forecast | get 5.high | into string -d 1) low: ($forecast | get 5.low | into string -d 1)"
        let day7 = $"($forecast | get 6.dt) (get_emoji_by_id ($forecast | get 6.id | into string)) high: ($forecast | get 6.high | into string -d 1) low: ($forecast | get 6.low | into string -d 1)"
        {
            'Weather Location': $"($weather.name), ($weather.sys.country)"
            Longitude: $weather.coord.lon
            Latitude: $weather.coord.lat
            Temperature: $"($weather.main.temp | into string -d 1) °C"
            'Feels Like': $"($weather.main.feels_like | into string -d 1) °C"
            Humidity: $weather.main.humidity
            Pressure: $weather.main.pressure
            Emoji: (get_icon_from_table $weather.weather.main.0)
            'Forecast Day 1': $day1
            'Forecast Day 2': $day2
            'Forecast Day 3': $day3
            'Forecast Day 4': $day4
            'Forecast Day 5': $day5
            'Forecast Day 6': $day6
            'Forecast Day 7': $day7
        }
    }
}

def weather_emoji_table [] {
    {
        Clear: (char sun)
        Clouds: (char clouds)
        Rain: (char rain)
        Fog: (char fog)
        Mist: (char mist)
        Haze: (char haze)
        Snow: (char snow)
        Thunderstorm: (char thunderstorm)
    }
}

def get_icon_from_table [w] {
    weather_emoji_table | get $w
}

# Get the local weather by ip address
export def get_weather [
    --locIdx(-l): int # The location id 0-2
    --units(-u): string # The units "f" or "c"
    ] {
    let token = "85a4e3c55b73909f42c6a23ec35b7147"

    let is_loc_empty = ($locIdx == $nothing)
    let is_units_empty = ($units == $nothing)

    let no_loc_no_unit = ($is_loc_empty == true and $is_units_empty == true)
    let no_loc_with_unit = ($is_loc_empty == true and $is_units_empty == false)
    let with_loc_no_unit = ($is_loc_empty == false and $is_units_empty == true)
    let with_loc_with_unit = ($is_loc_empty == false and $is_units_empty == false)

    # This is a cautionary tale, the commented out code below is returning
    # and autoview is viewing the data, so no structured data is being returned.
    # The ramification to this is you can't do get_weather | select Temperature Emoji
    # like you should be able to. The following uncommented section below fixes it.

    # Hopefully we'll be able to fix this somehow because it's easy to fall into
    # this hole without knowing.

    # if $no_loc_no_unit {
    #     echo "no_loc_no_unit"
    #     (get_weather_by_ip 0 "f")
    # } { }

    # if $no_loc_with_unit {
    #     echo "no_loc_with_unit"
    #     (get_weather_by_ip 0 $units)
    # } { }

    # if $with_loc_no_unit {
    #     echo "with_loc_no_unit"
    #     (get_weather_by_ip $locIdx "f")
    # } { }

    # if $with_loc_with_unit {
    #     echo "with_loc_with_unit"
    #     (get_weather_by_ip $locIdx $units)
    # } { }

    if $no_loc_no_unit {
        (get_weather_by_ip 0 "f" $token)
    } else if $no_loc_with_unit {
        (get_weather_by_ip 0 $units $token)
    } else if $with_loc_no_unit {
        (get_weather_by_ip $locIdx "f" $token)
    } else if $with_loc_with_unit {
        (get_weather_by_ip $locIdx $units $token)
    }
}

def state_abbrev_lookup [state_name: string] {
    # Weather Location 3 does not return state name abbreviations
    # so we have to convert a state full name to a state abbreviation
    let lookup_table = {
        Alabama: AL
        Alaska: AK
        Arizona: AZ
        Arkansas: AR
        California: CA
        Colorado: CO
        Connecticut: CT
        Delaware: DE
        Florida: FL
        Georgia: GA
        Hawaii: HI
        Idaho: ID
        Illinois: IL
        Indiana: IN
        Iowa: IA
        Kansas: KS
        Kentucky: KY
        Louisiana: LA
        Maine: ME
        Maryland: MD
        Massachusetts: MA
        Michigan: MI
        Minnesota: MN
        Mississippi: MS
        Missouri: MO
        Montana: MT
        Nebraska: NE
        Nevada: NV
        'New Hampshire': NH
        'New Jersey': NJ
        'New Mexico': NM
        'New York': NY
        'North Carolina': NC
        'North Dakota': ND
        Ohio: OH
        Oklahoma: OK
        Oregon: OR
        Pennsylvania: PA
        'Rhode Island': RI
        'South Carolina': SC
        'South Dakota': SD
        Tennessee: TN
        Texas: TX
        Utah: UT
        Vermont: VT
        Virginia: VA
        Washington: WA
        'West Virginia': WV
        Wisconsin: WI
        Wyoming: WY
    }

    $lookup_table | get $state_name
}

def get_emoji_by_id [id] {
        let emoji_dict = ({
        "200": "⚡", "201": "⚡", "202": "⚡", "210": "⚡", "211": "⚡", "212": "⚡", "221": "⚡", "230": "⚡",
        "231": "⚡", "232": "⚡",
        "300": "☔", "301": "☔", "302": "☔", "310": "☔", "311": "☔",
        "312": "☔", "313": "☔", "314": "☔", "321": "☔",
        "500": "☔", "501": "☔", "502": "☔", "503": "☔", "504": "☔",
        "511": "☔", "520": "☔", "521": "☔", "522": "☔", "531": "☔",
        "600": "❄️", "601": "❄️", "602": "❄️", "611": "❄️", "612": "❄️",
        "613": "❄️", "615": "❄️", "616": "❄️", "620": "❄️", "621": "❄️",
        "622": "❄️",
        "701": "🌫️", "711": "🌫️", "721": "🌫️", "731": "🌫️", "741": "🌫️", "751": "🌫️", "761": "🌫️", "762": "🌫️",
        "771": "🌫️",
        "781": "🌀",
        "800": "☀️",
        "801": "🌤️", "802": "🌤️", "803": "☁️", "804": "☁️",
    })

    ($emoji_dict | get $id)
}
