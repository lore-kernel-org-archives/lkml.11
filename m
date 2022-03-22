Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A35DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 03:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbiCVD3R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 23:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiCVD3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:29:00 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22987E9CB9;
        Mon, 21 Mar 2022 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647919654; x=1679455654;
  h=from:to:cc:subject:date:message-id;
  bh=eT1svF+SG9LLkAZp1i+Qgs6GpeoPG3FN+cWM/MwUTCQ=;
  b=sMJHK4AL/DWFvvf9yBhJjUsJOQ7/ZdDyMkiXS9P7hcZzQVMwxy+3QW36
   OLdqcSGUlFAkoFkLrbHJwEzAZXxHVl8LZZ5oPChXmZX4PL7NsUDKKUsSw
   GMmBrle5ApublesAUQxukTSze03HizVfUUPRDlyjU9cbjBQNE4Tluy7XH
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 20:27:33 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Mar 2022 20:27:31 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Mar 2022 08:57:13 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 24007541F; Tue, 22 Mar 2022 08:57:13 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v7 0/5] Update mdp clk to max supported value to support higher refresh rates
Date:   Tue, 22 Mar 2022 08:57:06 +0530
Message-Id: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the assigned clock rate property and vote on the mdp clock to
max frequency during bind/probe sequence.

Changes in v2:
- Remove assigned-clock-rate property and set mdp clk during
resume sequence.
- Add fixes tag.

Changes in v3:
- Remove extra line after fixes tag.(Stephen Boyd)
- Add similar changes for sc7180, sdm845 which uses opp table for
voting mdp clk.(Stephen Boyd)
- Drop patch: "drm/msm/disp/dpu1: set mdp clk to the maximum
frequency in opp table"

Changes in v4:
- Add similar change for sm8250.(Dmitry)

Changes in v5:
- Add change to set mdp clk to max frequency in opp table
during mdp probe/bind.

Changes in v6:
- Remove change log in dt patch.
- Fix the leak reference for opp by adding dev_pm_opp_put. (Dmitry)

Changes in v7:
- Update commit message and fix tag. (Stephen/Doug)

Vinod Polimera (5):
  drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table
    during probe
  arm64: dts: qcom: sm7280: remove assigned-clock-rate property for mdp
    clk
  arm64: dts: qcom: sm7180: remove assigned-clock-rate property for mdp
    clk
  arm64: dts: qcom: sdm845: remove assigned-clock-rate property for mdp
    clk
  arm64: dts: qcom: sm8250: remove assigned-clock-rate property for mdp
    clk

 arch/arm64/boot/dts/qcom/sc7180.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 9 ++-------
 arch/arm64/boot/dts/qcom/sm8250.dtsi    | 9 ++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
 5 files changed, 16 insertions(+), 28 deletions(-)

-- 
2.7.4

