

### BEGIN PRETTY ERRORS

# pretty-errors package to make exception reports legible.
# v1.2.24 generated this config: newer version may have added methods/options not present!

try:
    import pretty_errors
except ImportError:
    print(
        'You have uninstalled pretty_errors but it is still present in your python startup.' +
        '  Please remove its section from file:\n ' + __file__ + '\n'
    )
else:
    pass

    # Use if you do not have a color terminal:
    #pretty_errors.mono()

    # Use if you are using a framework which is handling all the exceptions before pretty_errors can:
    #if pretty_errors.active:
    #    pretty_errors.replace_stderr()

    # Use to hide frames whose file begins with these paths:
    #pretty_errors.blacklist('/path/to/blacklist', '/other/path/to/blacklist', ...)

    # Use to only show frames whose file begins with these paths:
    #pretty_errors.whitelist('/path/to/whitelist', '/other/path/to/whitelist', ...)

    # Use to selectively set a config based on the path to the code of the current frame.
    #alternate_config = pretty_errors.config.copy()
    #pretty_errors.pathed_config(alternate_config, '/use/alternate/for/this/path')

    # Use to configure output:  Uncomment each line to change that setting.
    pretty_errors.configure(

        #always_display_bottom     = True,
        #arrow_head_character      = '^',
        #arrow_tail_character      = '-',
        #display_arrow             = True,
        #display_link              = False,
        display_locals            = True,
        #display_timestamp         = False,
        #display_trace_locals      = False,
        #exception_above           = False,
        #exception_below           = True,
        #filename_display          = pretty_errors.FILENAME_COMPACT,  # FILENAME_EXTENDED | FILENAME_FULL,
        #full_line_newline         = False,
        #infix                     = None,
        #inner_exception_message   = None,
        #inner_exception_separator = False,
        #line_length               = 0,
        line_number_first         = True,
        lines_after               = 3,
        lines_before              = 5,
        #postfix                   = None,
        #prefix                    = None,
        #reset_stdout              = False,
        #separator_character       = '-',
        #show_suppressed           = False,
        #stack_depth               = 0,
        #timestamp_function        = time.perf_counter,
        #top_first                 = False,
        #trace_lines_after         = 0,
        #trace_lines_before        = 0,
        truncate_code             = True,
        #truncate_locals           = True,
        #arrow_head_color          = '\x1b[1;32m',
        #arrow_tail_color          = '\x1b[1;32m',
        #code_color                = '\x1b[1;30m',
        #exception_arg_color       = '\x1b[1;33m',
        #exception_color           = '\x1b[1;31m',
        #exception_file_color      = '\x1b[1;35m',
        #filename_color            = '\x1b[1;36m',
        #function_color            = '\x1b[1;34m',
        #header_color              = '\x1b[1;30m',
        #line_color                = '\x1b[1;37m',
        #line_number_color         = '\x1b[1;32m',
        #link_color                = '\x1b[1;30m',
        #local_len_color           = '\x1b[1;30m',
        #local_name_color          = '\x1b[1;35m',
        #local_value_color         = '\x1b[m',
        #syntax_error_color        = '\x1b[1;32m',
        #timestamp_color           = '\x1b[1;30m',

        name = "custom"  # name it whatever you want
    )

### END PRETTY ERRORS
