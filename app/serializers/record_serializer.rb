require 'time_ago_in_words'

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
    last_seen_records.any? ? (last_seen_records.last.analyzed_at - 1.second).ago_in_words : 'N/A'
  end

  def last_seen_location
    last_seen_records.any? ? formatted_location(last_seen_records.last.location) : 'N/A'
  end

  def location
    self.object.location ? formatted_location(self.object.location) : 'N/A'
  end

  def confidence
    self.object.analyzed_at ? '%.1f' % self.object.analysis_data['plate']['results'][0]['confidence'] : 'N/A'
  end

  private

    def formatted_location(location)
      if location
        "#{location['lat'].to_d.round(3).to_s} : #{location['lng'].to_d.round(3).to_s}"
      else
        'N/A'
      end
    end

end
