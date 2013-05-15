module PublicationsHelper
  def  keyType(pubType)
    markaby do
      # span :class=>'pub'+pubType[0] do
        pubType[0]
      # end
    end
  end
end