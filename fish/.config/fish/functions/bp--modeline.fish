function bp--modeline
    echo
    banner--banner "Build" \
        && bp--with-context make -j6 modeline_demo mstnorm mstnorm_test \
        && banner--banner "Test" \
        && bp--with-context ./bin/mstnorm_test \
        && banner--banner "Modeline Demo" \
        && bp--with-context ./bin/modeline_demo \
        && banner--banner "MSTNorm progress demo (No CSV)" \
        && bp--with-context ./bin/mstnorm --pcaps $HHOME/optiq_equities_france_fbmu_1g--2022--06--23/*.pcap.zst --feeds optiq_equities_france_fbmu_1g --symbol-mapping-file $HHOME/optiq_equities_france_fbmu_1g--2022--06--23/OptiqMDG_Production_CashStandingDataFile_Equities_20220623.xml.gz --no-csv --progress
end
