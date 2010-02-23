require 'rexml/document'

module SVNUtils

  def self.determine_project_root
    xml = %x["svn" "info" "--xml"]
    doc = REXML::Document.new(xml)
    return doc.root.elements[1].elements['repository'].elements['root'].text
  end

  def self.determine_project_revision
    xml = %x["svn" "info" "--xml"]
    doc = REXML::Document.new(xml)
    return doc.root.elements['entry'].attributes['revision']
  end

  def self.determine_project_head
    xml = %x["svn" "info" "--xml"]
    doc = REXML::Document.new(xml)
    return doc.root.elements[1].elements['url'].text
  end

  def self.construct_branch(url, branch_name)
    branch_url = ""
    url.split("/").each { |fragment|
      if (fragment == "head")
        branch_url = branch_url + "branches/#{branch_name}"
        return branch_url
      else
        branch_url = branch_url + fragment + "/"
      end
    }
    return branch_url  
  end

  def self.construct_production(url)
    production_url = ""
    url.split("/").each { |fragment|
      if (fragment == "head")
        production_url = production_url + "in_production"
        return production_url
      else
        production_url = production_url + fragment + "/"
      end
    }
    return production_url  
  end

end
