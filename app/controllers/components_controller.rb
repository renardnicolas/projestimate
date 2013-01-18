#########################################################################
#
# ProjEstimate, Open Source project estimation web application
# Copyright (c) 2012 Spirula (http://www.spirula.fr)
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

class ComponentsController < ApplicationController


  def edit
    @component = Component.find(params[:id])
    set_page_title("Editing #{@component.name}")

    @project = Project.find(params[:project_id])

    #Select folders which could be a parent of a component
    #a component cannot be its own parent
    @folder_components = @project.pe_wbs_project.components.select{ |i| i.work_element_type.alias == "folder" }
    @folder_components
  end

  def update
    @component = Component.find(params[:id])

    if @component.update_attributes(params[:component])
      # Another update attributes...
      @component.update_attribute :parent, Component.find(params[:component][:ancestry])
      redirect_to redirect("/dashboard")
    else
      flash[:notice] = "Please verify components value"
      redirect_to redirect("/dashboard")
    end
  end

  def destroy
    #set somes variables
    component = Component.find(params[:id])
    @project = component.pe_wbs_project.project
    @component = @project.root_component

    component.module_project_attributes.each do |mpa|
      mpa.destroy
    end

    #Destroy the selected component
    component.destroy

    #Reload position
    @project.pe_wbs_project.components.each_with_index do |c,i|
      c.position = i
      c.save
    end

    render :partial => "components/refresh"
  end

  #Select the current component and refresh the partial
  def selected_component
    session[:component_id] = params[:id]

    @user = current_user
    @project = current_project
    @component = current_component
    @array_module_positions = ModuleProject.where(:project_id => @project.id).sort_by{|i| i.position_y}.map(&:position_y).uniq.max || 1

    render :partial => "components/refresh"
  end

  #Create a new component and refresh the partials
  def new
    @pe_wbs_project = PeWbsProject.find(params[:pe_wbs_project_id])
    @project = @pe_wbs_project.project
    @array_module_positions = ModuleProject.where(:project_id => @project.id).sort_by{|i| i.position_y}.map(&:position_y).uniq.max || 1
    @component = Component.new
    @component.pe_wbs_project_id = params[:pe_wbs_project_id]
    @component.parent_id = params[:comp_parent_id]

    if params[:type_component] == "folder"
      @component.name = "New folder"
      @component.work_element_type_id = WorkElementType.find_by_alias("folder").id
    elsif params[:type_component] == "link"
      @component.name = "New link"
      @component.work_element_type_id = WorkElementType.find_by_alias("link").id
    else
      @component.name = "New component"
      @component.work_element_type_id = WorkElementType.find_by_alias("undefined").id
    end
    @component.position = @pe_wbs_project.components.map(&:position).max + 1
    @component.save

    #Set current component
    session[:component_id] = @component.id

    @user = current_user

    @project.module_projects.each do |mp|
      mp.module_project_attributes.reject{|i| i.component_id != @project.root_component.id }.each do |mpa|
        new_mpa = mpa.dup
        new_mpa.save
        mpa.update_attribute("component_id", @component.id)
      end
    end

    render :partial => "components/refresh"
  end

  #Pushed up the component
  def up
    @project = Project.find(params[:project_id])

    component_a = Component.find(params[:component_id])
    unless component_a.position == 1
      component_b = Component.find_by_position_and_pe_wbs_project_id(component_a.position - 1, params[:pe_wbs_project_id])
      component_a.update_attribute("position", component_a.position - 1)
      component_b.update_attribute("position", component_b.position + 1)
    end

    @user = current_user

    render :partial => "components/refresh", :object => @project
  end

  #Pushed down the component
  def down
    @project = Project.find(params[:project_id])

    component_a = Component.find(params[:component_id])
    unless component_a.position == @project.pe_wbs_project.components.map(&:position).max
      component_b = Component.find_by_position(component_a.position + 1)
      component_a.update_attribute("position", component_a.position + 1)
      component_b.update_attribute("position", component_b.position - 1)
    end

    @user = current_user

    render :partial => "components/refresh", :object => @project
  end
end
