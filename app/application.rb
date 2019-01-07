

class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_wanted = req.path.split("/items/").last
      found_item = @@items.find{|i| i.name == item_wanted}
      # binding.pry
      if found_item
        resp.status = 200
        resp.write found_item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end
end
