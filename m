Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7234FC43217
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 09:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiEWJXi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 05:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiEWJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:23:33 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8CD1AF3F;
        Mon, 23 May 2022 02:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653297812; x=1684833812;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=NOm3tT8s+FVeZbLypi9zDeQ4MzTBMaDvwi44c+6B/9U=;
  b=SXx5ZBjJkZ/O0v/TuR9Ry55B9stDLkh1blUlh5j6IoY7MlFSwSz2loAh
   R3WJXNc5x5kpr5YlZ2S12ExkECCXdMMB4sBNj4GuCcxBi/LuRLmJ2f9ik
   OJrT5g2hrF9Q0axjd6KLrQDsowCZy6KzlUgvwG/vWBtip04j5/qY/+wsX
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 02:23:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 02:23:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 02:23:29 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 02:23:26 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v2 0/3] Add support for audio clock gating resets for SC7280
Date:   Mon, 23 May 2022 14:53:11 +0530
Message-ID: <20220523092314.14252-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for clock gating resets for lpass audio clock controller and
also add support for external MCLKs for I2S.

[v2]
  * Update/fix the YAML for reg property against each compatible.

[v1]
  * Add support for clock gating resets for lpass audio clock
    controller & MCLKs.

Taniya Das (3):
  dt-bindings: clock: Add resets for LPASS audio clock controller for
    SC7280
  dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
  clk: qcom: lpass: Add support for resets & external mclk for SC7280

 .../clock/qcom,sc7280-lpasscorecc.yaml        | 20 +++++++++--
 drivers/clk/qcom/lpassaudiocc-sc7280.c        | 17 +++++++++-
 drivers/clk/qcom/lpasscorecc-sc7280.c         | 33 +++++++++++++++++++
 .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++
 .../clock/qcom,lpasscorecc-sc7280.h           |  2 ++
 5 files changed, 73 insertions(+), 4 deletions(-)

--
2.17.1

