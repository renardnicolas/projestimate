#########################################################################
#
# ProjEstimate, Open Source project estimation web application
# Copyright (c) 2012-2013 Spirula (http://www.spirula.fr)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
########################################################################

class PlatformCategoriesController < ApplicationController
  include DataValidationHelper #Module for master data changes validation

  before_filter :get_record_statuses

  def new
    set_page_title 'Platform Category'
    @platform_category = PlatformCategory.new
  end

  def edit
    set_page_title 'Platform Category'
    @platform_category = PlatformCategory.find(params[:id])

    unless @platform_category.child_reference.nil?
      if @platform_category.child_reference.is_proposed_or_custom?
        flash[:warning] = I18n.t (:warning_platform_category_cant_be_edit)
        redirect_to redirect(projects_global_params_path(:anchor => 'tabs-3'))
      end
    end
  end

  def create
    @platform_category = PlatformCategory.new(params[:platform_category])

    if @platform_category.save
      flash[:notice] = I18n.t (:notice_platform_category_successful_created)
      redirect_to redirect(projects_global_params_path(:anchor => 'tabs-3'))
    else
      render action: 'new'
    end
  end

  def update
    @platform_category = nil
    current_platform_category = PlatformCategory.find(params[:id])
    if current_platform_category.is_defined?
      @platform_category = current_platform_category.amoeba_dup
      @platform_category.owner_id = current_user.id
    else
      @platform_category = current_platform_category
    end

    if @platform_category.update_attributes(params[:platform_category])
      flash[:notice] = I18n.t (:notice_platform_category_successful_updated)
      redirect_to redirect(projects_global_params_path(:anchor => 'tabs-3'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @platform_category = PlatformCategory.find(params[:id])
    if @platform_category.is_defined? || @platform_category.is_custom?
      #logical deletion: delete don't have to suppress records anymore
      @platform_category.update_attributes(:record_status_id => @retired_status.id, :owner_id => current_user.id)
    else
      @platform_category.destroy
    end

    flash[:notice] = I18n.t (:notice_platform_category_successful_deleted)
    redirect_to projects_global_params_path(:anchor => 'tabs-3')
  end
end
