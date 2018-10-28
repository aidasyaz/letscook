class VideoObserver < ActiveRecord::Observer
  # will run only before the record is saved
  def before_save(resource)
    video = Yt::Video.new url: resource.link
    resource.uid = video.id
    resource.title = video.title
    resource.likes = video.like_count
    resource.dislikes = video.dislike_count
    resource.published_at = video.published_at
  # will occur when the requested video was not found
  rescue Yt::Errors::NoItems
    resource.title = ''
  end
end