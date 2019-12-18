class Song < ApplicationRecord
    validates :title, presence: true
    validates :release_year, numericality: { less_than_or_equal_to: Date.today.year }, presence: true, if: -> { released }
    validate :new_song_this_year

    def new_song_this_year
        Song.all.each do |song|
            if song.title == self.title && song.release_year == self.release_year
                errors.add(:title, "can't release two songs with the same title in the same year.")
            end
        end
    end 
end
