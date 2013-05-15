class Chapter < Publication
  validates_presence_of :Authors, :Title, :Year, :BookTitle
  def BookTitle
    self.With
  end

end