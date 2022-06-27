Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FA9CCA481
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 19:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbiF0Tou (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiF0Tot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:44:49 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB419026;
        Mon, 27 Jun 2022 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656359087; x=1687895087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EKcrWv1hq/h1NGE3SQ79xrzHsQ93vU4b2aszg+ojf1c=;
  b=fGEhRVGUIjMIudqUUa0aLDMqwLKzx5iighcz29t594Oag70d/NBx5/pi
   R67oe+fl4JYHrXOv3mZx7OnKm/I4gqmX7OGKy0mNMdhGap2+f9w5Bd34c
   H/xCJNrnNQRnT1MC3MxVnfVpCTxxl9QUYvzjLhpw84FYhQN5LPouZANjH
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 12:44:47 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 12:44:47 -0700
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 12:44:47 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH 0/5] SCM: Add support for wait-queue aware firmware
Date:   Mon, 27 Jun 2022 12:44:31 -0700
Message-ID: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the QCOM SCM driver to support firmware (FW) versions
that expect the high-level OS (HLOS) to be tolerant of SCM call requests not
being processed right away and, instead, being placed on a wait-queue in FW and
processed accordingly.

The problem this feature is fixing is as follows. In a scenario where there is
a VM in addition to HLOS (and an underlying hypervisor):

1. HLOS makes an SMC call on core 5
2. The hypervisor scheduling interrupt interrupts this SMC call.
3. The hypervisor schedules the VM on core 5.
4. The VM makes an SMC call on core 5.
5. The SMC call is non-interruptibly stuck on FW spinlock on core 5.
6. HLOS cannot reschedule since core 5 is not responding to Reschedule IPIs.
7. Watchdog timer expires waiting for core 5.

This problem is solved by FW returning a new return code SCM_WAITQ_SLEEP to
HLOS right away when it is overwhelmed by the VM's SMC call. HLOS then places
the call on a wait-queue and wakes it up when it receives an interrupt that
signifies "all-clear".

This new design also supports scenarios involving only HLOS (and no other VMs).
Such scenarios make use of a second new return code SCM_WAITQ_WAKE.

There are three new SMC calls also being defined in this design that, together
with the two new return codes, form the handshake protocol between Linux and
FW.

This design is also backwards-compatible with existing firmware versions that
do not support this feature.

Guru Das Srinagesh (5):
  dt-bindings: firmware: qcom-scm: Add "allow-multi-call" property
  firmware: qcom: scm: Optionally remove SCM call serialization
  dt-bindings: firmware: qcom-scm: Add optional interrupt
  firmware: qcom: scm: Add wait-queue helper functions
  firmware: qcom: scm: Add wait-queue handling logic

 .../devicetree/bindings/firmware/qcom,scm.txt      |   4 +
 drivers/firmware/qcom_scm-smc.c                    | 143 +++++++++++++++++++--
 drivers/firmware/qcom_scm.c                        | 124 +++++++++++++++++-
 drivers/firmware/qcom_scm.h                        |  14 ++
 4 files changed, 275 insertions(+), 10 deletions(-)

-- 
2.7.4

