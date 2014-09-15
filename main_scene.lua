module(..., package.seeall)

function onCreate(params)
  physicsWorld = PhysicsWorld()

  gameLayer = Layer {
    scene = scene,
    touchEnabled = true
  }


  mapLoader = TMXMapLoader()
  mapData = mapLoader:loadFile("platform2.tmx")
  moreMapData = dofile('platform2.lua')
  local objectGroups = {}
  for i = 1, moreMapData.#layers, 1 do
    if moreMapData.layers[i].type == "objectgroup" then
      table.insert(objectGroups, moreMapData.layer[i])
    end
  end

  for objectGroup in objectGroups, 1 do
    for object in objectGroup.objects, 1 do
      if object.shape == "rectangle" then
        physicsWorld:createRect(0,0,object.width, object.height, {type = object.type})
      elseif object.shape == "ellipse" then

      elseif object.shape == "polygon" then

      end
    end
  end




  mapView = TMXMapView()
  mapView:loadMap(mapData)
  mapView:setScene(scene)

  --printTileProperty()
end

function onTouchMove(e)
  local viewScale = Application:getViewScale()
  mapView.camera:addLoc(-e.moveX / viewScale, -e.moveY / viewScale, 0)
end

function printTileProperty()
  print("gid=3, shape=".. tostring(mapData:getTileProperty(3, "shape")))
  print("x=12, y=10, shape=" .. tostring(mapData.layers[2]:getTileProperty(12, 10, "shape")))
end
