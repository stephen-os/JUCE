project "JUCE"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "off"

    targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
    objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        -- Core modules
        "modules/juce_core/juce_core.cpp",
        "modules/juce_core/juce_core_CompilationTime.cpp",
        "modules/juce_data_structures/juce_data_structures.cpp",
        "modules/juce_events/juce_events.cpp",
        
        -- Graphics modules
        "modules/juce_graphics/juce_graphics.cpp",
        "modules/juce_graphics/juce_graphics_Harfbuzz.cpp",
        
        -- GUI modules
        "modules/juce_gui_basics/juce_gui_basics.cpp",
        "modules/juce_gui_extra/juce_gui_extra.cpp",
        
        -- Audio modules (basic)
        "modules/juce_audio_basics/juce_audio_basics.cpp",
        "modules/juce_audio_devices/juce_audio_devices.cpp",
        "modules/juce_audio_formats/juce_audio_formats.cpp",
        "modules/juce_audio_processors_headless/juce_audio_processors_headless.cpp",
        "modules/juce_audio_processors/juce_audio_processors.cpp",
        "modules/juce_audio_utils/juce_audio_utils.cpp"
    }

    includedirs
    {
        "modules",
        "modules/juce_audio_processors_headless/format_types/VST3_SDK",
        "C:/ASIOSDK/common"
    }

    defines
    {
        "JUCE_GLOBAL_MODULE_SETTINGS_INCLUDED=1",
        "JUCE_STANDALONE_APPLICATION=1",
        "JUCE_PLUGINHOST_VST3=1",
        "JUCE_USE_CURL=0",
        "JUCE_WEB_BROWSER=0",
        "JUCE_USE_DIRECTWRITE=1",
        "JUCE_ASIO=1",
        "JUCE_WASAPI=1",
        "JUCE_DIRECTSOUND=1",
        -- Module availability flags
        "JUCE_MODULE_AVAILABLE_juce_audio_basics=1",
        "JUCE_MODULE_AVAILABLE_juce_audio_devices=1",
        "JUCE_MODULE_AVAILABLE_juce_audio_formats=1",
        "JUCE_MODULE_AVAILABLE_juce_core=1",
        "JUCE_MODULE_AVAILABLE_juce_data_structures=1",
        "JUCE_MODULE_AVAILABLE_juce_events=1",
        "JUCE_MODULE_AVAILABLE_juce_graphics=1",
        "JUCE_MODULE_AVAILABLE_juce_gui_basics=1",
        "JUCE_MODULE_AVAILABLE_juce_gui_extra=1",
        "JUCE_MODULE_AVAILABLE_juce_audio_processors_headless=1",
        "JUCE_MODULE_AVAILABLE_juce_audio_processors=1",
        "JUCE_MODULE_AVAILABLE_juce_audio_utils=1"
    }

    buildoptions { "/bigobj" }

    filter "system:windows"
        systemversion "latest"
        files
        {
            "modules/juce_graphics/juce_graphics_Sheenbidi.c"
        }
        defines
        {
            "_CRT_SECURE_NO_WARNINGS"
        }
        links
        {
            "kernel32",
            "user32",
            "gdi32",
            "winspool",
            "comdlg32",
            "advapi32",
            "shell32",
            "ole32",
            "oleaut32",
            "uuid",
            "odbc32",
            "odbccp32",
            "winmm",
            "wininet",
            "version",
            "ws2_32",
            "shlwapi",
            "imm32",
            "dwrite",
            "d2d1"
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"
        defines { "DEBUG", "JUCE_DEBUG=1" }

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
        defines { "NDEBUG" }

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"
        defines { "NDEBUG" }
