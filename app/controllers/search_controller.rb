class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == "user"
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'forward'
        User.where('name LIKE ?', content+'%')
      elsif method == 'backward'
        User.where('name LIKE ?', '%'+content)
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == "post"
      if method == 'perfect'
        Post.where(body: content)
      elsif method == 'forward'
        Post.where('body LIKE ?', content+'%')
      elsif method == 'backward'
        Post.where('body LIKE ?', '%'+content)
      else
        Post.where('body LIKE ?', '%'+content+'%')
      end
    else
      if method == 'perfect'
        Comment.where(body: content)
      elsif method == 'forward'
        Comment.where('body LIKE ?', content+'%')
      elsif method == 'backward'
        Comment.where('body LIKE ?', '%'+content)
      else
        Comment.where('body LIKE ?', '%'+content+'%')
      end
    end
  end
end