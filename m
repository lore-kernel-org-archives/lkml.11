Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C10C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 09:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbiCJJyU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbiCJJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:54:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667149CA4;
        Thu, 10 Mar 2022 01:52:52 -0800 (PST)
Received: from zn.tnic (p200300ea97193878fa50b3d92789953a.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:fa50:b3d9:2789:953a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE0BF1EC01B7;
        Thu, 10 Mar 2022 10:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646905971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=54g/KLNxFZUCNgDdfbbvQe9FV9KHLwA0GlD8+QFm/ew=;
        b=seF945U41RIEfNSDGl8769zQRFeRffsGu/9/qujHfZ/05wE1KjfQ53sliy++nvBbrp3C+C
        p8dl5D04xClU7O/biMarlMwNQaAQWvfqK5KQ+w+YervOYHJOP4BkvdOncvz1XTUASy1ZP1
        2IaGn7NphOW5yJvPlOCPN1YVT1Den8o=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] EDAC: Remove edac_align_ptr()
Date:   Thu, 10 Mar 2022 10:52:49 +0100
Message-Id: <20220310095254.1510-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

this edac_align_ptr() thing was part of the original EDAC upstreaming
effort in 2006:

  da9bb1d27b21 ("[PATCH] EDAC: core EDAC support code")

Comment above the usage says:

"Everything is kmalloc'ed as one big chunk - more efficient."

but I don't think that "efficiency" is measurable anymore. Then, 15+
years ago probably.

So get rid of it in favor of simple kzalloc() allocations for the couple
of structures needed at each call site.

It boots fine here with amd64_edac but I'd greatly appreciate testing
with other EDAC drivers.

Thx!

Borislav Petkov (5):
  EDAC/mc: Get rid of silly one-shot struct allocation in
    edac_mc_alloc()
  EDAC/pci: Get rid of the silly one-shot memory allocation in
    edac_pci_alloc_ctl_info()
  EDAC/device: Get rid of the silly one-shot memory allocation in
    edac_device_alloc_ctl_info()
  EDAC/device: Sanitize edac_device_alloc_ctl_info() definition
  EDAC/mc: Get rid of edac_align_ptr()

 drivers/edac/edac_device.c       | 135 +++++++++++++------------------
 drivers/edac/edac_device.h       |  14 ++++
 drivers/edac/edac_device_sysfs.c |   5 +-
 drivers/edac/edac_mc.c           |  96 +++-------------------
 drivers/edac/edac_module.h       |   2 -
 drivers/edac/edac_pci.c          |  25 +++---
 6 files changed, 95 insertions(+), 182 deletions(-)

-- 
2.29.2

