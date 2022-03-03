Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F2FC4167D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 09:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiCCJlJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiCCJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:41:05 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D21712BD;
        Thu,  3 Mar 2022 01:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646300418; x=1677836418;
  h=from:to:cc:subject:date:message-id;
  bh=EBjaZbsbuI7Ljj+Uk54SccfcCiNfDd63cdNIDSZ55k8=;
  b=vWeXjukNbk2JQL41C/teS81YjZgIZmLqyJA4o5SOHqxDLUx4GELGHVDy
   Npv37lyPVN2pnKl+N778L3VXzzeBb2CKzwOD6nFmcTdZjBqGx++EUl6Yr
   4Ac8F9jq3tYFxKufw31W0RrEBrQ2dVfIPQgtUvVf2LFviudpbK59PdoLv
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 03 Mar 2022 01:40:18 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 03 Mar 2022 01:40:16 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 03 Mar 2022 15:10:04 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 86B7D3565; Thu,  3 Mar 2022 15:10:03 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v4 0/4] Update mdp clk to max supported value to support higher refresh rates
Date:   Thu,  3 Mar 2022 15:09:57 +0530
Message-Id: <1646300401-9063-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel clock driver assumes that initial rate is the
max rate for that clock and was not allowing it to scale
beyond the assigned clock value.

Drop the assigned clock rate property and vote on the mdp clock as per
calculated value during the usecase.

Changes in v2:
- Remove assigned-clock-rate property and set mdp clk during resume sequence.
- Add fixes tag.

Changes in v3:
- Remove extra line after fixes tag.(Stephen Boyd)
- Add similar changes for sc7180, sdm845 which uses opp table for voting mdp clk.(Stephen Boyd)
- Drop patch: "drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table"

Changes in v4:
- Add similar change for sm8250.(Dmitry)

Vinod Polimera (4):
  arm64/dts/qcom/sc7280: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sc7180: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sdm845: remove assigned-clock-rate property for mdp clk
  arm64/dts/qcom/sm8250: remove assigned-clock-rate property for mdp clk

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 9 ++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 ++-------
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 9 ++-------
 4 files changed, 8 insertions(+), 28 deletions(-)

-- 
2.7.4

