
class FilesController < ApplicationController

    attr_reader :obj
  
    def destroy
      file_as = ActiveStorage::Attachment.find(params[:id])
      @obj = file_as.record
      obj.files.find(file_as.id).purge
  
      obj.reload
    end
  
  end