IF(nrfjprog)
        add_custom_target(flash DEPENDS ${PROJECT_NAME}.hex 
                COMMAND nrfjprog -f NRF52 --program ${PROJECT_NAME}.hex --chiperase --verify
                COMMAND nrfjprog -f NRF52 --reset
        )
else()
        add_custom_target(flash
                COMMAND echo "nrfjprog not in path. Add to path and run cmake again."
        )
endif()

