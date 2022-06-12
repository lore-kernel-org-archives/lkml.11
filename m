Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97198C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jun 2022 09:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiFLJXI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jun 2022 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiFLJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 05:23:05 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5066AE5;
        Sun, 12 Jun 2022 02:23:03 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E0E5ECD3B3;
        Sun, 12 Jun 2022 09:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1655025752; bh=isvXvz151xa9quT3FHp3T0dcyI84C7Y5YBfGdMQhMmA=;
        h=From:To:Cc:Subject:Date;
        b=o9/ANSNedqRJigIQk70MGTfgaC+jNQhcvq9Bl0RmRLiqfBmZcK+iBTW4CC0os403e
         nQ1DJZ4+tjDtbExBe6brM1mH4UNWUq2ZZTnYV+9jv6ZVobjKgTW7vHz6ZG6ha9e0FP
         OCvhLYgAcJCsDUCkWTZlEQwvdPqduG5mXgkqftr0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] MDSS support for MSM8953
Date:   Sun, 12 Jun 2022 11:22:12 +0200
Message-Id: <20220612092218.424809-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the APPS IOMMU and the MDSS block for display that is
found on msm8953 SoCs.

Luca Weiss (1):
  dt-bindings: qcom-iommu: Add Qualcomm MSM8953 compatible

Vladimir Lypak (3):
  arm64: dts: qcom: msm8953: add APPS IOMMU
  drm/msm/mdp5: Add perf data for MDP v1.16
  arm64: dts: qcom: msm8953: add MDSS

 .../devicetree/bindings/iommu/qcom,iommu.txt  |   1 +
 arch/arm64/boot/dts/qcom/msm8953.dtsi         | 244 ++++++++++++++++++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c      |   5 +
 3 files changed, 250 insertions(+)

-- 
2.36.1

