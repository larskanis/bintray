module Bintray
  class Package < Entity
    attr :name, :repo, :owner, :desc, :labels, :attribute_names,
      :followers_count, :versions, :latest_version, :rating_count,
      :system_ids, :vcs_url

    def version?(ver)
      version(ver)
      true
    rescue Error::NotFound
      false
    end

    def version(ver)
      Version.new @api, Filesystem.new, @api.get("/packages/#{owner}/#{repo}/#{name}/versions/#{ver}")
    end

    def add_version(ver)
      Version.new @api, Filesystem.new, @api.post("/packages/#{owner}/#{repo}/#{name}/versions", { :name => ver })
    end

    def del_version(ver)
      @api.delete("/packages/#{owner}/#{repo}/#{name}/versions/#{ver}")
    end
  end
end
