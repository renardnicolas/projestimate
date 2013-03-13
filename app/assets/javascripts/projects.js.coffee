jQuery ->
  $("#select_module").bind 'change', ->
    $.ajax
      url: "/add_module"
      method: "get"
      data:
        module_selected: $(this).val()
        project_id: $("#project_id").val()

  $("#select_pbs_project_elements").bind 'change', ->
    $.ajax
      url: "/select_pbs_project_elements",
      method: "get"
      data:
        pbs_project_element_id: $(this).val()
        project_id: $("#project_id").val()