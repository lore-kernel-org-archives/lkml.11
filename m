Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6F6C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 17:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiHQR16 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbiHQR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:27:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12E46A1A7F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:27:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB531063;
        Wed, 17 Aug 2022 10:27:53 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 174143F66F;
        Wed, 17 Aug 2022 10:27:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 0/6] Misc fixes for v5.20
Date:   Wed, 17 Aug 2022 18:27:25 +0100
Message-Id: <20220817172731.1185305-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

just a bunch of small unrelated fixes for v5.20.
Last one is marked as RFC since as explained it could be controversial.

Thanks,
Cristian

Cristian Marussi (6):
  firmware: arm_scmi: Fix missing kernel-doc in optee
  firmware: arm_scmi: Improve checks on .info_get operations
  firmware: arm_scmi: Harden accesses to Sensor domains
  firmware: arm_scmi: Harden accesses to Reset domains
  firmware: arm_scmi: Fix asynchronous reset requests
  [RFC] firmware: arm_scmi: Add SCMI PM driver remove routine

 drivers/firmware/arm_scmi/clock.c          |  6 +++++-
 drivers/firmware/arm_scmi/optee.c          |  1 +
 drivers/firmware/arm_scmi/reset.c          | 10 ++++++---
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 20 +++++++++++++++++
 drivers/firmware/arm_scmi/sensors.c        | 25 ++++++++++++++++++----
 include/linux/scmi_protocol.h              |  4 ++--
 6 files changed, 56 insertions(+), 10 deletions(-)

-- 
2.32.0

