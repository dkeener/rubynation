class CommunityController < ApplicationController
  def index
    @onload_target =
        "onload=\"setIframeHeight(document.getElementById('community'))\"";
  end
  def alt
    @onload_target =
        "onload=\"setIframeHeight(document.getElementById('community'))\"";
  end
end
