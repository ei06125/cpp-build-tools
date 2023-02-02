include_guard(GLOBAL)

function(configure_meta_header_file)
  configure_file("Meta.h.in" "${CMAKE_BINARY_DIR}/Meta/Meta.h" ESCAPE_QUOTES)
endfunction()
