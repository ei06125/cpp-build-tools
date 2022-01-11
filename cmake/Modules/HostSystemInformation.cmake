# Copyright (C) ei06125. All Rights Reserved.

# Provides an include guard for the file currently being processed by CMake.
include_guard(GLOBAL)

#
cmake_host_system_information(RESULT NUMBER_OF_LOGICAL_CORES_RESULT
                              QUERY NUMBER_OF_LOGICAL_CORES)

#
cmake_host_system_information(RESULT NUMBER_OF_PHYSICAL_CORES_RESULT
                              QUERY NUMBER_OF_PHYSICAL_CORES)

#
cmake_host_system_information(RESULT HOSTNAME_RESULT QUERY HOSTNAME)

#
cmake_host_system_information(RESULT FQDN_RESULT QUERY FQDN)

#
cmake_host_system_information(RESULT TOTAL_VIRTUAL_MEMORY_RESULT
                              QUERY TOTAL_VIRTUAL_MEMORY)

#
cmake_host_system_information(RESULT AVAILABLE_VIRTUAL_MEMORY_RESULT
                              QUERY AVAILABLE_VIRTUAL_MEMORY)

#
cmake_host_system_information(RESULT TOTAL_PHYSICAL_MEMORY_RESULT
                              QUERY TOTAL_PHYSICAL_MEMORY)

#
cmake_host_system_information(RESULT AVAILABLE_PHYSICAL_MEMORY_RESULT
                              QUERY AVAILABLE_PHYSICAL_MEMORY)

#
cmake_host_system_information(RESULT IS_64BIT_RESULT QUERY IS_64BIT)

#
cmake_host_system_information(RESULT HAS_FPU_RESULT QUERY HAS_FPU)

#
cmake_host_system_information(RESULT HAS_MMX_RESULT QUERY HAS_MMX)

#
cmake_host_system_information(RESULT HAS_MMX_PLUS_RESULT QUERY HAS_MMX_PLUS)

#
cmake_host_system_information(RESULT HAS_SSE_RESULT QUERY HAS_SSE)

#
cmake_host_system_information(RESULT HAS_SSE2_RESULT QUERY HAS_SSE2)

#
cmake_host_system_information(RESULT HAS_SSE_FP_RESULT QUERY HAS_SSE_FP)

#
cmake_host_system_information(RESULT HAS_SSE_MMX_RESULT QUERY HAS_SSE_MMX)

#
cmake_host_system_information(RESULT HAS_AMD_3DNOW_RESULT QUERY HAS_AMD_3DNOW)

#
cmake_host_system_information(RESULT HAS_AMD_3DNOW_PLUS_RESULT
                              QUERY HAS_AMD_3DNOW_PLUS)

#
cmake_host_system_information(RESULT HAS_IA64_RESULT QUERY HAS_IA64)

#
cmake_host_system_information(RESULT HAS_SERIAL_NUMBER_RESULT
                              QUERY HAS_SERIAL_NUMBER)

#
cmake_host_system_information(RESULT PROCESSOR_SERIAL_NUMBER_RESULT
                              QUERY PROCESSOR_SERIAL_NUMBER)

#
cmake_host_system_information(RESULT PROCESSOR_NAME_RESULT QUERY PROCESSOR_NAME)

#
cmake_host_system_information(RESULT PROCESSOR_DESCRIPTION_RESULT
                              QUERY PROCESSOR_DESCRIPTION)

#
cmake_host_system_information(RESULT OS_NAME_RESULT QUERY OS_NAME)

#
cmake_host_system_information(RESULT OS_RELEASE_RESULT QUERY OS_RELEASE)

#
cmake_host_system_information(RESULT OS_VERSION_RESULT QUERY OS_VERSION)

#
cmake_host_system_information(RESULT OS_PLATFORM_RESULT QUERY OS_PLATFORM)

# =============================================================================
# DEBUG
# =============================================================================

if(${CMAKE_CURRENT_LOG_LEVEL} LESS CMAKE_LOG_LEVEL_INFO)
  include(CMakePrintHelpers)
  cmake_print_variables(NUMBER_OF_LOGICAL_CORES_RESULT)
  cmake_print_variables(NUMBER_OF_PHYSICAL_CORES_RESULT)
  cmake_print_variables(HOSTNAME_RESULT)
  cmake_print_variables(FQDN_RESULT)
  cmake_print_variables(TOTAL_VIRTUAL_MEMORY_RESULT)
  cmake_print_variables(AVAILABLE_VIRTUAL_MEMORY_RESULT)
  cmake_print_variables(TOTAL_PHYSICAL_MEMORY_RESULT)
  cmake_print_variables(AVAILABLE_PHYSICAL_MEMORY_RESULT)
  cmake_print_variables(IS_64BIT_RESULT)
  cmake_print_variables(HAS_FPU_RESULT)
  cmake_print_variables(HAS_MMX_RESULT)
  cmake_print_variables(HAS_MMX_PLUS_RESULT)
  cmake_print_variables(HAS_SSE_RESULT)
  cmake_print_variables(HAS_SSE2_RESULT)
  cmake_print_variables(HAS_SSE_FP_RESULT)
  cmake_print_variables(HAS_SSE_MMX_RESULT)
  cmake_print_variables(HAS_AMD_3DNOW_RESULT)
  cmake_print_variables(HAS_AMD_3DNOW_PLUS_RESULT)
  cmake_print_variables(HAS_IA64_RESULT)
  cmake_print_variables(HAS_SERIAL_NUMBER_RESULT)
  cmake_print_variables(PROCESSOR_SERIAL_NUMBER_RESULT)
  cmake_print_variables(PROCESSOR_NAME_RESULT)
  cmake_print_variables(PROCESSOR_DESCRIPTION_RESULT)
  cmake_print_variables(OS_NAME_RESULT)
  cmake_print_variables(OS_RELEASE_RESULT)
  cmake_print_variables(OS_VERSION_RESULT)
  cmake_print_variables(OS_PLATFORM_RESULT)
endif()
