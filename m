Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3296C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiCVWRq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 18:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbiCVWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530D54F92
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h16-20020a056902009000b00628a70584b2so15495073ybs.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v+NxYHkXHWjVO4PNbOTAVqrC0ZMmbKrhZhd7x0jggDI=;
        b=mE0EL6e1Fw7OYLCEfqt8cvrBe/km4//WG57F5jR3ixKkAeGSVpbuN+rmcVW60shPGL
         vHcxm9Vri8/G+NBRMZRnHjpSAbwrFqYbc75VDSVWjvkmTvGjJNq2FpQt5oGwqGxOfwiI
         feJUh5Gg1DNOhLJ1PVC3eqOrgyuR0rrah1mTac755l3/IApvS/za15epIAAoQ+gDFjNo
         PGbY3qhCBAtSob1yMh1eHEVyeT4YRFPa4hIASscSL4HMk0IS+SsSzRHRbLKgvykxIG7n
         ZeGQF28JO+uEijc/Eqq3gJTqiV7k7M54/iil2GaHsLn5ozpIuvzdcQ+eSkysxTTYYaK5
         Ut8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v+NxYHkXHWjVO4PNbOTAVqrC0ZMmbKrhZhd7x0jggDI=;
        b=px/yavcvo3FY+R9TPPsVaqjhxOQGNc9+cugo/is+MIeIPR1gSsRmZikCNm3q3kGgdW
         dhAZAjfETumtwh3fO9JkavTw2orPqlxWDYSoc1DbsQ/JB/w0EZgjgJGq8VH9/0pHsh++
         3OlxkDe1W5+mjR8jqK0BJFOQczH0K544GzO7QvKRRP2X1wwURj52FMVYTzfKXhLbEhBa
         QYKgHP4KbzT66UyxWjBoozROYV829KFuydjRkeuzA8nx6HXFUZy74GH3LPe8u7fW+DLb
         5E1GmTxSGo5mvbcPGi6x9MwrXVIvSg5BnvuMMLk3DHTyNeZGBJcceGnhcNjJkSAUPNOl
         +FVw==
X-Gm-Message-State: AOAM530U65r/8bxq7btLgE8qmAtWAFCIe+GPV61HS8PlM2hb1QN6+pkT
        VLQK0payHudCgzSM9jEHDevFSBjfCCPPz6m12JqglpusmhCiP/7TjGhkNEXtjHVZeY+dyeqPz1M
        SGFEYDBtjx3QWa/SmED+NxP5LLboYm8ehzYnSpNMhAAkKhhK0SK9pp/2x9hrhCkk5/WqRnjtQ
X-Google-Smtp-Source: ABdhPJzaoT4iLrTHYsXveucSjrRohNyigHNWvS5bZcxQB9lNPVLB4vr7DBkPm0o/TeQRZwfVLLYoJ+z1APDN
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a5b:2ca:0:b0:634:3ebd:de88 with SMTP id
 h10-20020a5b02ca000000b006343ebdde88mr4660444ybp.33.1647987349834; Tue, 22
 Mar 2022 15:15:49 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:14 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-11-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 10/13] perf tools: fix NULL point in evsel__env()
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

evsel_env() cannot return NULL. In case evsel->evlist->env is NULL default
to perf_env. Fixes crashes in evsel__open_strerror()

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 22d3267ce294..14b0e7ffa2c7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2965,7 +2965,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 struct perf_env *evsel__env(struct evsel *evsel)
 {
-	if (evsel && evsel->evlist)
+	if (evsel && evsel->evlist && evsel->evlist->env)
 		return evsel->evlist->env;
 	return &perf_env;
 }
-- 
2.35.1.894.gb6a874cedc-goog

