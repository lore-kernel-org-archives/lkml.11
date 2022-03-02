Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01347C43217
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 10:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbiCBKku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiCBKkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:40:42 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149EBECE4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:39:58 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a5so1549808pfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hSSYyjIeCQj/Yk471H+t4be62lPbXH733Ozer3TJP4=;
        b=JyG9DV8skFLWA/Riameo1pOnfP0U20+Dvh30cSsaSMOpc+vhdzlg5CjfLqN629EYdQ
         tX3v6gfw8yy7ZQTErKAB7PtNlyeOaYSPB5hx0vSqLuNBhbQ+ut0olipDjzD3O6JgKWBO
         5W4JiSd5xc4FTX/EyK9BGNwwOjXzzeKccQr7fZXSu8nlO+bqMCmZNX6QUHzkSCNmB63x
         fyJcbuFogdBqTAAYWk1XzfB6rHQPpwnYjy3kX9AyFmwp/0hRgHZoLFWTOLevuz6CNhi0
         d4wRBAN1gzG6/iJkMYYHGUFNsDy/Cxd0k5H09Z17+90EV93R3KXfEBIUnbGzKOlLFnGT
         6fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hSSYyjIeCQj/Yk471H+t4be62lPbXH733Ozer3TJP4=;
        b=V+3qPHyqXBbr1We+yhcx6Q8cXQiJVfIFChw+jCIOdqCKozczyLNIfUSXIruPjLIWM5
         lg7c3HnAYTe7g1yxQwUWOeJslGO1jCD8rJJP+NAEUuN95BvjXZOYP2F45/SlXjXzoiAA
         wPLKxCsYlnuzbysYLTMqx4XoThO407Qn0CK+U/IvuKlID3pe1I9+e4YsS5wemo1e69fX
         rF26fureOB1xDYdZJ9x2XiVuIP2+GfQix1Bj7vVhioXK2YaqHv/JPqwTMvzPAx1et0DW
         kPpLCQMewGCOg1lCSI0hNqy0TES4RcRCMkF62J8UeAS/OC6hYyX2NVx3kVJi2RFq0Oxp
         gnYQ==
X-Gm-Message-State: AOAM531P3AXSqRDHF+DLcHD2h7Fr5hYpT73oRZX7RlJgKQSP9zR29v3h
        vqf6JoON/5X+cdXxFdZxmQ95Rg==
X-Google-Smtp-Source: ABdhPJzUgJ792DPF3EApiJ3GaQ2Zj69A9UDb+Cj0BKYL2QF0NZYAbbkDZrH7d7ME28LWmmtZzJdK0g==
X-Received: by 2002:a05:6a00:1694:b0:4e1:5931:b040 with SMTP id k20-20020a056a00169400b004e15931b040mr31936664pfc.7.1646217598082;
        Wed, 02 Mar 2022 02:39:58 -0800 (PST)
Received: from localhost.localdomain ([171.50.175.145])
        by smtp.gmail.com with ESMTPSA id m20-20020a634c54000000b003739af127c9sm15612308pgl.70.2022.03.02.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 02:39:57 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     netdev@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 0/2 net-next] net: stmmac: Enable support for Qualcomm SA8155p-ADP board
Date:   Wed,  2 Mar 2022 16:09:48 +0530
Message-Id: <20220302103950.30356-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
-----------------
- v1 can be seen here: https://lore.kernel.org/netdev/20220126221725.710167-1-bhupesh.sharma@linaro.org/t/
- Fixed review comments from Bjorn - broke the v1 series into two
  separate series - one each for 'net' tree and 'arm clock/dts' tree
  - so as to ease review of the same from the respective maintainers.
- This series is intended for the 'net' tree.

The SA8155p-ADP board supports on-board ethernet (Gibabit Interface),
with support for both RGMII and RMII buses.

This patchset adds the support for the same.

Note that this patchset is based on an earlier sent patchset
for adding PDC controller support on SM8150 (see [1]).

[1]. https://lore.kernel.org/linux-arm-msm/20220226184028.111566-1-bhupesh.sharma@linaro.org/T/

Cc: David S. Miller <davem@davemloft.net>

Bjorn Andersson (1):
  net: stmmac: dwmac-qcom-ethqos: Adjust rgmii loopback_en per platform

Vinod Koul (1):
  net: stmmac: Add support for SM8150

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

-- 
2.35.1

