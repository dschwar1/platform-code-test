require 'award'

def update_quality(awards)
  #use new code
  awards = update_quality_refactor(awards)

  # awards.each do |award|
  #   if award.name != 'Blue First' && award.name != 'Blue Compare'
  #     if award.quality > 0
  #       if award.name != 'Blue Distinction Plus'
  #         award.quality -= 1
  #       end
  #     end
  #   else
  #     if award.quality < 50
  #       award.quality += 1
  #       if award.name == 'Blue Compare'
  #         if award.expires_in < 11
  #           if award.quality < 50
  #             award.quality += 1
  #           end
  #         end
  #         if award.expires_in < 6
  #           if award.quality < 50
  #             award.quality += 1
  #           end
  #         end
  #       end
  #     end
  #   end
  #   if award.name != 'Blue Distinction Plus'
  #     award.expires_in -= 1
  #   end
  #   if award.expires_in < 0
  #     if award.name != 'Blue First'
  #       if award.name != 'Blue Compare'
  #         if award.quality > 0
  #           if award.name != 'Blue Distinction Plus'
  #             award.quality -= 1
  #           end
  #         end
  #       else
  #         award.quality = award.quality - award.quality
  #       end
  #     else
  #       if award.quality < 50
  #         award.quality += 1
  #       end
  #     end
  #   end
  # end
end

def update_quality_refactor(awards)
  upper_quality_bound = 50
  lower_quality_bound = 0

  awards.each do |award|
    expired_multiplier = 1
    expired_multiplier = 2 if award.expires_in <= 0

    if award.name == "Blue First"
      award.quality = award.quality + expired_multiplier

    elsif award.name == "Blue Distinction Plus"
      next

    elsif award.name == "Blue Compare"
      if award.expires_in <= 0
        award.quality = 0
      elsif award.expires_in <= 5
        award.quality += 3
      elsif award.expires_in <= 10
        award.quality += 2
      else
        award.quality += 1
      end
      award.quality = award.quality

    elsif award.name == "Blue Star"
      award.quality -= 2 * expired_multiplier
      
    else #normal award
      award.quality -= expired_multiplier
    end

    #keep quality in bounds
    award.quality = upper_quality_bound if award.quality > upper_quality_bound
    award.quality = lower_quality_bound if award.quality < lower_quality_bound

    award.expires_in -= 1
  end
  awards
end