return {
    RED = {
        MIG21 = {
            BASE = "#TMPL MIG-21 CAP",
            SIZE = 8,
            GROUP = 2,
            CAPABILITY = {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5},
            PAYLOADS = {
                ["#TMPL MIG-21 CAP"] = {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5}
            }
        },
        MIG23 = {
            BASE = "#TMPL MIG-23 CAP",
            SIZE = 8,
            GROUP = 2,
            CAPABILITY = {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5},
            PAYLOADS = {
                ["#TMPL MIG-23 CAP"] = {AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.CAP, AUFTRAG.Type.GCICAP, AUFTRAG.Type.ALERT5}
            }
        },
    },
    BLUE = {}
}