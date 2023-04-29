class WeatherImporter
  def self.execute

    pref_ja = URI.encode_www_form_component("東京")
    address = URI.encode_www_form_component("世田谷")
    # uri = URI.parse("https://jjwd.info/api/v2/stations/search?pref_ja=#{pref_ja}&address=#{address}")
    uri = URI.parse('https://api.open-meteo.com/v1/forecast?latitude=35.6785&longitude=139.6823&hourly=temperature_2m&timezone=Asia%2FTokyo')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    res = http.get(uri.request_uri)
    return if res.code != '200'

    r = JSON.parse(res.body, symbolize_names: true)
    r[:hourly][:time]
    r[:hourly][:temperature_2m]
  end
end