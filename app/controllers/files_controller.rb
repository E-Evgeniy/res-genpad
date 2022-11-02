
class FilesController < ApplicationController

    attr_reader :obj
  
    def destroy
      file_as = ActiveStorage::Attachment.find(params[:file])
      @obj = file_as.record
      @obj.files.find(file_as.id).purge
      @test = Test.find(params[:test])
    end
  
  end