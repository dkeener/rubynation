class VenueController < ApplicationController
  def index
    @onload_target = 'onload="load()" onunload="GUnload()"'
  end
end
