Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 15:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiDMP7y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDMP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:59:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4246350D;
        Wed, 13 Apr 2022 08:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649865449; x=1681401449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ES87OSBxlG40IumnNSe3tDebltkv7o6zRDRSKloQCJ4=;
  b=iXeK2kvbERUsFsESX8SLpKilNbAczEB4De47T6xrI/TLQpfzOkVskktq
   AERDGaSK+K6+CPag8DHDFry0Yk/yWE42CY+0VQbgu9MpTtBYIDZsd4pUl
   rEANC8Xtg/kw2Yj9H5drdmbWo7RuuZ1fs8cAAyNK7ae5N1+3VN5lm2A3y
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Apr 2022 08:57:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 08:57:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:57:08 -0700
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 08:57:07 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <loic.poulain@linaro.org>, <mani@kernel.org>,
        <quic_hemantk@quicinc.com>, <quic_bbhatt@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH v3 0/2] MHI MMIO register write updates
Date:   Wed, 13 Apr 2022 09:56:44 -0600
Message-ID: <1649865406-30198-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of MHI MMIO writes, the register field write function needs to do reads
before writes are performed. Propagate read failures such that callers are made
aware of those and can take appropriate action instead of running blind.

Optimizing the MMIO initialization function to use mhi_write_reg() in most cases
should also be done to improve design.

These patches were tested on X86_64 architecture with Ubuntu 18.04 and SDX65
attach.

v3:
Noticed this was reviewed but never picked up.  Rebased to -next

v2:
-Fix testbot reported missing set of changes from pm.c

Bhaumik Bhatt (2):
  bus: mhi: host: Bail on writing register fields if read fails
  bus: mhi: host: Optimize and update MMIO register write method

 drivers/bus/mhi/host/boot.c     | 21 +++++++++----
 drivers/bus/mhi/host/init.c     | 68 ++++++++++++++++++++++++-----------------
 drivers/bus/mhi/host/internal.h |  7 +++--
 drivers/bus/mhi/host/main.c     |  9 ++++--
 drivers/bus/mhi/host/pm.c       | 15 ++++++---
 5 files changed, 76 insertions(+), 44 deletions(-)

-- 
2.7.4

