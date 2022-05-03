Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1471DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiECQvE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiECQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:51:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E42E0A6;
        Tue,  3 May 2022 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651596448; x=1683132448;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Bu+gi1IKKzqsNaPmOUoXWrJV8bORhpKC9d+myoSu9fk=;
  b=O16Z0N9rKqHm87LVN+TYNtoBkoKfzqean0duMLFpCZv8zGqhWfdPH451
   qK6DQCsT3YL4B45Ne5LGBC+l2MAhjhla8mrjxnuPc1u2cq0bRtOYeocuV
   fN2+uBgiPdYJb9QdWlruPy3hUwBbXfU02/E36Xf+UAx36lu+Bi/rurAP3
   k=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 May 2022 09:47:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 09:47:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 09:47:27 -0700
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 09:47:24 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
CC:     Rajendra Nayak <rnayak@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v1 0/3] Add support for audio clock gating resets for SC7280
Date:   Tue, 3 May 2022 22:16:32 +0530
Message-ID: <20220503164635.23876-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for clock gating resets for lpass audio clock controller and
also add support for external MCLKs for I2S.

Taniya Das (3):
  dt-bindings: clock: Add resets for LPASS audio clock controller for
    SC7280
  dt-bindings: clock: Add support for external MCLKs for LPASS on SC7280
  clk: qcom: lpass: Add support for resets & external mclk for SC7280

 .../clock/qcom,sc7280-lpasscorecc.yaml        | 10 ++++--
 drivers/clk/qcom/lpassaudiocc-sc7280.c        | 17 +++++++++-
 drivers/clk/qcom/lpasscorecc-sc7280.c         | 33 +++++++++++++++++++
 .../clock/qcom,lpassaudiocc-sc7280.h          |  5 +++
 .../clock/qcom,lpasscorecc-sc7280.h           |  2 ++
 5 files changed, 64 insertions(+), 3 deletions(-)

--
2.17.1

