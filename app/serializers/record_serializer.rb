class RecordSerializer < ActiveModel::Serializer
  attributes :id, :s3_url, :status, :user, :created_at, :analyzed_at, :plate, :last_seen_time,
              :last_seen_location, :location, :confidence

  def analyzed_at
    self.object.analyzed_at ? self.object.analyzed_at.strftime('%v %r') : 'N/A'
  end

  def last_seen_records
    @records || @records = Record.where("analyzed_at < ? AND plate = ?", self.object.analyzed_at, self.object.plate)
  end

  def last_seen_time
    last_seen_records.any? ? last_seen_records.first.analyzed_at.strftime('%v %r') : 'N/A'
  end

  def last_seen_location
    last_seen_records.any? ? 'coming soon' : 'N/A'
  end

  def location
    'coming soon'
  end

  def confidence
    self.object.analyzed_at ? '%.1f' % self.object.analysis_data['plate']['results'][0]['confidence'] : 'N/A'
  end

end
