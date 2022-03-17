Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C51C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 01:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347377AbiCQBIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbiCQBH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:07:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C871BEBD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:06:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mz9-20020a17090b378900b001c657559290so3846456pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uokqAmG9CvnWBx18M8Uu5r7m44QG1XAXLxISh4niXH4=;
        b=G/qUIQX7rNnf/j7R+SGiByuT42bQJGtLY3l77liJPfTnJO1jfwDEJWcaBW9AosRv7l
         L2u4vTKEVrsKGNL75pxwFzOsTelg8luWhtOUPfCCM4YITRL+P2AZ/0lkXGc54R35atGU
         AA45RAqrMYLhBTTvGiVhItGidvRxI1yJrGAjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uokqAmG9CvnWBx18M8Uu5r7m44QG1XAXLxISh4niXH4=;
        b=F5dPlPsGRxOvkLRBc7Q9t7BWL9GA8jfXhOyAZxXbhPgI90D8hqoVrbcAFAfcVk+NYq
         6zVM/2l5WPNF0Kd6xOXU1cAeEE/U5fyXsj85ReVFNDsQeuV/3MnsCbBFgPl2kdYo6uDj
         oZ50Bdl6Gxm5IxGojdZF/E0TK949PY7RntccuMbsTwjV3+nFBmwPssXA3Bj8iZ2gkXDy
         PMXxzNMCttri+kpuhP6pL9UX1Pj+N4oFeYLXJq11EgQeaq/qKRN/G1tsIL7yvCpt/OTU
         7ZEYj4RiDotE2gTrkwlW9j2mFdqLE8twaVaNPR3baPR5TRGfBPPh6XaXSTrz/II9bGK2
         xlqg==
X-Gm-Message-State: AOAM531lQKienz9T0rQBWji0HSBt8hAC5JkKT3Gil84xgyyFaN79zCkJ
        anUYyOtIMqAxwHYBuB/5RwBS9w==
X-Google-Smtp-Source: ABdhPJzAvRRtkqAYVjZZCxSdPvpMJTgeOGtla4pRkmCAu8bkr5QCbNHzposHvSFqPjWEvBZVuL5s0g==
X-Received: by 2002:a17:902:f545:b0:151:fa7a:7d57 with SMTP id h5-20020a170902f54500b00151fa7a7d57mr2162928plf.62.1647479202139;
        Wed, 16 Mar 2022 18:06:42 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dec5:e3f8:cbd7:f5a7])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a0008ce00b004f66dcd4f1csm5093923pfu.32.2022.03.16.18.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:06:41 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 0/2] Fix and update fingerprint flashing on herobrine
Date:   Wed, 16 Mar 2022 18:06:38 -0700
Message-Id: <20220317010640.2498502-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes fingerprint pins on herobrine so that the flashing
code is more reliable. Right now it fails depending on timings. The
second patch updates the node to be compliant with the new binding
being proposed.

This technically depends on the binding series[1] but only the second
patch. The first patch is a fix and should be merged at the earliest
convenience. Even the second patch could be merged and it would probably
be OK.

Stephen Boyd (2):
  arm64: dts: qcom: sc7280-herobrine: Drop outputs on fpmcu pins
  arm64: dts: qcom: Fully describe fingerprint node on Herobrine

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>

[1] https://lore.kernel.org/r/20220317005814.2496302-1-swboyd@chromium.org

base-commit: 1e49defb863638cde53e48805747271f80f9abec
-- 
https://chromeos.dev

