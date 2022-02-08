Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3032BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 01:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiBHBHq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343967AbiBHAR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:17:27 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BDDC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:17:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id s14so899615pfw.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qa8nRRq7La+ePNvAYQN25AB/Dkqw4RLGBac/uizNapc=;
        b=BYCyTLpFbAjJTU6RHckyUagUkCaBidw8jqLtHxiBGZ/TMfCh+6O/0Snj0cMZ1puh0S
         uYDNk0hTL+QekX34gKoIEa0F1tt4xC3CHNWKNfr9b0ETucRKUrr3yeblGqHNAUur7Bis
         bflpEEt3adM3BKkVN71bUHSUbIJXEC1hpB194=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qa8nRRq7La+ePNvAYQN25AB/Dkqw4RLGBac/uizNapc=;
        b=BhVI4v8e57IMxSLxotr2hogq23C6lTdDgQC1Y2G3x8sATHE9qDPCwbDXDPhvF2m9cq
         s1x8fLS4aMgX4kBSGSRr4yYZIMKbrl6ANie299nIjI4w0INTD4MpDB5f2DJKY8sjAtsK
         t29VluWK3vlVs1EFzJFbQXc+8D1mYKzVg4Bz+xmgTOrlUNfGcDDcW8R8bXTRht3eFc1c
         t6RNxYUAie0MNOOIiqUZ975eC9ykYEa5DDGkTu45FsQWObjoUeU7kujdjo9jGQXWIKz2
         slMeHxmI1pU2tt+DWPgkGOjCQbQ/D+a6gRYdlkScfS5tS94zyybfy25luyuXBIWG/OOv
         rnfg==
X-Gm-Message-State: AOAM533BDnS0GacIj7lN6AJHKOvLwVQ8tJGiKD/L9gco1fiNkkvQTKqc
        cY3wvcNlGbTdrM6LQ3ZAT3rSfQ==
X-Google-Smtp-Source: ABdhPJygKdc6xNR6j7YG2/jk9p/HVmxGlPDfdBoX3re4AlFyciQoFr9C4uvoSniH6pqktdxztYyKlw==
X-Received: by 2002:a63:b207:: with SMTP id x7mr1470669pge.392.1644279446187;
        Mon, 07 Feb 2022 16:17:26 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:6c4d:c442:5b4:f597])
        by smtp.gmail.com with ESMTPSA id mz4sm456185pjb.53.2022.02.07.16.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 16:17:25 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     quic_mkrishn@quicinc.com, linux-arm-msm@vger.kernel.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        robdclark@gmail.com, quic_khsieh@quicinc.com,
        quic_abhinavk@quicinc.com, linux-phy@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REPOST PATCH v1 0/3] Add support for eDP PHY on SC7280 platform
Date:   Mon,  7 Feb 2022 16:17:01 -0800
Message-Id: <20220208001704.367069-1-dianders@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a repost of the patch series that Sankeerth Billakanti posted
back in November. As Stephen pointed out [1] a few days ago, it wasn't
posted to the right place.

I've tested this and it seems to bring the eDP up on my sc7280 board,
so I'm re-posting it in the hopes that it can land soon-ish unless
there's something terribly wrong with it. ;-)

If it makes folks happier, I have no objections to Sankeerth's
original patches landing. These are the exact same thing but simply
with the addition of my Signed-off-by.

[1] https://lore.kernel.org/r/CAE-0n50sONq+URcWwvDH=UPshgy6+XZEB3sK_4n+5jNktHsEhg@mail.gmail.com


Sankeerth Billakanti (3):
  dt-bindings: phy: Add eDP PHY compatible for sc7280
  phy: qcom: Add support for eDP PHY on sc7280
  phy: qcom: Program SSC only if supported by sink

 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 4 +++-
 drivers/phy/qualcomm/phy-qcom-edp.c                     | 9 ++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.35.0.263.gb82422642f-goog

